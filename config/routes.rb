DxrubyApis::Application.routes.draw do
  root 'application#index', locale: 'ja'
  get '/:locale/' => 'application#index'
end
