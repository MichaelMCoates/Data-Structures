class Array
  def hash
    self.each.inject(0) do |sub_hash, el|
      sub_hash ^ el.hash
    end
  end
end

class String
  def hash
    self.chars.map(&:ord).hash
  end
end

class Hash
  def hash
    self.to_a.hash
  end
end
