class Category
  attr_accessor :name, :url, :items
    @@all = []

  def initialize(name, url)
    self.items = 0
    self.name = name
    self.url = url
    self.class.all << self
  end

  def self.all
    @@all
  end

  def menu_items
    RandomMcdonaldsMenuItem::MenuItem.all.select {|menu_item| menu_item.category == self}
  end
end