DxrubyApis::Application.routes.draw do
  root 'application#index'
  get '/:locale/',to: 'application#index'
  post '/:locale/up', to: 'application#up'
  post '/:locale/down', to: 'application#down'
end
