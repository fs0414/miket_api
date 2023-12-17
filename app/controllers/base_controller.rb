class BaseController < ApplicationController

  protected

  def not_authenticated
    redirect_to login_url
  end
end
