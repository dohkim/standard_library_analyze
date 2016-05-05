module DohAbb
  def doh_abb(words, pattern = nil)
    table = {}
    seen=Hash.new(0)
    # safe way conver string to regex
    # /#{Regexp.quote(your_string)}/
    if pattern.is_a? String
      pattern = /\A#{Regexp.quote(pattern)}/
    end
    
    words.each do |word|
      next if word.empty?
      word.size.downto(1) do |len| 
        abbrev = word[0...len]
        next if pattern && pattern !~ abbrev
        
        case seen[abbrev] += 1
        when 1
          table[abbrev]=word
        when 2
          table.delete(abbrev)
        else
          break
        end
      end
    end
    
    words.each do |word|
      next if pattern && pattern !~ abbrev
      table[word]=word
    end
    table
  end
  
  module_function :doh_abb
end

class Array
  def doh_abb(pattern=nil)
    DohAbb::doh_abb(self, pattern)
  end
end