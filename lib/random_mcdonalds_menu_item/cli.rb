class RandomMcdonaldsMenuItem::CLI

  def greeting
    puts "Welcome to the random McDonalds menu item generator"
    puts "Please wait 5 to 10 seconds for us to grab all the information"
    scraper = RandomMcdonaldsMenuItem::Scraper.new
    scraper.menu_categories
    scraper.make_menu_items
    program
  end

  def valid?(input)
    if input > 10 
      puts "There's no way you can eat that much, enter a number 10 or less"
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
      puts "Would you like to try again? Enter number of items or 0 to stop"
      input = gets.strip.to_i
      input != 0 ? program(input) : exit
    end
    program
  end
end