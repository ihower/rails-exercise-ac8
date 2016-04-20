class Payment < ActiveRecord::Base

  serialize :params, JSON

  belongs_to :order

  before_validation :setup_amount

  after_update :update_order_status

  validate :check_mac, on: :update

  def name
    "ALPHACAMP #8 #{self.order.name}"
  end

  def external_id
    "#{self.id}AC#{Rails.env.upcase[0]}"
  end

  def email
    order.email
  end

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

  protected

  def check_mac
    parse_result = JSON.parse( self.params['Result'] )
    pay2go = Pay2go.new(parse_result)
    errors.add(:params, 'wrong mac value') unless pay2go.check_mac
  end

  def setup_amount
    self.amount = self.order.amount
  end

  def update_order_status

    if self.paid && !self.order.paid?
      order.paid = true
      order.save( :validate => false )
    end

  end

end
