def validate_checksum
  number = '4539075978941247'
  sum = 0
  nums_a = number.to_s.chars.map(&:to_i)
  r = (1..number.length)
  r.each do |i|
    i *= -1
    sum += ((nums_a[i] * 2) % 10 + (nums_a[i] * 2) / 10) if i.even?
    sum += nums_a[i] if i.odd?
  end
  return true if sum * 9 % 10 == nums_a[-1]

  false
end
validate_checksum
