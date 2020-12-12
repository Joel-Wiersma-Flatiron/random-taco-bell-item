class RandomTacoBellMenuItem::Scraper

  def get_page
    Nokogiri::HTML(open("https://www.tacobell.com/food"))
  end

end