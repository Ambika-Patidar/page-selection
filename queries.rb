require_relative 'pages'

class Queries
  attr_accessor :queries_with_weight
  @@queries_with_weight = []

  def initialize(words, query_index, type)
    @words = words
    @query_index = query_index 
    @type = type
    @number = 8
  end

  def set_words
    list_of_quries = {}
    for i in 0...@words.length
      if list_of_quries.keys&.include?(@type + (@query_index+1).to_s)
        list_of_quries[@type + (@query_index+1).to_s] << { @words[i] => @number-i }
      else
        list_of_quries[@type + (@query_index+1).to_s] = [{ @words[i] => @number-i }]
      end
    end
    assign_weight(list_of_quries)
  end

  def assign_weight(list_of_queries)
    pages_with_weight = {}
    list_of_queries.each do |query|
      for i in 1..Pages.class_variable_get('@@list_of_pages').length
        sum = 0
        query[1].each do |word|
          page_word = Pages.class_variable_get('@@list_of_pages')["#{'P'+i.to_s}"].find{ |page| page.keys.include?(word.keys[0]) }
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
    @@queries_with_weight << pages_with_weight
  end
end
