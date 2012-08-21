gpx2kml
=======

Genarate kml file from gpx files
--------------------------------
Convert gpx files to kml files, and clean trackpoints with [Douglas Peucker](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm) algorythm


How to use it
-------------

1. gem install gpx2kml

2. Go to path where you have GPX files.

    gpx2kml -i [input GPX files] -i [output KML file] -e [epsylon float]

  Example:

  gpx2kml -i examples/test.gpx,examples/test-2.gpx -i test.kml -e 30e-5


Copyright
---------

Copyright (c) 2012 Shakaman. See LICENSE for further details.
