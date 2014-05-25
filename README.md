atom-jsfmt
==========

[`jsfmt`][jsfmt] plugin for the Atom text editor.

Features
--------
 - **Format command**: Run the `Jsfmt: Format` command to keep your code tidy.
 - **Format on Save**: `atom-jsfmt` will auto-format your javascript on save.

Installation
------------

Make sure you have `jsfmt` installed, and then just install `atom-jsfmt` as you would any other package.

```bash
npm install -g jsfmt
apm install atom-jsfmt
# Or search for / install atom-jsfmt in Atom's package browser
```
If you have `jsfmt` installed in a different location, be sure to set this location in the
`atom-jsfmt` preferences (under "Path To Jsfmt").

Options
-------

 - **Path To Jsfmt**: This is the path to the `jsfmt` binary. Defaults to `jsfmt`.
   Set this if your binary isn't in your `$PATH`.
 - **Show Errors**: Whether or not you want to see error messages. You probably do.
   This is set to `true` by default.
 - **Format On Save**: Whether or not you automatically want to format your javascript
   files when you save. Defaults to `true`.



To do
-----

 - Allow for input of custom rules
 - Add searching functionality
 - Flag lines with errors
 - Add a "Format project" command


Credit
------

 - [`jsfmt`][jsfmt] is written and maintained by the good folks at [rdio][rdio].
 - Inspiration taken from [Darkhelmet's gofmt package][gofmt].


Changelog
---------
The changelog can be viewed [here][changelog].


License
-------
Atom-jsfmt is licensed under the MIT license, which can be viewed [here][license].


[gofmt]:https://github.com/darkhelmet/atom-gofmt
[jsfmt]:http://rdio.github.io/jsfmt/
[rdio]:https://github.com/rdio
[changelog]:./CHANGELOG.md
[license]: ./LICENSE.md
