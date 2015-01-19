class AdminsController < ApplicationController
	before_filter :authenticated
	before_filter :checkadmin 
  def index
  	
  end

  def past
  	@details = Synthesize.find_by_status('complete')
  	if @details.class == Synthesize
  		@details = [@details] 
  	end
  end

  def show
  	@detail = Synthesize.find(params[:id])
  end

  def pending
  	@details = Synthesize.find_by_status('pending')
  	if @details.class == Synthesize
  		@details = [@details] 
  	end
  end
end
