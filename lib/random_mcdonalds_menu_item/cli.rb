class RandomMcdonaldsMenuItem::CLI

  def greeting
    puts "Welcome to the random mcdonalds menu item generator"
    RandomMcdonaldsMenuItem::Scraper.new.make_menu_items
    RandomMcdonaldsMenuItem::Scraper.new.print_menu_items
    program
  end

  def program
    
  end
end