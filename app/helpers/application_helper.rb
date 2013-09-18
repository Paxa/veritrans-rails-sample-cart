module ApplicationHelper
  def page_title
    @page_title ? "#{@page_title} - veritrans example" : "Veritrans example"
  end

  def current_carts
    controller.session_stored_carts
  end
end
