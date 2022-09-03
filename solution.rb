$list_of_pages = {}
$queries_with_weight = []

def set_words(words, index, type)
  list_of_quries = {}
	for i in 0...words.length
		if type == 'P'
			if $list_of_pages.keys&.include?(type + (index+1).to_s)
				$list_of_pages[type + (index+1).to_s] << { words[i] => $number-i }
			else
				$list_of_pages[type + (index+1).to_s] = [{ words[i] => $number-i }]
			end
		else
			if list_of_quries.keys&.include?(type + (index+1).to_s)
				list_of_quries[type + (index+1).to_s] << { words[i] => $number-i }
			else
				list_of_quries[type + (index+1).to_s] = [{ words[i] => $number-i }]
			end
		end
	end
  assign_weight(list_of_quries) if type == 'Q'
end

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
			set_words(words, page_index, 'P')
			page_index = page_index + 1	
		elsif line[0] == 'Q'
			words = line.split(' ')
			words.shift
			set_words(words, query_index, 'Q')
			query_index = query_index + 1
		end
	end
	print("\n")
end

def assign_weight(list_of_quries)
	pages_with_weight = {}
	list_of_quries.each do |query|
		for i in 1..$list_of_pages.length
			sum = 0
			query[1].each do |word|
				page_word = $list_of_pages["#{'P'+i.to_s}"].find{ |page| page.keys.include?(word.keys[0]) }
				sum = sum + page_word.values[0] * word.values[0] unless page_word.nil?
			end
      if sum > 0
        if pages_with_weight&.keys&.include?(query[0])
          pages_with_weight[query[0]] << {"#{'P'+i.to_s}": sum}
        else
          pages_with_weight[query[0]] = [{"#{'P'+i.to_s}": sum}]
        end
      end
		end
    pages_with_weight[query[0]] = [{}] if pages_with_weight.empty?
	end
  $queries_with_weight << pages_with_weight
end

def sort
  sorted_pages = {}
  $queries_with_weight.each do |query_with_weight|
    query_with_weight.each do |key, value|
      len = value.length-1
      for i in 0..len
        for j in i+1..len
          if value[j].values.first > value[i].values.first
            value.insert(i, value.delete(value[j]))
          end
        end
      end
      sorted_pages[key] = value
    end
  end
  sorted_pages
end

def result(sorted_pages)
  sorted_pages.each { |key, value| puts "#{key}: #{value.map{ |p| p.keys }.flatten.join(' ')}" }
end

$number = gets.chomp.to_i
p "Number: #{$number}"
read_input_from_file
puts 'Output: '
result(sort)
