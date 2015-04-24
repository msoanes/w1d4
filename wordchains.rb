require 'set'

class WordChainer

  def initialize(dictionary_file_name = 'dictionary.txt')
    @dictionary = Set.new
    contents = File.readlines(dictionary_file_name)
    @dictionary = contents.map(&:chomp).to_set
  end

  def run(source, target)
    @current_words = Set.new([source])
    @all_seen_words = {source => nil}
    until @current_words.empty?
      @current_words = explore_current_words(target)
      break if @target_found
    end
    build_path(target)
  end

  def explore_current_words(target)
    new_current_words = Set.new
    @current_words.each do |current_word|
      adjacent_words(current_word).each do |adjacent_word|
        next if @all_seen_words.include?(adjacent_word)
        new_current_words << adjacent_word
        @all_seen_words[adjacent_word] = current_word
        if adjacent_word == target
          @target_found = true
          break
        end
      end
      break if @target_found
    end
    new_current_words.each do |new_current_word|
      puts "#{@all_seen_words[new_current_word]} => #{new_current_word}"
    end
    new_current_words
  end

  def adjacent_words(word)
    @dictionary.select do |each_word|
      is_adjacent?(word, each_word)
    end
  end

  def is_adjacent?(word_one, word_two)
    return false if word_one.length != word_two.length
    difference = 0
    word_one.length.times do |index|
      difference += 1 if word_one[index] != word_two[index]
    end
    difference == 1
  end

  def build_path(target)
    path = [target]
    path.unshift(@all_seen_words[path[0]]) until @all_seen_words[path[0]].nil?
    path
  end

end
