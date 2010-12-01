module RenderWithMissingTemplate
  module ActionView    
    extend ActiveSupport::Concern

    included do
      alias_method_chain :render, :defaults
    end      
        
    module InstanceMethods
      RENDER_KEYS = [:partial, :text, :template, :file, :inline]
      
      def render_with_defaults(options = {}, locals = {}, &block)
        if options.is_a?(Hash)
          defaults = options.delete(:if_missing)
        elsif locals.is_a?(Hash)
          defaults = locals.delete(:if_missing)
        end
        
        # Prevents replacing :if_missing => false with empty hash.
        defaults ||= {} unless defaults == false
        
        unless defaults.nil?          
          begin
            render_without_defaults(options, locals, &block)
          rescue ::ActionView::MissingTemplate 
            unless defaults == false
              new_options = defaults
              if options.is_a?(Hash)
                new_options = defaults.reverse_merge(options)
                
                # If user does something like
                #  render :partial => "test", :locals => {:temp => 1}, :if_missing => {:template => "missing"}
                # We should replace :partial => "test" with :template => "missing" and keep :locals.

                # Determine that render options have two template reference keys.
                render_keys = RENDER_KEYS.map { |k| k if new_options.include?(k) }.compact                
                if render_keys.size > 1
                  # And delete unneccessary keys from default options.
                  new_options = new_options.delete_if { |k, v| render_keys.include?(k) && options.include?(k) }
                end
              end
              render_without_defaults(new_options, locals, &block)
            end
          end
        else
          render_without_defaults(options, locals, &block)
        end
      end        
    end    
  end
end