# Define your own Array#my_sort! (you don't need my_each anymore). It should take
# in a block to perform the comparison:
#
# [1, 3, 5].my_sort! { |num1, num2| num1 <=> num2 } #sort ascending
# [1, 3, 5].my_sort! { |num1, num2| num2 <=> num1 } #sort descending
# #<=> (the spaceship method) compares objects. x.<=>(y) returns -1 if x is less
# than y. If x and y are equal, it returns 0. If greater, 1. You can define <=> on
# your own classes.
#
# Your my_sort! should modify the array. After writing my_sort!, write a my_sort
# that does the same but doesn't modify the original. Do this in two lines using
# dup.
class Array
  def my_each(&prc)
    copy = self.dup
    length.times do |index|
      prc.call(copy[index])
    end
    self
  end

  def my_map(&prc)
    copy = []
    my_each do |el|
      copy << prc.call(el)
    end
    copy
  end

  def my_select(&prc)
    copy = []
    my_each do |el|
      copy << el if prc.call(el)
    end
    copy
  end

  def my_inject(aggregate = nil, &prc)
    self.my_each do |el|
      unless aggregate
        aggregate = self[0]
        next
      end
      aggregate = prc.call(aggregate, el)
    end
    aggregate
  end

  def my_sort!(&prc)
    no_switches = false
    until no_switches
      no_switches = true
      0.upto(length - 2) do |idx|
        if prc.call(self[idx], self[idx + 1]) > 0
          no_switches = false
          self[idx], self[idx + 1] = self[idx + 1], self[idx]
        end
      end
    end
    self
  end

  def my_sort(&prc)
    self.dup.my_sort!(&prc)
  end
end

def eval_blocks(*args, &prc)
  if block_given
    prc.call(*args)
  else
    puts "NO BLOCK GIVEN!"
  end
end
