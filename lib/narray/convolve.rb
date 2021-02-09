# frozen_string_literal: true

require_relative "convolve/version"
require "numo/narray"

module Narray
  module Convolve
    # 
    # Narray::Convolve is similar to numpy.convolve, 
    # but with a different order of second arguments.
    #
    # @example
    #   Narray::Convolve
    #
    #   require "narray/convolve"
    #   n = Numo::DFloat[1,2,3]
    #   m = Numo::DFloat[0,1,0.5].reverse
    #   Narray::Convolve.convolve(n, m, :same)
    #   # => [1, 2.5, 4]
    # 
    #   or 
    # 
    #   Narray::Convolve.convolve([1,2,3], [0,1,0.5].reverse, :same)
    #   # => [1, 2.5, 4]
    #
    #   In case of numpy.convolve
    #   >>> numpy.convolve([1,2,3],[0,1,0.5], 'same')
    #   array([1. , 2.5, 4. ])
    #
    # 
    # 
    # @param n [Numo::DFloat or Array]
    # @param m [Numo::DFloat or Array]
    # @param mode [Symbol] (:full, :same, :valid)
    #
    # @return [Numo::DFloat] convolution of n and m.
    #
    def convolve(n, m, mode = :full)
      case n
      when Array
        n = Numo::DFloat.cast(n)
      when Numo::DFloat
        # ok
      else
        raise ArgumentError, "not Numo::DFloat: #{n.inspect[0..48]}"
      end

      case m
      when Array
        m = Numo::DFloat.cast(m)
      when Numo::DFloat
        # ok
      else
        raise ArgumentError, "not Numo::DFloat: #{n.inspect[0..48]}"
      end

      n_size = n.size
      m_size = m.size
      zero_size = m_size - 1
      out_size = zero_size + n_size
      n_end = out_size - 1
      work_size = out_size + zero_size

      out = Numo::DFloat.zeros(out_size)
      work = Numo::DFloat.zeros(work_size)
      work[zero_size..n_end].store(n[true])

      work_size.times do |i|
        w = i + zero_size
        if w < work_size
          out[i] = work[i..w].mulsum(m)
        end
      end

      case mode
      when :full
        # full: (N+M-1)    
        ans = out[true]
      when :same
        # same: [M,N].max
        s = (m_size / 2.0).round - 1
        e = s + n_size
        ans = out[s...e]
      when :valid
        # valid: [M,N].max - [M,N].min + 1
        s = zero_size
        e = m_size
        ans = out[s..-e]
      end
      ans
    end
    module_function :convolve    
  end
end

