class SetupController < ApplicationController
  before_filter :budget_required

  def edit
    @values = budget.setup_values.group_by(&:field)
  end

  def update
    values_seen = []
    params[:values].each do |field, amount|
      value = budget.setup_values.where(:field => field).first_or_initialize
      value.amount = amount.to_f
      value.save!
      values_seen << value
    end
    budget.setup_values.where.not(:id => values_seen.map(&:id)).destroy_all
    redirect_to grid_path(budget), :notice => "Your numbers have been saved and are shown in the grid below! You can adjust them by clicking on them below."
  end
end
