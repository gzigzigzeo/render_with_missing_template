module RenderWithMissingTemplate
  class Railtie < ::Rails::Railtie
    initializer "render_with_missing_template.on_controller" do |app|
      ActiveSupport.on_load :action_controller do
        ::ActionController::Base.send(:include, RenderWithMissingTemplate::ActionController)
      end  
    end

    initializer "render_with_missing_template.on_view" do |app|
      ActiveSupport.on_load :action_view do
        ::ActionView::Base.send(:include, RenderWithMissingTemplate::ActionView)
      end  
    end
  end
end