require_relative 'input'
require_relative 'sort'
require_relative 'result'

class Main
  def perform
    Input.new.read_input_from_file
    Sort.new.sort
    Result.new.result
  end
end

Main.new.perform
