
# Framer `Material` module

Google material design properties for your Framer layers. See the
[example][example].

## Usage
```shell
$ cd <myProject>.framer
$ npm install framer-material
```

modules/myModule.coffee:
```coffeescript
exports.Material = require "framer-material"
```

app.coffee:
```coffeescript
{Material} = require "myModule"

# Extend the functionality of `Layer`
# so that it inherits "material" properties
Material.mixin Layer

new Layer
  elevation: 24
  surfaceReaction: true
  rippleColor: Material.Color.Pink[500]

# You can also use it just like `Layer`
new Material elevation: 24
```

## API

### `Material.mixin(class <object>)`
Extend the functionality of `Layer` so that it inherits "material" properties.

### `Material.Color`
The material design [color palette][colors]. For example:
`Material.Color.Red.A100` will return the accent 100 tint.

### `Material#elevation <number>`
Give your layers the appropriate elevation (shadows will be automatically
created). See [the spec][elevation] for more info.

### `Material#surfaceReaction <boolean>`
Create a "ripple" effect when clicking/tapping on your layers. See
[the spec][ripple] for more info.

### `Material#rippleColor <string>`
Set a ripple color.

### `Material#showRipple()`
Show the ripple.

### `Material#hideRipple()`
Hide the ripple.

## License
The MIT License (MIT)

Copyright (c) 2015 Pete Schaffner

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[colors]: https://www.google.com/design/spec/style/color.html
[elevation]: https://www.google.com/design/spec/what-is-material/elevation-shadows.html
[ripple]: https://www.google.com/design/spec/animation/responsive-interaction.html#responsive-interaction-user-input
[example]: http://share.framerjs.com/eagqdhh5xo1x/
