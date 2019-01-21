module ShopsHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'confirm'
      confirm_shops_path
    elsif action_name == 'edit'
      shop_path
    end
  end
end
