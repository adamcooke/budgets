class GridController < ApplicationController

  before_filter :budget_required

  def index
    if params[:period]
      @period = budget.periods.find_by_uuid!(params[:period])
    else
      @period = budget.periods.current
      if @period.nil?
        redirect_to periods_path(budget), :alert => "You haven't created any periods yet. Get started below!"
      end
    end
    @accounts = budget.accounts.unarchived.order(:name).to_a.group_by(&:account_type)
  end
end
