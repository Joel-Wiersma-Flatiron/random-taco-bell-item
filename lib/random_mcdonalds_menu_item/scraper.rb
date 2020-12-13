class RandomMcdonaldsMenuItem::Scraper

  attr_reader :categories

  def initialize
    @categories = []
  end

  def get_page
    Nokogiri::HTML(open("https://www.mcdonalds.com/us/en-us/full-menu.html"))
  end

  def menu_categories
    i = 1
    while i < 11
      @categories << Nokogiri::HTML(open("https://www.mcdonalds.com#{get_page.css("a.category-link")[i]["href"]}"))
      i += 1
    end
  end

  def menu_items(category)
    category.css("li.mcd-category-page__item")
  end

  #Two different css selectors have to be used
  def menu_items2(category)
    category.css("li.categories-list-item")
  end

  def make_menu_items
    @categories.each do |category|
      menu_items(category).each do |item|
        if item.css("span.mcd-category-page__item-name").text != "" && duplicate?(item.css("span.categories-item-name").text)
          menu_item = RandomMcdonaldsMenuItem::MenuItem.new
          menu_item.name = item.css("span.mcd-category-page__item-name").text
        end
      end
      menu_items2(category).each do |item|
        simplified = item.css("span.categories-item-name").text
        if simplified != "" && duplicate?(simplified) && simplified != "#""{itemName}"
          menu_item = RandomMcdonaldsMenuItem::MenuItem.new
          menu_item.name = simplified
        end
      end
    end 
  end

  def duplicate?(item)
    RandomMcdonaldsMenuItem::MenuItem.all.each do |check|
      return false if item == check.name
    end
    return true
  end

  def print_menu_items(items)
    random_numbers = []
    while random_numbers.length < items
      random_numbers << (rand(RandomMcdonaldsMenuItem::MenuItem.all.length) - 1)
      random_numbers.uniq
    end
    item_number = 0
    RandomMcdonaldsMenuItem::MenuItem.all.each do |item|
      random_numbers.each do |number|
        puts item.name if item_number == number
      end
      item_number += 1
    end
  end
end