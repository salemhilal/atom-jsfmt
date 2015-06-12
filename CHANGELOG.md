Changelog
---------

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
