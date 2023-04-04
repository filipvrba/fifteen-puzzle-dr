def pp str_hash
  result = str_hash.to_s
  # l_symbols = lambda { |s| return ["#{s}", "#{s}\n"] }
  "{}[]".chars.each do |s|
    result = result.gsub(s, "#{s}\n")
  end

  puts result
end