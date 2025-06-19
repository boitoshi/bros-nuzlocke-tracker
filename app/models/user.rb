class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # バリデーション
  validates :username, presence: true, uniqueness: { case_sensitive: false }, 
            format: { with: /\A[a-zA-Z0-9_]+\z/, message: "英数字とアンダースコアのみ使用可能" },
            length: { in: 3..20 }

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
end
