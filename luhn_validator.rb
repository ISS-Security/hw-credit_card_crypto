module LuhnValidator
# Validates credit card number using Luhn Algorithm
# arguments: none
# assumes: a local String called 'number' exists
# returns: true/false whether last digit is correct
def validate_checksum
#pass number to characters with the map function
nums_a = number.to_s.chars.map(&:to_i)
#Get the last digit to make the last comparison with check digit
last_digit = nums_a.pop
#variable to store the sum of the numbers
total =0
#Reverse the array to start counting from the one at the right
nums_a.reverse!
#Create and array with all the numbers that are even
evens= nums_a.values_at(* nums_a.each_index.select {|i| i.even?})
#Create and array with all the numbers that are odd
odds = nums_a.values_at(* nums_a.each_index.select {|i| i.odd?})
#Add all the numbers within the array
odds.each{|num| total +=num}
#define a function for doubling the numbers and divide them and return total
def suma(num)
total =0
((num*2).to_s.chars.map(&:to_i)).each{|x| total+=x}
return total
end
#MUltiply the even index values by 2
total_evens = 0
evens.each{|num| total_evens += suma(num)}
total+=total_evens
#FInding the check digit
check_digit = (total*9)%10
if last_digit ==check_digit
return true
else
return false
end
end
end
