module RenderWithMissingTemplate
  module ActionController
    extend ActiveSupport::Concern

    included do
      alias_method_chain :render, :defaults
    end      
    
    module InstanceMethods
      # ActionController::render overload is needed because ActionController::render have different
      # signature and accepts different options.      
      def render_with_defaults(*args)
        options = args.extract_options!
        defaults = options.delete(:if_missing)
        unless defaults.nil?
          begin
            # Ac is important:
            #   index/index.html.erb
            #     render "missing_partial" # MissingTemplate is raised here
            #
            #   index_controller.rb
            #     def index
            #       render :if_missing => {:template => "layouts/create_me"} # And caught here
            #     end
            #
            # In fact MissingTemplate in a view should not be caught by controller because controller's template exists, but
            # it have errors inside. :nested option tells nested render to raise MissingTemplateContrainer exception instead of
            # raising MissingTemplate. This exception means that action template is resolved, but some of nested partials are not.
            render_without_defaults(options.merge(:nested => true))
          rescue MissingTemplateContainer => e
            unless defaults == false
              defaults = options.merge(defaults)
              render_without_defaults(defaults)
            else
              render_without_defaults(:nothing => true)
            end
          end
        else
          render_without_defaults options
        end
      end        
    end    
  end
end