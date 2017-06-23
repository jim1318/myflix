class UserSignup

  attr_reader :error_message

  def initialize(user)
    @user = user
  end

  def sign_up(stripe_token, invitation_token)
    if @user.valid?               #valid won't save data - will only check if it's valid
      
      customer = StripeWrapper::Customer.create(
        :email => @user.email,
        :token => stripe_token
      )

      if customer.successful?
        subscription = StripeWrapper::Subscription.create(
          :customer => customer.response,
        )
      else
        @status = :failed
        @error_message = customer.error_message
        return self
      end

      if subscription.successful?
        @user.customer_token = customer.customer_token
        @user.active = true
        @user.save
        handle_invitation(invitation_token)
        SendWelcomeEmail.perform_async(@user.id)
        @status = :success
        self
      else
        @status = :failed
        @error_message = subscription.error_message
        self
      end  
    else
      @status = :failed
      @error_message = "Please fix user errors"
      self
    end
  end

  def successful?
    @status == :success
  end

  private

  def handle_invitation(invitation_token)
    if invitation_token.present?
      invitation = Invitation.where(token: invitation_token).first
      @user.follow(invitation.inviter)
      invitation.inviter.follow(@user)
      invitation.update_column(:token, nil)
    end
  end

end