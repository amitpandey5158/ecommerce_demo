module Payment

	class RazorpayPayments

    require 'razorpay'
    Razorpay.setup(ENV['razorpay_id'], ENV['razorpay_secret_key'])

	  def create_order(amount, receipt)	
	  	Razorpay::Order.create(amount: amount*100, currency: 'INR', receipt: receipt)
	  end

	  def verify_payment(res)
	  	Razorpay::Utility.verify_payment_signature(res)
	  end

	  def capture_payment(razorpay_payment_id, para_attr)
	  	Razorpay::Payment.capture(razorpay_payment_id, para_attr)
	  end
	  
	end
	
end	