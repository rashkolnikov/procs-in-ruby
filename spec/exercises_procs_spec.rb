require "exercises_procs"

describe "Procs tests" do
  describe "my_map" do
    it "should accept an array and a block as args" do
      expect { my_map([1,2,3]) { |n| 2 * n } }.to_not raise_error
    end

    it "should return a new array where the elements are the results of the block when passed in each element of the original array" do
      expect(my_map([1,2,3]) { |n| 2 * n }).to eq([2,4,6])
      expect(my_map(["Hey", "Jude"]) { |word| word + "?" }).to eq(["Hey?", "Jude?"])
      expect(my_map([false, true]) { |bool| !bool }).to eq([true, false])
    end

    it "should not use the built-in Array#map" do
      array = [1,2,3]
      expect(array).to_not receive(:map)
      my_map(array) { |n| 2 * n }
    end
  end

  describe "my_select" do
    it "should accept an array and a block as args" do
      expect { my_select([1,2,3,8]) { |n| n.even? } }.to_not raise_error
    end

    it "should return a new array where the elements are elements of the original array where the block resulted in true" do
      expect(my_select([1,2,3,8]) { |n| n.even? }).to eq([2, 8])
      expect(my_select([0, 2018, 1994, -7]) { |n| n > 0 }).to eq([2018, 1994])
      expect(my_select([6, 11, 13], &:odd?)).to eq([11, 13])
    end

    it "should not use the built-in Array#select" do
      array = [1,2,3]
      expect(array).to_not receive(:select)
      my_select(array) { |n| n.even? }
    end
  end

  describe "my_count" do
    it "should accept an array and a block as args" do
      expect { my_count([1,4,3,8]) { |n| n.even? } }.to_not raise_error
    end

    it "should return a number representing the count of elements that result in true when passed into the block" do
      expect(my_count([1,4,3,8]) { |n| n.even? }).to eq(2)
      expect(my_count(["DANIEL", "JIA", "KRITI", "dave"]) { |s| s == s.upcase }).to eq(3)
      expect(my_count(["daniel", "jia", "kriti", "dave"]) { |s| s == s.upcase }).to eq(0)

    end

    it "should not use the built-in Array#count" do
      array = [1,4,3,8]
      expect(array).to_not receive(:count)
      my_count(array) { |n| n.even? }
    end
  end

  describe "my_any?" do
    it "should accept an array and a block as args" do
      expect { my_any?([7, 10, 3, 5]) { |n| n.even? } }.to_not raise_error
    end

    context "when at least 1 element of the array results in true when passed into the block" do
      it "should return true" do
        expect(my_any?([7, 10, 3, 5]) { |n| n.even? }).to eq(true)
        expect(my_any?([7, 10, 4, 5]) { |n| n.even? }).to eq(true)
        expect(my_any?(["q", "r", "s", "i"]) { |char| "aeiou".include?(char) }).to eq(true)
      end
    end

    context "when all elements of the array result in false when passed into the block" do
      it "should return false" do
        expect(my_any?([7, 11, 3, 5]) { |n| n.even? }).to eq(false)
        expect(my_any?(["q", "r", "s", "t"]) { |char| "aeiou".include?(char) }).to eq(false)
      end
    end

    it "should not use the built-in Array#any?" do
      array = [7, 10, 3, 5]
      expect(array).to_not receive(:any?)
      my_any?(array) { |n| n.even? }
    end
  end

  describe "my_all?" do
    it "should accept an array and a block as args" do
      expect { my_all?([3, 5, 7, 11]) { |n| n.odd? } }.to_not raise_error
    end

    context "when all elements of the array result in true when passed into the block" do
      it "should return true" do
        expect(my_all?([3, 5, 7, 11]) { |n| n.odd? }).to eq(true)
        expect(my_all?([-8, -9, -6]) { |n| n < 0 }).to eq(true)
      end
    end

    context "when at least 1 of the elements of the array result in false when passed into the block" do
      it "should return false" do
        expect(my_all?([3, 5, 8, 11]) { |n| n.odd? }).to eq(false)
        expect(my_all?([-8, -9, -6, 0]) { |n| n < 0 }).to eq(false)
      end
    end

    it "should not use the built-in Array#all?" do
      array = [3, 5, 7, 11]
      expect(array).to_not receive(:all?)
      my_all?(array) { |n| n.odd? }
    end
  end

  describe "my_none?" do
    it "should accept an array and a block as args" do
      expect { my_none?([3, 5, 7, 11]) { |n| n.even? } }.to_not raise_error
    end

    context "when none of the elements of the array result in true when passed into the block" do
      it "should return true" do
        expect(my_none?([3, 5, 7, 11]) { |n| n.even? }).to eq(true)
        expect(my_none?(["sushi", "pizza", "burrito"]) { |word| word[0] == "a" } ).to eq(true)
      end
    end

    context "when at least 1 element of the array results in true when passed into the block" do
      it "should return false" do
        expect(my_none?([3, 5, 4, 7, 11]) { |n| n.even? } ).to eq(false)
        expect(my_none?(["asparagus", "sushi", "pizza", "apple", "burrito"]) { |word| word[0] == "a" } ).to eq(false)
      end
    end

    it "should not use the built-in Array#none?" do
      array = [3, 5, 7, 11]
      expect(array).to_not receive(:none?)
      my_none?(array) { |n| n.even? }
    end
  end

  describe "reverser" do
    it "should accept a string and a block as args" do
      expect { reverser("abcd") { |string| string.upcase } }.to_not raise_error
    end

    it "should return the result of the block when passed the string with it's characters reversed" do
      expect(reverser("abcd") { |string| string.upcase }).to eq("DCBA")
      expect(reverser("hello") { |string| string + "!!!" }).to eq("olleh!!!")
    end
  end

  describe "word_changer" do
    it "should accept a sentence string and a block as args" do
      expect { word_changer("goodbye moon") { |word| word.upcase + "!" } }.to_not raise_error
    end

    it "should return a new sentence where every word becomes the result of the block when passed the original word of the sentence" do
      expect(word_changer("goodbye moon") { |word| word.upcase + "!" }).to eq("GOODBYE! MOON!")
      expect(word_changer("Hello World") { |word| ".." + word.downcase + ".." }).to eq("..hello.. ..world..")
    end
  end

  describe "greater_proc_value" do
    it "should accept a number and two procs as args" do
      proc_1 = Proc.new { |n| n * 10 }
      proc_2 = Proc.new { |n| n * n }

      expect { greater_proc_value(3, proc_1, proc_2) }.to_not raise_error
    end

    it "should return the greater result of the two procs when each is passed the number" do
      times_10 = Proc.new { |n| n * 10 }
      square = Proc.new { |n| n * n }
      negate = Proc.new { |n| n * -1 }

      expect(greater_proc_value(3, times_10, square)).to eq(30)
      expect(greater_proc_value(12, times_10, square)).to eq(144)
      expect(greater_proc_value(-5, times_10, negate)).to eq(5)
    end
  end

  describe "and_selector" do
    it "should accept an array and two procs as args" do
      proc_1 = Proc.new { |n| n.even? }
      proc_2 = Proc.new { |n| n < 0 }

      expect { and_selector([-5, 0, -8, 8, -2], proc_1, proc_2) }.to_not raise_error
    end

    it "should return a new array containing elements of the original array that result in true when passed into both procs" do
      even = Proc.new { |n| n.even? }
      negative = Proc.new { |n| n < 0 }

      expect(and_selector([-5, 0, -8, 8, -2], even, negative)).to eq([-8, -2])
      expect(and_selector([5, 4, 10, 15], even, negative)).to eq([])
    end
  end

  describe "alternating_mapper" do
    it "should accept an array and two procs as args" do
      proc_1 = Proc.new { |n| n / 2.0 }
      proc_2 = Proc.new { |n| n * 1000 }

      expect { alternating_mapper([1,2,3,4,5], proc_1, proc_2) }.to_not raise_error
    end

    it "should return a new array where all of the elements at even indices are the results when those elements are passed into the first proc and all of the elements at odd indices are the results when those elements are passed into the second proc" do
      half = Proc.new { |n| n / 2.0 }
      times_thousand = Proc.new { |n| n * 1000 }
      expect(alternating_mapper([1,10,4,7,5], half, times_thousand)).to eq([0.5, 10000, 2.0, 7000, 2.5])
    end
  end
end
