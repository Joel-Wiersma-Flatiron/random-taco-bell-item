class RandomMcdonaldsMenuItem::Scraper

  attr_reader :inner_pages

  def get_page
    Nokogiri::HTML(open("https://www.mcdonalds.com/us/en-us/full-menu.html"))
  end

  def menu_items
    get_page.css("li.mcd-category-page__item")
  end

  def make_menu_items
    menu_items.each do |item|
      menu_item = RandomMcdonaldsMenuItem::MenuItem.new
      menu_item.name = item.css("span.mcd-category-page__item-name").text

    end
  end

  def print_menu_items
    RandomMcdonaldsMenuItem::MenuItem.all.each do |item|
      puts "Menu item: #{item.name}"
      

    end
  end
end