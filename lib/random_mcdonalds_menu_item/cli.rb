class RandomMcdonaldsMenuItem::CLI

  def greeting
    puts "Welcome to the random McDonalds menu item generator"
    puts "Please wait 5 to 10 seconds for us to grab all the information"
    program
  end

  def program
    scraper = RandomMcdonaldsMenuItem::Scraper.new
    scraper.menu_categories
    scraper.make_menu_items
    puts "How many items from McDonald's would you like?"
    input = gets.strip.to_i
    if input > 10 
      puts "There's no way you can eat that much, enter a number 10 or less"
      program
      exit
    elsif input < 1
      puts "You should enter at least 1"
      program
      exit
    elsif input == nil
      puts "Please input a valid number"
      program
      exit
    end
    scraper.print_menu_items(input)
  end
end