class RandomMcdonaldsMenuItem::MenuItem
  attr_accessor :name
    
  @@all = []
  
  def initialize
    @@all << self
  end
  
  def self.all
    @@all = @@all.uniq
    @@all
  end
  
  def self.reset_all
    @@all.clear
  end

  #Prints the user entered amount of random menu items
  def self.print_menu_items(items)
    random_numbers = []
    while random_numbers.length < items
      random_numbers << (rand(@@all.length) - 1)
      random_numbers.uniq!
    end
    item_number = 0
    @@all.each do |item|
      random_numbers.each do |number|
        puts item.name if item_number == number
      end
      item_number += 1
    end
  end
end