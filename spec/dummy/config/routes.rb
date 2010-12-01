Dummy::Application.routes.draw do
  match ':controller(/:action(/:id(.:format)))'
  root :to => "application#index"
end