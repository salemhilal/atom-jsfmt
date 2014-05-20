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



Changelog
---------
The changelog can be viewed [here][changelog]


License
-------
Atom-jsfmt is licensed under the MIT license, which can be viewed [here][license]


[gofmt]:https://github.com/darkhelmet/atom-gofmt
[jsfmt]:https://github.com/rdio/jsfmt
[rdio]:https://github.com/rdio
[changelog]:./CHANGELOG.md
[license]: ./LICENSE.md
