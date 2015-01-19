class AdminsController < ApplicationController
  def index
  	@details = Synthesize.all
  end
end
