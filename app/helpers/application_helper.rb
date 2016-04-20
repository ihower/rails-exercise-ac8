module ApplicationHelper

  def generate_pay2go_params(payment)
      pay2go_params = {
        MerchantID: "31816935",
        RespondType: "JSON",
        TimeStamp: payment.created_at.to_i,
        Version: "1.2",
        LangType: "zh-tw",
        MerchantOrderNo: "#{payment.id}AC#{Rails.env.upcase[0]}",
        Amt: payment.order.amount,
        ItemDesc: "Order #{payment.order.id}",
        ReturnURL: "http://localhost:3000/pay2go/return",
        NotifyURL: "http://ihower.tw",
        Email: payment.order.email,
        LoginType: 0,
        CREDIT: 0,
        WEBATM: 0,
        VACC: 0,
        CVS: 0,
        BARCODE: 0
      }

      case payment.payment_method
        when "Credit"
          pay2go_params.merge!( :CREDIT => 1 )
        when "WebATM"
          pay2go_params.merge!( :WEBATM => 1 )
        when "ATM"
          pay2go_params.merge!( :VACC => 1, :ExpireDate => payment.deadline.strftime("%Y%m%d") )
        when "CVS"
          pay2go_params.merge!( :CVS => 1, :ExpireDate => payment.deadline.strftime("%Y%m%d") )
        when "BARCODE"
          pay2go_params.merge!( :BARCODE => 1, :ExpireDate => payment.deadline.strftime("%Y%m%d") )
      end

      raw = pay2go_params.slice(:Amt, :MerchantID, :MerchantOrderNo, :TimeStamp, :Version).sort.map!{|ary| "#{ary.first}=#{ary.last}"}.join('&')
      hash_key = "vxFkrqnqSGNxY876Hkncc7GjuDIJZgYv"
      hash_iv = "OEPf4dGWUtuSCCYj"
      str = "HashKey=#{hash_key}&#{raw}&HashIV=#{hash_iv}"
      check_value = Digest::SHA256.hexdigest(str).upcase

      pay2go_params[:CheckValue] = check_value

      pay2go_params
  end

end
