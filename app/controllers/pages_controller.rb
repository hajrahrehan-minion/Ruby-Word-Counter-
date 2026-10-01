class PagesController < ApplicationController
  def home
    @stats = TextStats.new("")
  end

  def count
    @stats = TextStats.new(params[:text])

    respond_to do |format|
      format.turbo_stream
      format.html { render :home }
    end
  end
end
