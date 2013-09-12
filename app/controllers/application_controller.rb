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

  def num_methods
    if !@num_methods
      @num_methods = { windows: 0, mac: 0, linux: 0 }
      dxruby_apis.each do |klass, methods|
        methods.each do |method, property|
          next if property && property['status'].try(:downcase) == 'removed'
          @num_methods[:windows] += 1
          if !property || !property['progress']
          elsif property['progress'].downcase == 'done'
            @num_methods[:mac] += 1
          else
            @num_methods[:mac] += 0.5
          end
          if !property || (property.key?('linux_progress') && !property['linux_progress']) || !property['progress']
          elsif (property['linux_progress'] || property['progress']).downcase == 'done'
            @num_methods[:linux] += 1
          else
            @num_methods[:linux] += 0.5
          end
        end
      end
    end
    return @num_methods
  end
  helper_method :num_methods

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

  AVAILABLE_LOCALES = ['ja', 'en']
  private_constant :AVAILABLE_LOCALES

  def set_locale
    locale = (params[:locale] || I18n.default_locale).to_s
    if !AVAILABLE_LOCALES.include?(locale)
      redirect_to File.join(root_path, I18n.default_locale.to_s, '')
      return
    end

    if request.path == '/'
      redirect_to File.join(root_path, locale, '')
    else
      I18n.locale = locale
    end
  end
end
