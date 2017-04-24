class PeriodsController < ApplicationController

  before_filter :budget_required
  before_filter { params[:id] && @period = budget.periods.find_by_uuid!(params[:id]) }

  def index
    @periods = budget.periods.to_a
  end

  def new
    @period = budget.periods.build(:starts_on => Date.today.beginning_of_month)
  end

  def create
    @period = budget.periods.build(safe_params)
    if @period.save
      redirect_to_with_return_to periods_path(budget), :notice => "Period has been created successfully"
    else
      render 'new'
    end
  end

  def update
    if @period.update(safe_params)
      redirect_to_with_return_to edit_period_path(budget, @period), :notice => "Period has been updated successfully"
    else
      render 'edit'
    end
  end

  def destroy
    @period.destroy
    redirect_to_with_return_to periods_path(budget), :notice => "Period has been destroyed successfully"
  end

  private

  def safe_params
    params.require(:period).permit(:starts_on, :length_in_months, :name)
  end

end
