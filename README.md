# Narray::Convolve

Narray::Convolve is returns the discrete, linear convolution of two one-dimensional sequences.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'narray-convolve'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install narray-convolve

## Usage

Narray::Convolve is similar to numpy.convolve, but with a different order of second arguments.
```
irb(main):001:0> require "narray/convolve"
=> true
irb(main):002:0> n = Numo::DFloat[1,2,3]
=>
Numo::DFloat#shape=[3]
...
irb(main):003:0> m = Numo::DFloat[0,1,0.5].reverse
=>
Numo::DFloat(view)#shape=[3]
...
irb(main):004:0> Narray::Convolve.convolve(n, m, :same)
=>
Numo::DFloat(view)#shape=[3]
[1, 2.5, 4]
```

In case of Python
```
>>> import numpy as np
>>> np.convolve([1,2,3],[0,1,0.5], 'same')
array([1. , 2.5, 4. ])
>>>
```
see: [numpy.convolve — NumPy v1.20 Manual](https://numpy.org/doc/stable/reference/generated/numpy.convolve.html#numpy-convolve)



## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
