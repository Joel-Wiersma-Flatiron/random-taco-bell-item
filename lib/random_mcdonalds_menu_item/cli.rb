class RandomMcdonaldsMenuItem::CLI

  def greeting
    puts "Welcome to the random mcdonalds menu item generator"
    puts "Please wait 5 to 10 seconds for us to grab all the information"
    scraper = RandomMcdonaldsMenuItem::Scraper.new
    scraper.menu_categories
    scraper.make_menu_items
    scraper.print_menu_items
    program
  end

  def program
    
  end
end