class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:vkontakte ] #, :facebook, :twitter

  has_many :task_users
  has_many :tasks, through: :task_users

  validates :email, uniqueness: true
  validates :email, presence: true

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid). first_or_initialize do |user|
        user.provider = auth.provider
        user.name = auth.info.name
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.skip_confirmation!
        user.save
      end
  end
end
