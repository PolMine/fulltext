fulltext 0.0.0.9004
===================

* The vignette works, again.


fulltext 0.0.0.9003
===================

* Added a template for an ioslides presentation that includes fulltext htmlwidgets. 

fulltext 0.0.0.9002
===================

* Introduced a new standard generic `as.fulltexttable`. The function `as.fulltexttable` is now the
  method `as.fulltexttable` for the virtual class `slice` from the polmineR package.
* The method `as.fulltexttable` has a new argument `display` to indicate whether the text should be visible ("none") or not ("block").
* Introduced a new tag para in the css to avoid that css for p overrides ioslides layout.
* commented out background color white.
* 

fulltext 0.0.0.9001
===================

* The 'fulltext' package is generated from the 'annolite' package. 
* Commented out "width: 854px;" for body from the css (markdown7.css) so that page width is adjusted.
* Commented out parts of markdown7.css that interfer with datatable layout.