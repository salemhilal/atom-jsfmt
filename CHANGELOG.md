Changelog
---------

v0.8.5
======
 * Added CSP workaround which, although gross, is the only fix until one of `jsfmt`’s
   dependencies updates to the newest version of `acorn`. See more
   [here](https://github.com/bichiliad/atom-jsfmt/pull/20). Thanks to @mikaa123 for the
   PR (#20).


v0.8.4
======
Merged PR
 * Added proper `jsx` support (thanks @andrewn) with PR #18.
 * Bumped `jsfmt` version to `0.5.1` (thanks @vdaniuk) with PR #17.
 * Metadata changes to `package.json`

v0.8.3
======
 * *Added david-dm, updated readme

v0.8.2
======
 * Fixed bug in which errors without line numbers would cause the app to crash.

v0.8.1
======
 * Updated documentation, included a `.jsfmtrc` example.

v0.8.0
======
 * Added support for `.jsfmtrc` files.

v0.7.1
======
 * Fixed issue with line numbers not being parsed properly
 * Updated README.md

v0.7.0
======
 * Removed deprecated Atom API calls (see [this issue](https://github.com/atom/atom/issues/6867))
 * Moved to [atom-message-panel](https://github.com/tcarlsen/atom-message-panel)
 * Minor bug fixes.

v0.6.0
======
 * No longer requires a binary (uses pre-release `jsfmt` with a nicer api)
 * Format across all open editors
 * Optionally saves after formatting (off by default)
 * Merge edits via diff, rather than by replacement (faster for larger files).
 * Disk no longer more up-to-date then editor (oops).
 * No need to enhance path anymore.
 * Just pretty much works way better.

v0.5.1
======
 * Enhances path before running binary.

v0.5.0
======
 * Ported everything to coffeescript.
 * Click-to-dismiss errors
 * Changed default `jsfmt` location to `/usr/local/bin/jsfmt` (Addresses issue #1)
 * You are now told if `jsfmt` isn't where you say it is.
 * Fixed a bug with the way unhandled errors were being logged

v0.4.0
======
 * Better handling of error messages.
 * Error messages no longer appear across editors.

v0.3.0
======

 * Added error messages on unsuccessful formats
 * Added this changelog, with plans to retroactively add old changes.
