class Category
    attr_accessor :name, :url
    @@all = []

    def initialize(name, url)
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