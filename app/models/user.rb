# frozen_string_literal: true
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  after_save :clear_cache
  after_destroy :clear_cache

  validates :name, presence: true
  validates :email, uniqueness: true

  scope :admins, -> { where(role: roles[:Admin]) }
  scope :regulars, -> { where(role: roles[:Regular]) }
  scope :active_users, -> { where(status: statuses[:Active]) }
  scope :suspended_users, -> { where(status: statuses[:Suspended]) }
  scope :order_by_name, -> { order(name: :desc) }
  scope :order_by_email, -> { order(email: :desc) }
  scope :order_by_role, -> { order(role: :desc) }

  enum role: { Regular: 0, Admin: 1 }
  enum status: { Active: 0, Suspended: 1, Removed: 2 }

  after_create_commit :send_welcome_email

  def self.search_users(keyword)
    return unless keyword.present?

    User.where('unaccent(name) ILIKE unaccent(?) OR email ILIKE (?)',
               "%#{keyword}%", "%#{keyword}%")
  end

  def admin?
    role == 'Admin'
  end

  def active?
    status == 'Active'
  end

  private

  def clear_cache
    Rails.cache.delete('users')
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_later
  end
end
