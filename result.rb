require_relative 'sort'

class Result
  def result
    puts 'Output:'
    Sort.class_variable_get('@@sorted_pages').each { |key, value| puts "#{key}: #{value.map{ |p| p.keys }.flatten.join(' ')}" }
  end  
end
