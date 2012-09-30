[![Build Status](https://secure.travis-ci.org/rolandwalker/font-utils.png)](http://travis-ci.org/rolandwalker/font-utils)

Overview
========

Utility functions for working with fonts in Emacs.

Quickstart
----------

```lisp
(require 'font-utils)
 
(font-utils-exists-p "Courier")
```

font-utils
----------

Font-utils is a collection of functions for working with fonts.
This library has no user-level interface; it is only useful
for programming in Emacs Lisp.

The following functions are provided, most of which deal with
font names rather than font objects:

	font-utils-exists-p
	font-utils-first-existing-font
	font-utils-lenient-name-equal
	font-utils-list-names
	font-utils-name-from-xlfd
	font-utils-read-name

The most generally useful of these is `font-utils-exists-p`, which
tests whether a font matching the given name is currently available
for use.

To use font-utils, place the font-utils.el library somewhere
Emacs can find it, and add the following to your ~/.emacs file:

```lisp
(require 'font-utils)
```

Compatibility and Requirements
------------------------------

	GNU Emacs version 24.3-devel     : yes, at the time of writing
	GNU Emacs version 24.1 & 24.2    : yes
	GNU Emacs version 23.3           : yes
	GNU Emacs version 22.3 and lower : no

Uses if present: [persistent-soft.el](http://github.com/rolandwalker/persistent-soft) (Recommended)
