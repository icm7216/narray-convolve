# frozen_string_literal: true

require "test_helper"
class Narray::ConvolveTest < Test::Unit::TestCase
  self.test_order = :defined

  sub_test_case "narray convolve" do
    setup do
      @a = Numo::DFloat.new(10).seq
    end

    data(
      "1 full:" => [{mode: :full, arr: [0,1,2,3,4,5,6,7,8,9]}, 1],
      "1 same:" => [{mode: :same, arr: [0,1,2,3,4,5,6,7,8,9]}, 1],
      "1 valid:" => [{mode: :valid, arr: [0,1,2,3,4,5,6,7,8,9]}, 1],

      "2 full:" => [{mode: :full, arr: [0,1,4,7,10,13,16,19,22,25,18]}, 2],
      "2 same:" => [{mode: :same, arr: [0,1,4,7,10,13,16,19,22,25]}, 2],
      "2 valid:" => [{mode: :valid, arr: [1,4,7,10,13,16,19,22,25]}, 2],
    
      "3 full:" => [{mode: :full, arr: [0,1,4,10,16,22,28,34,40,46,42,27]}, 3],
      "3 same:" => [{mode: :same, arr: [1,4,10,16,22,28,34,40,46,42]}, 3],
      "3 valid:" => [{mode: :valid, arr: [4,10,16,22,28,34,40,46]}, 3],
    
      "4 full:" => [{mode: :full, arr: [0,1,4,10,20,30,40,50,60,70,70,59,36]}, 4],
      "4 same:" => [{mode: :same, arr: [1,4,10,20,30,40,50,60,70,70]}, 4],
      "4 valid:" => [{mode: :valid, arr: [10,20,30,40,50,60,70]}, 4],
    
      "5 full:" => [{mode: :full, arr: [0,1,4,10,20,35,50,65,80,95,100,94,76,45]}, 5],
      "5 same:" => [{mode: :same, arr: [4,10,20,35,50,65,80,95,100,94]}, 5],
      "5 valid:" => [{mode: :valid, arr: [20,35,50,65,80,95]}, 5],
  
      "6 full:" => [{mode: :full, arr: [0,1,4,10,20,35,56,77,98,119,130,130,118,93,54]}, 6],
      "6 same:" => [{mode: :same, arr: [4,10,20,35,56,77,98,119,130,130]}, 6],
      "6 valid:" => [{mode: :valid, arr: [35,56,77,98,119]}, 6],
      
      "7 full:" => [{mode: :full, arr: [0,1,4,10,20,35,56,84,112,140,158,165,160,142,110,63]}, 7],
      "7 same:" => [{mode: :same, arr: [10,20,35,56,84,112,140,158,165,160]}, 7],
      "7 valid:" => [{mode: :valid, arr: [56,84,112,140]}, 7],
      
      "8 full:" => [{mode: :full, arr: [0,1,4,10,20,35,56,84,120,156,182,197,200,190,166,127,72]}, 8],
      "8 same:" => [{mode: :same, arr: [10,20,35,56,84,120,156,182,197,200]}, 8],
      "8 valid:" => [{mode: :valid, arr: [84,120,156]}, 8],
      
      "9 full:" => [{mode: :full, arr: [0,1,4,10,20,35,56,84,120,165,200,224,236,235,220,190,144,81]},9],
      "9 same:" => [{mode: :same, arr: [20,35,56,84,120,165,200,224,236,235]}, 9],
      "9 valid:" => [{mode: :valid, arr: [120,165]}, 9],
    )

    def test_convolve_method(data)
      d, target = data
      m = Numo::DFloat[*1..target].reverse
      mode = d[:mode]
      expected = Numo::DFloat.cast(d[:arr])
      actual = Narray::Convolve.convolve(@a, m, mode)
      assert_equal(expected, actual)
    end
    
  end
end
