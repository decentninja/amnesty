require "net/http"

class AuthenticationsController < ApplicationController
  skip_before_filter :authenticate!
  skip_before_filter :amnesty_admin

  def callback
    response = Net::HTTP.get_response(URI("#{ENV['LOGIN_ENDPOINT']}/verify/#{params[:token]}.json"))
    if response.is_a?(Net::HTTPSuccess)
      return_to = session[:return_to]
      reset_session
      session[:current_user] = JSON.parse(response.body)['user']
      redirect_to return_to
    else
      render text: 'lol nej'
    end
  end

  def logout
    reset_session
    redirect_to "#{ENV['LOGIN_ENDPOINT']}/logout"
  end
end