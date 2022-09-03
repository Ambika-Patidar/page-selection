class Pages
  attr_accessor :list_of_pages
  @@list_of_pages = {}

  def initialize(words, page_index, type)
    @words = words
    @page_index = page_index 
    @type = type
    @number = 8
  end

  def set_words
    for i in 0...@words.length
      if @@list_of_pages.keys&.include?(@type + (@page_index+1).to_s)
        @@list_of_pages[@type + (@page_index+1).to_s] << { @words[i] => @number-i }
      else
        @@list_of_pages[@type + (@page_index+1).to_s] = [{ @words[i] => @number-i }]
      end
    end
  end
end
