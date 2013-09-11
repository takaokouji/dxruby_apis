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

  def up
    f = get_feedback(params[:method_name])
    if f
      Feedback.increment_counter(:up, f.id)
    else
      raise 'Method Not Found.'
    end
    render json: f.reload.up
  end

  def down
    f = get_feedback(params[:method_name])
    if f
      Feedback.increment_counter(:down, f.id)
    else
      raise 'Method Not Found.'
    end
    render json: f.reload.down
  end

  private

  def dxruby_apis
    return @dxruby_apis ||=
      YAML.load(Rails.root.join('app/assets/dxruby_api.yml').read)
  end

  def get_feedback(method_name)
    f = Feedback.where(method_name: params[:method_name]).first
    if !f
      c, s, m = *method_name.split(/([.#])/, 2)
      if s == '.'
        m = '.' + m
      end
      if (cms = dxruby_apis[c]) && cms.key?(m)
        f = Feedback.create!(method_name: params[:method_name], up: 0, down: 0)
      end
    end
    return f
  end

  def default_url_options(options = {})
    return { locale: I18n.locale }
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
