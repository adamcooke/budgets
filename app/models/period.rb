# == Schema Information
#
# Table name: periods
#
#  id               :integer          not null, primary key
#  budget_id        :integer
#  starts_on        :date
#  ends_on          :date
#  length_in_months :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  name             :string(255)
#  uuid             :string(255)
#
# Indexes
#
#  index_periods_on_budget_id  (budget_id)
#  index_periods_on_uuid       (uuid)
#

class Period < ActiveRecord::Base

  attr_readonly :starts_on
  attr_readonly :length_in_months

  random_string :uuid, :unique => true, :type => :uuid

  belongs_to :budget
  has_many :lines, :dependent => :destroy

  validates :name, :presence => true
  validates :starts_on, :presence => true
  validates :ends_on, :presence => true
  validates :length_in_months, :numericality => {:only_integer => true, :less_than_or_equal_to => 12, :greater_than_or_equal_to => 3}
  validate do
    if self.starts_on && self.starts_on.day != 1
      errors.add :starts_on, "must be the first day of a month"
    end
  end

  default_value :length_in_months, -> { 12 }

  before_validation :calculate_end_date

  def to_param
    uuid
  end

  #
  # Return the current period
  #
  def self.current
    self.where("starts_on <= ?", Date.today).order(:starts_on => :desc).first || self.order(:starts_on => :desc).first
  end

  #
  # What the current month in this period?
  #
  def current_month_number
    @current_month_number ||= month_for_date(Date.today)
  end

  #
  # Return the total balance for all accounts in the period for the given type
  #
  def balance_on_date(type, date = Date.today)
    @balance_on_date ||= {}
    @balance_on_date["#{type}-#{date.to_s}"] ||= begin
      scope = self.lines.includes(:account).references(:account)
      scope = scope.where(:accounts => {:account_type => type.to_s})
      scope = scope.on(date)
      scope.sum(:amount)
    end
  end

  #
  # Balance for the given month
  #
  def balance_for_month(type, month)
    @balance_for_month ||= {}
    @balance_for_month["#{type}-#{month}"] ||= begin
      scope = self.lines.includes(:account).references(:account)
      scope = scope.where(:accounts => {:account_type => type.to_s})
      date = self.date_for_month(month)
      scope = scope.in_period(date, date.end_of_month)
      scope.sum(:amount)
    end
  end

  #
  # Return the profit for a given month
  #
  def profit_for_month(month)
    balance_for_month(:incoming, month) -
    balance_for_month(:outgoing, month)
  end

  #
  # Return the profit on a given date
  #
  def profit_on_date(date)
    balance_on_date(:incoming, date) -
    balance_on_date(:outgoing, date)
  end

  #
  # Return an array of all months
  #
  def months
    (0..length_in_months - 1).map do |i|
      self.starts_on + i.months
    end
  end

  #
  # Return the date for the given month number
  #
  def date_for_month(month)
    months[month - 1]
  end

  #
  # Return the month number for a given date
  #
  def month_for_date(date)
    length_in_months.times do |i|
      start_date = self.starts_on + i.months
      if date >= start_date && date <= start_date.end_of_month
        return i + 1
      end
    end
    false
  end

  #
  # Return all dates which exist starting from a given date until the end of the
  # period
  #
  def months_until_end_of_period(from)
    Array.new.tap do |array|
      length_in_months.times do |i|
        date_in_month = self.starts_on + i.months
        if date_in_month > from
          if from.day > date_in_month.end_of_month.day
            date_in_month = date_in_month.change(:day => date_in_month.end_of_month.day)
          else
            date_in_month = date_in_month.change(:day => from.day)
          end
          array << date_in_month
        end
      end
    end
  end

  private

  def calculate_end_date
    if self.starts_on && self.length_in_months
      self.ends_on = (self.starts_on + length_in_months.months - 1.day)
    end
  end

end
