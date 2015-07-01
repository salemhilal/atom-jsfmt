atom-jsfmt
==========
![David](https://david-dm.org/bichiliad/atom-jsfmt.svg)

`atom-jsfmt` is a [`jsfmt`][jsfmt] plugin for the Atom text editor. [`jsfmt`][jsfmt] is really good at formatting, searching, and rewriting javascript. It's pretty nifty.  

![atom-jsfmt in action](https://github.com/bichiliad/atom-jsfmt/raw/master/demo.gif)


What does it do?
----------------

 - **Format your code**: Run the `Jsfmt: Format` command to keep your code well-styled.
 - **Format on save**: `atom-jsfmt` will auto-format your javascript every time you save, so you don't have to think about it.


How do I get it?
----------------

Installation can be done from Atom's package browser (just search for `atom-jsfmt`). You can also use the `apm` command line installer:

```bash
apm install atom-jsfmt
```


How do I tweak the formatting?
------------------------------

Although the default style guide is pretty good, you may find yourself wanting to tweak the formatting.
`atom-jsfmt` looks for the closest `.jsfmtrc` file before formatting (you can [read more about them
here](https://github.com/rdio/jsfmt#jsfmtrc)). It checks the directory of the current file,
and keeps moving up directories until it finds something.

For example, if you like your code indented four spaces, your `.jsfmtrc` might look like this:

```json
{
    "indent": {
        "value": "    "
    }
}
```

Options
-------

 - **Show Errors**: Whether or not you want to see error messages. You probably do.
   This is set to `true` by default.
 - **Format On Save**: Whether or not you automatically want to format your javascript
   files when you save. Defaults to `true`.



To do
-----

 - Look for `.jsfmtrc` files in all the places that the command line tool looks (like `/etc/.jsfmtrc` or `~/.jsfmtrc`).
 - Add searching / rewriting functionality
 - Flag lines with errors


Credit
------

 - [`jsfmt`][jsfmt] is written and maintained by the good folks at [rdio][rdio].


Changelog
---------
The changelog can be viewed [here][changelog].


License
-------
Atom-jsfmt is licensed under the MIT license, which can be viewed [here][license].


[jsfmt]:http://rdio.github.io/jsfmt/
[rdio]:https://github.com/rdio
[changelog]:./CHANGELOG.md
[license]:./LICENSE.md
[env]:http://discuss.atom.io/t/atom-command-doesnt-pass-environment-variables-to-atom/1596
