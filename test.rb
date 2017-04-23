require 'csv'
require './solver.rb'

if ARGV.length == 0
  abort("required arg: <starting word>")
end

def number_or_nil(str)
  num = str.to_i
  num if num.to_s == str
end

word = ARGV[0]

iterations = number_or_nil(ARGV[1])

csv_text = File.read('./test_0.csv')
csv = CSV.parse(csv_text, :headers => true)

solver = Solver.new(csv)
solver.solve(word, iterations)
