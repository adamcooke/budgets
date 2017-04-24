class BudgetsController < ApplicationController

  before_filter { params[:id] && @budget = current_user.budgets.find_by_uuid!(params[:id]) }

  def index
    @budgets = current_user.budgets.order(:name)
  end

  def new
    @budget = Budget.new
  end

  def create
    @budget = current_user.budgets.build(safe_params)
    if @budget.save
      if @budget.template.fields.size > 0 && @budget.create_mode == 'basic'
        redirect_to setup_path(@budget), :notice => "Your budget has been created for you. You can use this wizard to get started quickly!"
      else
        redirect_to grid_path(@budget), :notice => "Budget has been created successfully."
      end
    else
      render 'new'
    end
  end

  def update
    if @budget.update(safe_params)
      redirect_to root_path, :notice => "Budget details have been updated successfully"
    else
      render 'edit'
    end
  end

  def destroy
    @budget.destroy
    redirect_to root_path, :notice => "Budget has been removed successfully"
  end

  private

  def safe_params
    params.require(:budget).permit(:name, :create_mode, :budget_type, :cumulative_totals)
  end

end
