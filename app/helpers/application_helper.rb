module ApplicationHelper

  def profit_loss(amount, options = {})
    amount_string = amount > 0 ? "+#{grid_monetary_value(amount)}" : grid_monetary_value(amount)
    content_tag :span, amount_string, :style => "color:#{amount < 0 ? 'red' : 'green'}"
  end

  def grid_monetary_value(amount)
    number_with_precision amount, :precision => 0, :delimiter => ','
  end

end
