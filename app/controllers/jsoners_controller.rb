class JsonersController < ApplicationController
  def ghana
  	
  	currency = params[:currency]
  	money = params[:money]
  	@ghs= GoogCurrency.send("#{params[:currency]}_to_ghs",params[:money])
  	render json: @ghs
  	
  end

  def dollars
  	currency = params[:currency]
  	money = params[:money]
  	@usd= GoogCurrency.send("#{params[:currency]}_to_usd",params[:money])
  	render json: @usd
  end
end
