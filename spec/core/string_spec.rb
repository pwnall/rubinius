require File.dirname(__FILE__) + '/../spec_helper'

# %, *, +, <<, <=>, ==, =~, [], []=, capitalize, capitalize!,
# casecmp, center, chomp, chomp!, chop, chop!, concat, count, crypt,
# delete, delete!, downcase, downcase!, dump, each, each_byte,
# each_line, empty?, eql?, gsub, gsub!, hash, hex, include?, index,
# initialize_copy, insert, inspect, intern, length, ljust, lstrip,
# lstrip!, match, next, next!, oct, replace, reverse, reverse!,
# rindex, rjust, rstrip, rstrip!, scan, size, slice, slice!, split,
# squeeze, squeeze!, strip, strip!, sub, sub!, succ, succ!, sum,
# swapcase, swapcase!, to_f, to_i, to_s, to_str, to_sym, tr, tr!,
# tr_s, tr_s!, unpack, upcase, upcase!, upto

context "String" do
  
  specify "<< should concatenate the other object" do
    example do
      @a = 'hello '
      p [@a << 'world', @a << 33]
    end.should == '["hello world", "hello world!"]'
  end
  
  specify "index with substring arg should return substring when it exists" do
    example do
      p "hello".index('e')
    end.should == "1"
  end

  specify "underlying storage should have the correct size (space for last \0 and multiple of 4)" do
    example do
      p "hell".data.size
    end.should == "8"
  end
  
  specify "to_i should convert the string to an integer base (2, 8, 10, or 16)" do
    example do
      p [ "12345".to_i,
          "99 red balloons".to_i,
          "0a".to_i,
          "0a".to_i(16),
          "hello".to_i,
          "1100101".to_i(2),
          "1100101".to_i(8),
          "1100101".to_i(10),
          "1100101".to_i(16) ]
    end.should == '[12345, 99, 0, 10, 0, 101, 294977, 1100101, 17826049]'
  end
  
  specify "substring should return the portion of string specified by index, length" do
    example do
      p [ "blah".substring(0, 2),
          "blah".substring(0, 4),
          "blah".substring(2, 2) ]
    end.should == '["bl", "blah", "ah"]'
  end
  
  specify "[] with index should return the code of the character at index" do
    example do
      puts "hello"[1]
    end.should == '101'
  end
  
  specify "[] with start, length should return the substring of length characters begin at start" do
    example do
      p [ "hello"[1, 3],
          "hello"[-3, 2],
          "hello"[5, 7] ]
    end.should == '["ell", "ll", ""]'
  end
  
  specify "[] with range should return the substring specified by range" do
    example do
      p [ "world"[0..2],
          "world"[-4..-2],
          "world"[1...3] ]
    end.should == '["wor", "orl", "or"]'
  end
  
  specify "[] with regexp should return the string matching pattern" do
    example do
      p [ "hello there"[/[aeiou](.)\1/],
          "hello there"[/ell/],
          "hello there"[/o /],
          "hello there"[/d/] ]
    end.should == '["ell", "ell", "o ", nil]'
  end
  
  specify "[] with regexp, index should return the string specified by the nth component MatchData" do
    example do
      p [ "hello there"[/[aeiou](.)\1/, 0],
          "hello there"[/he/, 1],
          "hello there"[/he/, 0],
          "hello there"[/[aeiou](.)\1/, 2] ]
    end.should == '["ell", nil, "he", nil]'
  end
  
  specify "[] with string should " do
    example do
      p [ "hello"["el"],
          "hello"["bye"],
          "hello"["hello"] ]
    end.should == '["el", nil, "hello"]'
  end
  
  specify "prefix? should be true if string begins with argument" do
    example do
      p [ "blah".prefix?("bl"),
          "blah".prefix?("fo"),
          "go".prefix?("gogo") ]
    end.should == '[true, false, false]'
  end
  
  specify "index with fixnum should return the index of the given character" do
    example do
      p [ "hello".index(101),
          "hello".index(52) ]
    end.should == '[1, nil]'
  end
  
  specify "index with string should return the index of the beginning of string" do
    example do
      p [ "hello".index('e'),
          "hello".index('lo', -3),
          "hello".index('lo', -1),
          "hello".index('a') ]
    end.should == '[1, 3, nil, nil]'
  end
  
  specify "index with regexp should return the index of the beginning of pattern" do
    example do
      puts [ "hello".index(/[aeiou]/, -3),
             "hello".index(/he/, 2),
             "hello".index(/el/) ]
    end.should == '[4, nil, 1]'
  end
  
  specify "slice should be a synonym for []" do
    example do
      p [ "hello"[1],
          "hello"[-3, 2],
          "world"[-4..-2],
          "hello there"[/[aeiou](.)\1/],
          "hello there"[/[aeiou](.)\1/, 0],
          "hello"["bye"] ]
    end.should == '[101, "ll", "orl", "ell", "ell", nil]'
  end
  
  specify "split with no argument should return an array of substrings separated by $;" do
    example do
      p [ $;.nil?,
          "hello world".split,
          "hello\frubinius".split,
          $; = 't',
          "splitme".split ]
    end.should == '[true, ["hello", "world"], ["hello", "rubinius"], "t", ["spli", "me"]]'
  end
  
  specify "split with string should return an array of substrings separated by string" do
    example do
      p [ "hello".split('l'),
          "hello".split('e'),
          "hello".split('h'),
          "hello".split('el'),
          "hello".split('o'),
          "hello".split('d') ]
    end.should == '[["he", "", "o"], ["h", "llo"], ["", "ello"], ["h", "lo"], ["hell"], ["hello"]]'
  end
  
  specify "split with regexp should return an array of substrings separated by pattern" do
    example do
      p [ "hello".split(/l/),
          "hello".split(/[aeiou]/),
          "hello".split(/h/),
          "hello".split(/el/),
          "hello".split(/[abcde]/),
          "hello".split(/def/) ]
    end.should == '[["he", "", "o"], ["h", "ll"], ["", "ello"], ["h", "lo"], ["h", "llo"], ["hello"]]'
  end
end
