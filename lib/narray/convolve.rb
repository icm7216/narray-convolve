# frozen_string_literal: true

require_relative "convolve/version"
require "numo/narray"

module Narray
  module Convolve
    
    def convolve(n, m, mode = :full)
      zero_size = m.size - 1
      out_size = zero_size + n.size
      n_end = out_size - 1
      work_size = out_size + zero_size

      out = Numo::DFloat.zeros(out_size)
      work = Numo::DFloat.zeros(work_size)
      work[zero_size..n_end].store(n[true])

      work_size.times do |i|
        w = i + zero_size
        if w < work_size
          mul = work[i..w] * m
          out[i] = mul.sum
        end
      end

      case mode
      when :full # full: (N+M-1)
        ans = out[true]
      when :same # same: [M,N].max
        s = (m.size / 2.0).round - 1
        e = s + n.size
        ans = out[s...e]
      when :valid # valid: [M,N].max - [M,N].min + 1
        s = zero_size
        e = m.size
        ans = out[s..-e]
      end
      ans
    end
    module_function :convolve    
  end
end

