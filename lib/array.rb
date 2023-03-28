class Array
  def splice(start, len, *replace)
    ret = self[start, len]
    self[start, len] = replace
    ret
  end
end