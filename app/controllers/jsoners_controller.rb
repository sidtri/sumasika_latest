class JsonersController < ApplicationController
  def ghana
  	currency = params[:currency]
  	money = params[:money]
  	@ghs= GoogCurrency.send("#{params[:currency]}_to_ghs",1)
    render json: @ghs
  end

  def dollars
  	currency = params[:currency]
  	money = params[:money]
  	@usd= GoogCurrency.send("#{params[:currency]}_to_usd",params[:money])
  	render json: @usd
  end

  def euro
    currency = params[:currency]
    money = params[:money]
  
    @euro= GoogCurrency.send("#{params[:currency]}_to_eur",params[:money])
    render json: @euro
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

  def valid
    mtn = params[:mtn] 
    result = Phonelib.valid? mtn
    render text: result
  end
end
