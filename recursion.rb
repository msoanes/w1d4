# this is math, not Ruby methods.

# recursion 1
# exp(b, 0) = 1
# exp(b, n) = b * exp(b, n - 1)
#
# # recursion 2
# exp(b, 0) = 1
# exp(b, 1) = b
# exp(b, n) = exp(b, n / 2) ** 2             [for even n]
# exp(b, n) = b * (exp(b, (n - 1) / 2) ** 2) [for odd n]

def range(start, finish)
  return [] if start > finish
  return [start] if start == finish
  range(start, finish - 1) << finish
end

def recursive_array_sum(arr)
  return arr[0] if arr.length == 1
  arr[0] + recursive_array_sum(arr[1...arr.length])
end

def iterative_array_sum(arr)
  arr.inject(&:+)
end

def recursion_exp_one(base, exponent)
  return 1 if exponent == 0
  base * recursion_exp_one(base, exponent - 1)
end

def recursion_exp_two(base, exponent)
  return 1 if base == 0
  return base if exponent == 1
  if exponent % 2 == 0
    recursion_exp_two(base, exponent / 2) ** 2
  else
    base * (recursion_exp_two(base, (exponent - 1) / 2) ** 2)
  end
end

def deep_dup(arr)
  copy = []
  arr.each do |element|
    if element.is_a?(Array)
      copy << deep_dup(element)
    else
      copy << element
    end
  end
  copy
end

def recursive_fibonacci(length)
  return [] if length == 0
  return [1] if length == 1
  return [1, 1] if length == 2
  output = recursive_fibonacci(length - 1)
  output << output[-1] + output[-2]
end

def bsearch(array, target)
  return nil if (array.length == 1 && array != [target]) ||
                (array.length == 0)
  return 0 if array.length == 1


  case array[array.length/2] <=> target
  when 0
    array.length/2
  when 1
    bsearch(array[0...array.length/2], target)
  when -1
    begin
      bsearch(array[array.length/2..-1], target) + array.length/2
    rescue
      nil
    end
  end
end

def make_change(amount, coins = [25, 10, 5, 1])
  return [] if amount == 0
  best_candidate = nil
  coins.each do |coin|
    next if coin > amount
    candidate = make_change(amount - coin, coins) << coin
    best_candidate ||= candidate
    if candidate.length < best_candidate.length
      best_candidate = candidate
    end
  end
  best_candidate
end

def merge_sort(array)
  return array if array.length == 1
  first_half = merge_sort(array[0...(array.length/2)])
  second_half = merge_sort(array[(array.length/2)..-1])
  merged_array = []
  while first_half.length > 0 && second_half.length > 0
    if first_half[0] < second_half[0]
      merged_array << first_half.shift
    else
      merged_array << second_half.shift
    end
  end
  merged_array + second_half + first_half
end

def subsets(array)
  return [[]] if array.length == 0
  old_subsets = subsets(array[0...(array.length - 1)])
  new_subsets = old_subsets.map { |subset| subset.dup << array[-1] }
  old_subsets + new_subsets
end
