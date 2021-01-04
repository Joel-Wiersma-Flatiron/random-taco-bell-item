class RandomMcdonaldsMenuItem::Scraper

  attr_reader :categories
  BASE_URL = "https://www.mcdonalds.com"
  def initialize
    @categories = []
  end

  def get_page
    Nokogiri::HTML(open("https://www.mcdonalds.com/us/en-us/full-menu.html"))
  end

  # Have to grab menu items from multiple pages(categories)
  def menu_categories
    i = 1
    while i < 11
      category_url = BASE_URL+get_page.css("a.category-link")[i]["href"]
      category_name = get_page.css("#category-section > ul.mcd-category-page__links-section.mcd-category-page__left-nav--sub-category > li > a > span")[i-1].text
      @categories << Category.new(category_name, category_url)
      i += 1
    end
  end
  
  def menu_items(category)
    Nokogiri::HTML(open(category)).css("li.mcd-category-page__item")
  end

  #Two different css selectors have to be used
  def menu_items2(category)
    Nokogiri::HTML(open(category)).css("li.categories-list-item")
  end

  def make_menu_items
    categories.each do |category|
      menu_items(category.url).each do |item|
        if item.css("span.mcd-category-page__item-name").text != ""
          menu_item = RandomMcdonaldsMenuItem::MenuItem.new
          menu_item.name = item.css("span.mcd-category-page__item-name").text
          category.items += 1
        end
      end
      menu_items2(category.url).each do |item|
        if item.css("span.categories-item-name").text != "" && item.css("span.categories-item-name").text != "#""{itemName}"
          menu_item = RandomMcdonaldsMenuItem::MenuItem.new
          menu_item.name = item.css("span.categories-item-name").text
          category.items += 1
        end
      end
    end 
  end

  def which_item(id)
    total = 0
    categories.each do |category|
      previous_total = total
      total += category.items
      return [category, id - previous_total] if id <= total
    end
  end

  def more_info(id)
    item = which_item(id)
    category_url = Nokogiri::HTML(open(item[0].url))
    if category_url.css("a.mcd-category-page__item-link") == category_url.css("blank")
      item_url = Nokogiri::HTML(open(BASE_URL+category_url.css("a.categories-item-link")[item[1] - 1]["href"]))
    else
      item_url = Nokogiri::HTML(open(BASE_URL+category_url.css("a.mcd-category-page__item-link")[item[1] - 1]["href"]))
    end
    puts item_url.css("p.product-detail__description").text
  end
end