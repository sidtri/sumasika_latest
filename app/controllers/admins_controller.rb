class AdminsController < ApplicationController
	before_action :checkuser
  before_action :checkadmin

  def index
   redirect_to admin_pending_path
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

  def approve
    @syn = Synthesize.find(params[:baser])
    @syn.status = "complete"
    redirect_to admin_pending_path if @syn.save
  end

end
