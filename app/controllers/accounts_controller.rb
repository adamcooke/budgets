class AccountsController < ApplicationController

  before_filter :budget_required
  before_filter { params[:id] && @account = budget.accounts.find_by_uuid!(params[:id]) }

  def index
    @accounts = budget.accounts.order(:name).to_a.group_by(&:account_type)
  end

  def show
    @period = budget.periods.find_by_uuid!(params[:period])
    @lines = @account.lines.where(:period => @period).order(:date => :desc)
    if params[:month]
      @date = @period.date_for_month(params[:month].to_i)
      @lines = @lines.in_period(@date, @date.end_of_month).includes(:recurring_parent)
    end
  end

  def new
    @account = budget.accounts.build(:account_type => params[:type])
  end

  def create
    @account = budget.accounts.build(safe_params)
    if @account.save
      redirect_to_with_return_to edit_account_path(budget, @account), :notice => "#{@account.name} has been created successfully"
    else
      render 'new'
    end
  end

  def update
    if @account.update(safe_params)
      redirect_to_with_return_to edit_account_path(budget, @account), :notice => "#{@account.name} has been updated successfully"
    else
      render 'edit'
    end
  end

  def destroy
    @account.destroy
    redirect_to accounts_path(budget), :notice => "#{@account.name} has been destroyed successfully"
  end

  private

  def safe_params
    params.require(:account).permit(:name, :account_type, :archived)
  end

end
