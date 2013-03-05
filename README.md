# Ruby Color Generator

[![Build Status](https://secure.travis-ci.org/opennorth/color-generator.png)](http://travis-ci.org/opennorth/color-generator)
[![Dependency Status](https://gemnasium.com/opennorth/color-generator.png)](https://gemnasium.com/opennorth/color-generator)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/opennorth/color-generator)

This gem randomly generates very distinct colors with consistent lightness and saturation.

If you are using these colors as background colors, consistent lightness lets you use the same foreground color for each. Consistent saturation lets you avoid mixing pastels with vibrant colors, etc.

## Usage

    require 'color-generator'

Generate colors using the HSL color representation:

    generator = ColorGenerator.new saturation: 0.3, lightness: 0.75
    color1 = generator.create_hex
    # => "cfd2ac"
    color2 = generator.create_hex
    # => "cbacd2"

Generate colors using the HSV color representation:

    generator = ColorGenerator.new saturation: 0.3, value: 1.0
    color1 = generator.create_hex
    # => "f7b3ff"
    color2 = generator.create_hex
    # => "b3ffe0"

If you want to make color generation repeatable, set a seed for the pseudorandom number generator:

    generator = ColorGenerator.new saturation: 0.3, value: 1.0, seed: 12345

If you prefer a decimal RGB value, call `create_rgb` instead of `create_hex`.

## Acknowledgements

Thanks to Martin Ankerl for his [blog post](http://martin.ankerl.com/2009/12/09/how-to-create-random-colors-programmatically/) which inspired this gem.

## Bugs? Questions?

This gem's main repository is on GitHub: [http://github.com/opennorth/color-generator](http://github.com/opennorth/color-generator), where your contributions, forks, bug reports, feature requests, and feedback are greatly welcomed.

Copyright (c) 2012 Open North Inc., released under the MIT license
