# == Schema Information
#
# Table name: setup_values
#
#  id         :integer          not null, primary key
#  budget_id  :integer
#  field      :string(255)
#  amount     :decimal(8, 2)    default(0.0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SetupValue < ActiveRecord::Base

  belongs_to :budget

  after_save do
    self.apply_to_lines(budget.periods.current)
  end

  #
  # Apply this setup value to the actual lines for the
  # given period
  #
  def apply_to_lines(period)
    if field_options = self.budget.template.fields[self.field.to_sym]
      account = field_options[:account]
      line = account.lines.where(:period => period, :setup_tag => self.field).where("date >= ? AND date <= ?", Date.today.beginning_of_month, Date.today.end_of_month).first_or_initialize
      if self.amount <= 0
        line.destroy if line.persisted?
      else
        line.update_future_recurring_lines = true
        line.amount = self.amount
        line.date = Date.today
        line.recurring = true
        line.description = I18n.t("setup.#{budget.budget_type}.fields.#{field}.title")
        line.save!
      end
    end
  end

end
