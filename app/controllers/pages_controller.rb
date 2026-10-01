class PagesController < ApplicationController
  # Shows the form. When the form is submitted, the same action runs again
  # with the typed text in params[:text].
  def home
    @stats = TextStats.new(params[:text])
  end
end
