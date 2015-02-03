class AdminsController < ApplicationController
	before_action :checkuser
  before_action :checkadmin

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

  def activation
    @memberdetails=Manager.where("active=?",false)
  end

  def approved
    if !params[:uid].nil?
      @details=Manager.find_by_id(params[:uid])
      @active=Manager.find_by_id(params[:uid]).update(:active => 'true')
      if @active
        redirect_to admin_activation_path, :flash => { :error => "#{@details.first_name} Activated sucessfully" }
      end
    end
  end

  def pending
  	@details = Synthesize.where('status=?','charged')
  	if @details.class == Synthesize
  		@details = [@details] 
  	end
  end

  def approve
    @syn = Synthesize.find(params[:baser])
    @syn.status = "complete"
    redirect_to admin_past_path if @syn.save
  end

end
