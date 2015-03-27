require 'pundit'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_filter :authenticate!


  def current_user
    return @current_user if @current_user.present?
    return unless session[:current_user].present?
    @current_user = Student.find_or_create_from_ldap(ugid: session[:current_user])
  end

  def authenticate!
    redirect_to_login unless current_user.present?
  end

  def redirect_to_login
    if ENV['OFFLINE_DEV']
      session[:current_user] = 'developer'
    else
      set_return_to
      uri = URI session[:return_to]
      return_to = "http://#{uri.host}:#{uri.port}/callback/"
      redirect_to "#{ENV['LOGIN_ENDPOINT']}/login?callback=#{CGI.escape return_to}"
    end
  end

  def set_return_to
    uri = URI(request.original_url)
    session[:return_to] = uri.to_s
  end
end