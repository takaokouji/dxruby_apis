DxrubyApis::Application.routes.draw do
  root 'application#index'
  post '/up', to: 'application#up', locale: I18n.default_locale
  post '/down', to: 'application#down', locale: I18n.default_locale
  get '/:locale/',to: 'application#index'
  post '/:locale/up', to: 'application#up'
  post '/:locale/down', to: 'application#down'
end
