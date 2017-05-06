class Invitation < ActiveRecord::Base
  include Tokenable

  belongs_to :inviter, class_name: "User"

  validates_presence_of :recipient_email
  validates_presence_of :recipient_name
  validates_presence_of :message

  before_create :generate_token

end