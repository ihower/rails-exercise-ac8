class Payment < ActiveRecord::Base

  serialize :params, JSON

  belongs_to :order

  def self.find_and_process(params)
    result = JSON.parse( params['Result'] )

    payment = self.find(result['MerchantOrderNo'].to_i)
    payment.paid = params['Status'] == 'SUCCESS'
    payment.params = params
    payment
  end

  def deadline
    Time.now + 3.days
  end

end
