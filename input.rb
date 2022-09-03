require_relative 'pages'
require_relative 'queries'

class Input
  def read_input_from_file
    print("Read input from input.txt file: \n")
    query_index = 0
    page_index = 0

    file = File.open('input.txt', 'r')
    file.each do |line|
      puts line
      if line[0] == 'P'
        words = line.split(' ')
        words.shift
        Pages.new(words, page_index, 'P').set_words
        page_index = page_index + 1	
      elsif line[0] == 'Q'
        words = line.split(' ')
        words.shift
        Queries.new(words, query_index, 'Q').set_words
        query_index = query_index + 1
      end
    end
    print("\n")
  end
end
