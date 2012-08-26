class ApplicationController < ActionController::Base
  include ActionView::Helpers::TextHelper
  protect_from_forgery

  after_filter :errors_to_flash

  def errors_to_flash
    if defined? resource and !resource.nil? and resource.errors
      flash[:alert] = resource.errors.full_messages.join('<br />')
    end
  end
end
