class Solver
  def initialize(csv)
    @csv = csv
  end

  # Finds most probably bigram match from first word of bigram
  # Params:
  # - word: the first word of the bigram
  private
  def find_best_match(word)
    matches = @csv.select do |hash|
      hash["bigram"].split[0] == word
    end

    if matches.length == 0
      return nil
    end

    merged = Hash.new(0)
    matches.each do |row|
      merged[row["bigram"]] += row["match_count"].to_i
    end

    best_match = merged.max_by{|k,v| v}
    probability = best_match[1].to_f / merged.values.inject(:+)
    new_word = best_match[0].split[1]
    puts "**#{new_word}**, probability = #{probability.round(2)}"

    new_word
  end

  # Solve the bigram puzzle
  # Params:
  # - word: the first word of the bigram
  # - iterations: max number of bigram matches to find
  public
  def solve(word, iterations)
    puts "starting with #{word}"

    while iterations == nil || iterations > 0
      prev_word = word
      word = find_best_match(word)
      if word == nil
        puts "no matches for #{prev_word}"
        return
      end

      if iterations != nil
        iterations-=1
      end
    end

    puts "out of iterations"
  end
end
