#Problem 1: You have array of integers. Write a recursive solution to find
#the sum of the integers.
def split_array(array, index = array.length/2)
  part_one = array[0...index]
  part_two = array[index..-1]
  [part_one, part_two]
end

def sum_recur(array)
  return 0 if array.length == 0
  return array[0] if array.length == 1
  part_one, part_two = split_array(array)
  sum_recur(part_one) + sum_recur(part_two)
end


#Problem 2: You have array of integers. Write a recursive solution to
#determine whether or not the array contains a specific value.

def includes?(array, target)
  return false if array.length == 0
  return array[0] == target if array.length == 1
  part_one, part_two = split_array(array)
  includes?(part_one, target) || includes?(part_two, target)
end


#Problem 3: You have an unsorted array of integers. Write a recursive
#solution to count the number of occurrences of a specific value.

def num_occur(array, target)
  return 1 if array.length == 1 && array == [target]
  return 0 if array.length <= 1
  part_one, part_two = split_array(array)
  num_occur(part_one, target) + num_occur(part_two, target)
end


#Problem 4: You have array of integers. Write a recursive solution to
#determine whether or not two adjacent elements of the array add to 12.

def add_to_twelve?(array)
  return false if array.length <= 1
  return true if array[0] + array[1] == 12
  add_to_twelve?(array[1..-1])
end


#Problem 5: You have array of integers. Write a recursive solution to
#determine if the array is sorted.

def sorted?(array)
  return true if array.length <= 1
  return false if array[0] > array[1]
  sorted?(array[1..-1])

end


#Problem 6: Write the code to give the value of a number after it is
#reversed. Must use recursion. (Don't use any #reverse methods!)

def reverse(number)
  return number if number < 10
  remainder = number % 10
  next_number = number / 10
  (remainder * 10**magnitude_of_ten(number)) + reverse(next_number)
end

def magnitude_of_ten(number)
  return 0 if number < 10
  magnitude_of_ten(number/10) + 1
end
