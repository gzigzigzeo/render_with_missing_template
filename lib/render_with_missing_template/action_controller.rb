module RenderWithMissingTemplate
  module ActionController
    extend ActiveSupport::Concern

    included do
      alias_method_chain :render, :defaults
    end      
    
    module InstanceMethods
      # This is needed because options for ActionController::Renderable::Render are different
      # with ActionView::Renderable::Render. They should be overriden by different defaults.
      def render_with_defaults(*args)
        options = args.extract_options!
        defaults = options.delete(:if_missing)
        unless defaults.nil?
          begin
            render_without_defaults options
          rescue ::ActionView::MissingTemplate 
            unless defaults == false
              render_without_defaults(defaults)
            else
              render_without_defaults :nothing => true
            end
          end
        else
          render_without_defaults options
        end
      end        
    end    
  end
end