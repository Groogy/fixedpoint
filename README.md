# fixedpoint

Implements fixed point arithmetics.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     fixedpoint:
       github: Groogy/fixedpoint
   ```

2. Run `shards install`

## Usage

To include the fixed point structure you have to write this to get started.

```crystal
require "fixedpoint"

include FP
```

Everything is defined in the FP namespace, it's optional to mixin the module but highly recommended. It provides some shortcut to also make things easier to work with.

* `FP::FixedPoint(Underlying, Scale)` is the struct that represents a fixed point value. Underlying is what underlying data type it will use while Scale is what it will scale that value with.
* `FP::FixedPoint32` is an alias for FixedPoint(Int32, 1_000) and have a range of -2 147 483.648 to 2 147 483.647 with a precision of 3 digits
* `FP::FixedPoint64` is an alias for FixedPoint(Int64, 1_000_000) and have a range of -9 223 372 036 854.775808 to -9 223 372 036 854.775807 with a precision of 6 digits.
* `FP.fp32(Number)` is a shortcut function to construct a `FixedPoint32` value from the given number
* `FP.fp64(Number)` is a shortcut function to construct a `FixedPoint64` value from the given number
* `FP.fp(Number)` is a shortcut function but will construct a FixedPoint based of the size of the given number.

## Future Development

Right now this uses a very naive implementation that does a lot of division meaning a bit slower performance, also limits the range a bit more than other solutions would, especially when it comes to multiplication. So next step should be to do a different kind of implementation that performs better and that let's us use the built-in LLVM operators for fixed point arithmetics.

## Contributing

1. Fork it (<https://github.com/Groogy/fixedpoint/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Groogy](https://github.com/Groogy) - creator and maintainer
