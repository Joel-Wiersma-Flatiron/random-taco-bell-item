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
end