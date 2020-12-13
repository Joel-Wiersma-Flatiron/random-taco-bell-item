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
      #puts "https://www.mcdonalds.com#{get_page.css("a.category-link")[i]["href"]}"
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
        if item.css("span.mcd-category-page__item-name").text != ""
          menu_item = RandomMcdonaldsMenuItem::MenuItem.new
          menu_item.name = item.css("span.mcd-category-page__item-name").text
          #project.css("div.project-thumbnail a img").attribute("src").value 
        end
      end
      menu_items2(category).each do |item|
        if item.css("span.categories-item-name").text != ""
          menu_item = RandomMcdonaldsMenuItem::MenuItem.new
          menu_item.name = item.css("span.categories-item-name").text
        end
      end
    end 
  end

  def print_menu_items
    RandomMcdonaldsMenuItem::MenuItem.all.each do |item|
      puts "Menu item: #{item.name}"
    end
  end
end