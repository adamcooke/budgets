# == Schema Information
#
# Table name: accounts
#
#  id           :integer          not null, primary key
#  budget_id    :integer
#  name         :string(255)
#  account_type :string(255)
#  archived     :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  uuid         :string(255)
#  setup_tag    :string(255)
#
# Indexes
#
#  index_accounts_on_budget_id  (budget_id)
#  index_accounts_on_uuid       (uuid)
#

class Account < ActiveRecord::Base

  TYPES = ['incoming', 'outgoing']

  belongs_to :budget
  has_many :lines, :dependent => :destroy

  random_string :uuid, :unique => true, :type => :uuid

  validates :name, :presence => true
  validates :account_type, :inclusion => {:in => TYPES}

  scope :unarchived, -> { where(:archived => false) }
  scope :archived, -> { where(:archived => true) }

  def to_param
    uuid
  end

  #
  # Return the total balance for an account for the given period and
  # the given date.
  #
  def balance(period, date = Date.today)
    self.lines.where(:period => period).on(date).sum(:amount)
  end

  #
  # Return the total spending for the given month
  #
  def balance_for_month(period, month)
    date = period.date_for_month(month)
    self.lines.in_period(date, date.end_of_month).sum(:amount)
  end

end
