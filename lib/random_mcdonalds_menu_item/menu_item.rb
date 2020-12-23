class RandomMcdonaldsMenuItem::MenuItem
  attr_accessor :name, :category
    
  @@all = []
  
  def initialize
    self.class.all << self if !self.class.all.include?(self)
  end
  
  def self.all
    @@all
  end
  
  def self.reset_all
    all.clear
  end

  def self.display_grid_of_books(books)
    books_table = TTY::Table.new(header: ["Id", "Book Title"])
    books.each.with_index(1) do |book, i| 
        books_table << ["#{i}".red, "#{book.title}"]
    end
    puts books_table.render(:unicode)
  end

  #Prints the user entered amount of random menu items
  def self.print_menu_items(items)
    random_numbers = []
    while random_numbers.uniq.length < items
      random_numbers << (rand(@@all.length) - 1)
      random_numbers.uniq!
    end
    item_number = 0
    items_table = TTY::Table.new(header: ["Id", "Item Name"])
    all.each.with_index(1) do |item,i |
      random_numbers.each do |number|
        items_table << ["#{i}".red, "#{item.name}"] if item_number == number
        # puts item.name if item_number == number
      end
      item_number += 1
    end
    puts items_table.render(:unicode)
  end
end