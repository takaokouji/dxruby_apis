# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale

  def index
    @dxruby_apis = YAML.load(Rails.root.join('app/assets/dxruby_api.yml').read)
    @feedback = {}
    Feedback.all.each do |f|
      @feedback[f.method_name] = f
    end
  end

  private

  def default_url_options(options = {})
    return { locale: I18n.locale }
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
