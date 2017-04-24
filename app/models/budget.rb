# == Schema Information
#
# Table name: budgets
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  currency          :string(255)
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  uuid              :string(255)
#  budget_type       :string(255)
#  example           :boolean          default(FALSE)
#  cumulative_totals :boolean          default(TRUE)
#
# Indexes
#
#  index_budgets_on_uuid  (uuid)
#

class Budget < ActiveRecord::Base

  TYPES = ['business', 'personal']

  belongs_to :user
  has_many :accounts, :dependent => :destroy
  has_many :periods, :dependent => :destroy
  has_many :setup_values, :dependent => :destroy

  random_string :uuid, :unique => true, :type => :uuid

  validates :name, :presence => true
  validates :user_id, :presence => true
  validates :budget_type, :inclusion => {:in => TYPES, :allow_blank => true}

  CREATE_MODES = ['basic', 'empty', 'example']
  attr_accessor :create_mode

  after_save :create_defaults

  def to_param
    uuid
  end

  def template
    @template ||= self.budget_type ? Budgets::Templates.const_get(self.budget_type.camelize).new(self) : nil
  end

  def create_defaults
    if self.template

      if self.create_mode == 'basic' || self.create_mode == 'example'
        self.template.create_structure
      end

      if self.create_mode == 'example'
        self.template.create_example_data
      end
    end
  end

end
