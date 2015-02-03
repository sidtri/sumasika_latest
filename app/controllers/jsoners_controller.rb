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

  def sendmsg
    mtn = "+" + params[:mtn]
    @client = Twilio::REST::Client.new 
    @request=@client.account.messages.create({
        :from => '+15005550006', 
        :to => mtn,  
        :body => 'test msg body' 
    })
 
    render text: @request.status
  rescue Twilio::REST::RequestError
    render text: false

  end
end
