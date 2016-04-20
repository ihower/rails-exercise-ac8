module ApplicationHelper

  def generate_pay2go_params(payment)
      pay2go_params = {
        MerchantID: Pay2go.merchant_id,
        RespondType: "JSON",
        TimeStamp: payment.created_at.to_i,
        Version: "1.2",
        LangType: I18n.locale.downcase, # zh-tw or en
        MerchantOrderNo: payment.external_id,
        Amt: payment.amount,
        ItemDesc: payment.name,
        ReturnURL: pay2go_return_url,
        NotifyURL: Pay2go.notify_url,
        Email: payment.email,
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

      pay2go = Pay2go.new(pay2go_params)
      pay2go_params[:CheckValue] = pay2go.make_check_value
      pay2go_params
  end

end
