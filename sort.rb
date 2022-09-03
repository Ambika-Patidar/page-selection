require_relative 'queries'

class Sort
  attr_accessor :sorted_pages
  @@sorted_pages = {}

  def sort
    Queries.class_variable_get('@@queries_with_weight').each do |query_with_weight|
      query_with_weight.each do |key, value|
        len = value.length-1
        for i in 0..len
          for j in i+1..len
            value.insert(i, value.delete(value[j])) if value[j].values.first > value[i].values.first
          end
        end
        @@sorted_pages[key] = value
      end
    end
  end
end
