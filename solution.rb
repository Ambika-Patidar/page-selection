$list_of_pages = {}
$list_of_quries = {}
$number = 8

def set_words(words, index, type)
	for i in 0...words.length
		if type == 'p'
			if $list_of_pages.keys&.include?(words[i])
				$list_of_pages[words[i]] << { type + (index+1).to_s => $number-i }
			else
				$list_of_pages[words[i]] = [{ type + (index+1).to_s => $number-i }]
			end
		else
			if $list_of_quries.keys&.include?(words[i])
				$list_of_quries[words[i]] << { type + (index+1).to_s => $number-i }
			else
				$list_of_quries[words[i]] = [{ type + (index+1).to_s => $number-i }]
			end
		end
	end
end

def read_input_from_file
	print("Input read from input.txt file: \n")
	query_index = 0
	page_index = 0

	file = File.open('input.txt', 'r')
	file.each do |line|
		if line[0] == 'P'
			words = line.split(' ')
			words.shift
			set_words(words, page_index, 'p')
			page_index = page_index + 1	
		elsif line[0] == 'Q'
			words = line.split(' ')
			words.shift
			set_words(words, query_index, 'q')
			query_index = query_index + 1
		end
	end
	puts $list_of_pages
	puts $list_of_quries
	print("\n")
end

read_input_from_file
