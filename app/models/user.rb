class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # リレーション
  has_many :challenges, dependent: :destroy

  # メソッド
  def display_name
    email.split('@').first
  end

  def active_challenges
    challenges.in_progress
  end

  def completed_challenges
    challenges.completed
  end
end
