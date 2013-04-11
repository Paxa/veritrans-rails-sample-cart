class VeritransController < ApplicationController
  protect_from_forgery :except => [:unfinish, :notification, :finish, :error]

  BILLING_SAME_ADDRESS = "0"        #'0':Same shipping address  
  BILLING_DIFFERENT_ADDRESS = "1"   #'1':Different Address with shipping  

  NOT_REQUIRED_SHIPPING_ADDRESS = "0"   #'0':Not required shipping address
  REQUIRED_SHIPPING_ADDRESS = "1"       #'1':Required shipping address  

  # post action after user submit checkout-form 
  # Ex POST:
  # {"gross_amount" => "7000000",
  #  "commodity"=>[
  #    {
  #    "COMMODITY_ID"    => "Espirit", 
  #    "COMMODITY_PRICE"  => "500000",
  #    "COMMODITY_QTY"   => "4",
  #    "COMMODITY_NAME1" => "Espirit"
  #    },
  #    {
  #    "COMMODITY_ID"    => "Tablet", 
  #    "COMMODITY_PRICE"  => "2500000",
  #    "COMMODITY_QTY"   => "2",
  #    "COMMODITY_NAME1" => "Tablet"
  #    }]}
  # Return from get_keys: 
  # TOKEN_MERCHANT = dYWRjRr2ZbJEqMQaqDLIaWeoLl1Tuk3g7g3T1gKGrE5ibYJoZ4
  # TOKEN_BROWSER  = lh4TxpAyB2NhrKTlqGbW1LRPoA6RgyI6roJ2EIII6J29j7gYoP
  def confirm
    puts params.inspect
    client = ::Veritrans::Client.new
    client.order_id     = SecureRandom.hex(5)
    client.session_id   = "session#{(0...12).map{65.+(rand(25))}.join}"

    # Example 
    @carts = Cart.all
    @total = Cart.select(:sub_total).sum(:sub_total)
    
    params["commodity"] = []

    @carts.each do |item|
      params["commodity"] << { "commodity_id" => item.product_id, "commodity_num" => item.product.price.to_s, "commodity_qty" => item.quantity.to_s, 
                                "commodity_name1" => item.product.name, "commodity_name2" => item.product.name }      
    end
    
    client.gross_amount = Cart.select(:sub_total).sum(:sub_total).to_s
    client.commodity    = params["commodity"]

    client.billing_address_different_with_shipping_address = BILLING_DIFFERENT_ADDRESS
    client.required_shipping_address = REQUIRED_SHIPPING_ADDRESS

    client.shipping_first_name    = params[:shipping_first_name]
    client.shipping_last_name     = params[:shipping_last_name]
    client.shipping_address1      = params[:shipping_address1]
    client.shipping_address2      = params[:shipping_address2]
    client.shipping_city          = params[:shipping_city]
    client.shipping_country_code  = "IDN"
    client.shipping_postal_code   = params[:shipping_postal_code]
    client.shipping_phone         = params[:shipping_phone]
    
    client.shipping_email = params[:shipping_email] # notification email

    client.get_keys
    @client = client
    p @client.token
    render :layout => 'application'
  end

  # post-redirection from Veritrans to Merchants Web
  # Ex: {"orderId"  =>"dummy877684698685878869896765",
  #      "sessionId"=>"session837985748788668181718189"}
  def unfinish
    # logic after user cancel the transaction
  end

  # Server to Server post-notification(action) from Veritrans to Merchants Server 
  # Ex: {"mErrMsg"=>"",
  #      "orderId"=>"dummy877684698685878869896765",
  #      "mStatus"=>"success",
  #      "vResultCode"=>"C001000000000000",
  #      "TOKEN_MERCHANT"=>"dYWRjRr2ZbJEqMQaqDLIaWeoLl1Tuk3g7g3T1gKGrE5ibYJoZ4"}
  def notification
    render :text => "OK"  
  end

  # post-redirection from Veritrans to Merchants Web
  # Ex: {"orderId"=>"dummy877684698685878869896765",
  #      "mStatus"=>"success",
  #      "vResultCode"=>"C001000000000000",
  #      "sessionId"=>"session837985748788668181718189"}
  def finish
    # logic after success transaction accured
  end

  # need scenario that could be try
  # post-redirection from Veritrans to Merchants Web
  # Ex: {"orderId"=>"dummy877684698685878869896765",
  #      "mStatus"=>"failure",
  #      "vResultCode"=>"NH13000000000000",
  #      "sessionId"=>"session837985748788668181718189"}
  def error
    # logic after error transaction accured
    render :text => "ERROR"
  end

end