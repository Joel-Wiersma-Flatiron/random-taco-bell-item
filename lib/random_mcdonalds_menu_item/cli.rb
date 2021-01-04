class RandomMcdonaldsMenuItem::CLI

  attr_reader :scraper

  def initialize
    @scraper = RandomMcdonaldsMenuItem::Scraper.new
  end

  def greeting
    puts "Welcome to the random McDonalds menu item generator"
    puts "Please wait 5 to 10 seconds for us to grab all the information"
    scraper.menu_categories
    scraper.make_menu_items
    program
  end

  def valid?(input)
    if input > RandomMcdonaldsMenuItem::MenuItem.all.length
      puts "There are only #{RandomMcdonaldsMenuItem::MenuItem.all.length} things on the menu. Enter something equal to or below that"
      return false
    elsif input < 1
      puts "You should enter a valid number greater than or equal to 1"
      return false
    elsif input == nil
      puts "Please input a valid number"
      return false
    end
    return true
  end

  def program(input = nil)
    if input == nil
      puts "How many items from McDonald's would you like?"
      input = gets.strip.to_i
    end
    if valid?(input)
      RandomMcdonaldsMenuItem::MenuItem.print_menu_items(input)
      puts "Enter an item's ID to get more info about it"
      input = gets.strip.to_i
      scraper.more_info(input)
    else
      program
    end
  end
end