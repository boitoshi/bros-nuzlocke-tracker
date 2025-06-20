class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  # バリデーション
  validates :username, presence: true, uniqueness: { case_sensitive: false }, 
            format: { with: /\A[a-zA-Z0-9_]+\z/, message: "英数字とアンダースコアのみ使用可能" },
            length: { in: 3..20 }
  
  validates :email, uniqueness: { case_sensitive: false, allow_blank: true }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, allow_blank: true }
  
  validates :password, presence: true, length: { in: 6..128 }, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?

  # リレーション
  has_many :challenges, dependent: :destroy

  # Devise設定: ユーザー名またはメールアドレスでログイン可能
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:email)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", 
                                   { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  # メソッド
  def display_name
    username.present? ? username : email.split("@").first
  end

  def active_challenges
    challenges.in_progress
  end

  def completed_challenges
    challenges.completed
  end

  private

  def password_required?
    new_record? || !password.nil? || !password_confirmation.nil?
  end
end
