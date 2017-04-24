# == Schema Information
#
# Table name: lines
#
#  id                  :integer          not null, primary key
#  period_id           :integer
#  account_id          :integer
#  date                :date
#  amount              :decimal(8, 2)
#  description         :string(255)
#  recurring           :boolean          default(FALSE)
#  months_to_recur     :integer
#  recurring_parent_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  uuid                :string(255)
#  setup_tag           :string(255)
#
# Indexes
#
#  index_lines_on_account_id_and_period_id  (account_id,period_id)
#  index_lines_on_recurring_parent_id       (recurring_parent_id)
#  index_lines_on_uuid                      (uuid)
#

class Line < ActiveRecord::Base

  belongs_to :period
  belongs_to :account
  belongs_to :recurring_parent, :class_name => 'Line', :foreign_key => 'recurring_parent_id'
  has_many :recurring_children, :class_name => 'Line', :foreign_key => 'recurring_parent_id', :dependent => :destroy

  random_string :uuid, :unique => true, :type => :uuid

  validates :account_id, :presence => true
  validates :date, :presence => true
  validates :amount, :numericality => true
  validates :description, :presence => true
  validate do
    if self.months_to_recur && self.months_to_recur > self.maximum_number_of_months_to_recur
      errors.add :months_to_recur, "must be less than or equal to #{self.maximum_number_of_months_to_recur}"
    end

    if self.period && self.date && self.date < self.period.starts_on
      errors.add :date, "must be after the start of the period"
    end

    if self.period && self.date && self.date > self.period.ends_on
      errors.add :date, "must be before the end of the period"
    end
  end

  scope :on, ->(date) { where("date <= ?", date) }
  scope :in_period, -> (start_date, end_date) { where("date >= ? AND date <= ?", start_date, end_date) }

  after_save :update_recurring_siblings
  after_save :update_recurring_children

  def to_param
    uuid
  end

  #
  # Return the maximum number of months this item can recur for
  #
  def maximum_number_of_months_to_recur
    self.period.length_in_months -
    self.period.month_for_date(date)
  end

  #
  # This method will automatically update any recurring children.
  #
  def update_recurring_children
    if self.recurring?
      dates_which_exist_now = self.recurring_children.to_a
      dates_which_should_exist = []
      self.period.months_until_end_of_period(self.date)[0, self.months_to_recur || self.period.months.size].each do |date|
        existing_item = self.recurring_children.where(:recurring => false).where("date >= ? AND date <= ?", date.beginning_of_month, date.end_of_month).first_or_initialize
        existing_item.date = date
        existing_item.description = self.description
        existing_item.amount = self.amount
        existing_item.account_id = self.account_id
        existing_item.period_id = self.period_id
        existing_item.setup_tag = self.setup_tag
        existing_item.save!
        dates_which_should_exist << existing_item
      end
      (dates_which_exist_now - dates_which_should_exist).each(&:destroy)
    else
      self.recurring_children.destroy_all
    end
  end

  attr_accessor :update_future_recurring_lines

  #
  # This method will automatically update a line's future siblings if it's properties
  # are changed. This will promote this item to a recurring parent shorten the life
  # span of the original item.
  #
  def update_recurring_siblings
    if self.recurring_parent && self.update_future_recurring_lines

      months_to_recur = self.recurring_parent.months_to_recur || (self.period.months.size - 1)
      months_already_recurred = self.recurring_parent.recurring_children.where("date < ?", self.date).size
      months_remaining_to_recur = months_to_recur - months_already_recurred - 1

      original_parent = self.recurring_parent

      # This is a new recurring month which will continue as intended
      self.recurring = true
      self.months_to_recur = self.recurring_parent.months_to_recur.nil? ? nil : months_remaining_to_recur
      self.recurring_parent = nil
      self.save!

      original_parent.months_to_recur = months_already_recurred
      original_parent.save!
    end
  end

  #
  # Move this forward to the next month
  #
  def move_to_next_month
    self.date = self.date + 1.month
    self.save!
  end

  #
  # Move to the previous month
  #
  def move_to_previous_month
    self.date = self.date - 1.month
    self.save!
  end

end
