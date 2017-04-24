class LinesController < ApplicationController

  before_filter :budget_required
  before_filter { params[:id] && @line = Line.find_by_uuid!(params[:id]) }
  before_filter :check_line_security, :only => [:update, :edit, :destroy]

  def new
    @account = budget.accounts.find_by_uuid!(params[:account])
    @period = budget.periods.find_by_uuid!(params[:period])
    @date = @period.date_for_month(params[:month].to_i) if params[:month]
    @line = @account.lines.build(:period => @period, :date => @date)
  end

  def create
    @account = budget.accounts.find_by_uuid!(params[:account])
    @period = budget.periods.find_by_uuid!(params[:period])
    @line = @account.lines.build(safe_params)
    @line.period = @period
    if @line.save
      redirect_to_with_return_to grid_path(budget, :period => @period), :notice => "New line has been inserted into #{@account.name} for #{@line.date.to_s(:long)}"
    else
      render 'new'
    end
  end

  def update
    @line.update_future_recurring_lines = true
    if @line.update(safe_params)
      redirect_to_with_return_to grid_path(budget, :period => @line.period), :notice => "Line has been updated in #{@line.account.name} for #{@line.date.to_s(:long)}"
    else
      render 'edit'
    end
  end

  def destroy
    @line.destroy
    redirect_to_with_return_to grid_path(budget, :period => @line.period), :notice => "Line has been removed in #{@line.account.name} for #{@line.date.to_s(:long)}"
  end

  def bulk
    lines = Line.where(:uuid => params[:lines]).includes(:account)
    unless lines.all? {|line| line.account.budget == budget}
      raise Budgets::Error, "Not all lines belong to this budget"
    end

    if lines.empty?
      redirect_to_with_return_to root_path
      return
    end

    account = lines.first.account
    period  = lines.first.period

    case params[:bulk_action]
    when 'delete'         then lines.destroy_all
    when 'move_forward'   then lines.each(&:move_to_next_month)
    when 'move_back'      then lines.each(&:move_to_previous_month)
    end

    redirect_to_with_return_to account_path(budget, account, :period => period), :notice => "#{lines.size} line(s) have been updated successfully"
  end

  private

  def safe_params
    params.require(:line).permit(:date, :description, :amount, :months_to_recur, :recurring)
  end

  def check_line_security
    unless @line.account.budget == budget
      raise Budgets::Error, "You do not have permission to this line"
    end
  end

end
