# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :session_token, presence: true
  validates :password_digest, presence: { message: "Password can't be blank!" }
  validates :username, uniqueness: true, presence: true

  has_many :subs,
    foreign_key: :moderator_id,
    inverse_of: :moderator #dependent destroy?????

  has_many :posts,
    class_name: "Post",
    foreign_key: :author_id,
    inverse_of: :author

  has_many :comments,
    class_name: "Comment",
    foreign_key: :author_id,
    inverse_of: :author

  after_initialize :ensure_session_token

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def password=(password)
    @password = password
    if @password == ""
      self.password_digest = ""
    else
      self.password_digest = BCrypt::Password.create(password)
    end
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end
