atom-jsfmt
==========

Automatically run `jsfmt` every time you save a javascript source file.

It effectively runs `jsfmt -fw [your file].js` on save.
If an error occurs, it is displayed at the bottom of the editor. 

Usage
-----


Make sure you have `jsfmt` installed, and then just install `atom-jsfmt` as you would any other package

```bash
npm install -g jsfmt
apm install atom-jsfmt
```

If you have a custom location for the `jsfmt` binary, set the `Path To Jsfmt`
option accordingly.


To do
-----

 - Allow for input of custom rules
 - Flag lines with errors

Credit
------

 - [`jsfmt`][jsfmt] is written and maintained by the good folks at [rdio][rdio].
 - Inspiration taken from [Darkhelmet's gofmt package][gofmt]


License
-------
```
Copyright (c) 2014 Salem Hilal

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```


[gofmt]:https://github.com/darkhelmet/atom-gofmt
[jsfmt]:https://github.com/rdio/jsfmt
[rdio]:https://github.com/rdio
