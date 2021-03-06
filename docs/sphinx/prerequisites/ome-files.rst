.. _prereq_ome_files:

OME Files
=========

Various software packages are required to be installed in order to
build from source.  Several of these may also be built and installed
by this super-build.  However, note that the super-build cannot
provide *all* prerequisites; some will still need installing before
building, shown in the table below.

.. tabularcolumns:: |l|l|l|c|c|c|c|

+----------------+--------------+--------------+--------------------------------------------------+
|                |           Version           |                   When required                  |
+----------------+--------------+--------------+----------+---------------+--------------+--------+
| Package        | Recommended  | Minimum      | build    | superbuild    | client build | Deploy |
+================+==============+==============+==========+===============+==============+========+
| OME Model      | 5.3.0        | 5.3.0        |    \•    |               | \•           | \•     |
+----------------+--------------+--------------+----------+---------------+--------------+--------+
| Boost          | 1.63         | 1.54         |    \•    |               | \•           | \•     |
+----------------+--------------+--------------+----------+---------------+--------------+--------+
| PNG            | 1.6          | 1.2          |    \•    |               | \•           | \•     |
+----------------+--------------+--------------+----------+---------------+--------------+--------+
| TIFF           | 4.0.7        | 4.0.3        |    \•    |               | \•           | \•     |
+----------------+--------------+--------------+----------+---------------+--------------+--------+
| CMake          | 3.7          | 3.2          |    \•    | \•            |              |        |
+----------------+--------------+--------------+----------+---------------+--------------+--------+
| Git            | 2.1.x        | 1.7.x        |    ◦     | ◦             |              |        |
+----------------+--------------+--------------+----------+---------------+--------------+--------+
| GraphicsMagick | 1.3.24       | 1.3.x        |    ◦     | ◦             |              |        |
+----------------+--------------+--------------+----------+---------------+--------------+--------+
| GTest          | 1.7          | 1.5          |    ◦     | ◦             |              |        |
+----------------+--------------+--------------+----------+---------------+--------------+--------+
| Doxygen        | 1.8          | 1.6          |    †     | †             |              |        |
+----------------+--------------+--------------+----------+---------------+--------------+--------+
| Graphviz       | 2.x          | 1.8.10       |    †     | †             |              |        |
+----------------+--------------+--------------+----------+---------------+--------------+--------+
| Python         | 2.7          | 2.6          |    ‡§    | ‡§            |              |        |
+----------------+--------------+--------------+----------+---------------+--------------+--------+
| Python Sphinx  | 1.4.x        | 1.1.x        |    ‡§    | ‡§            |              |        |
+----------------+--------------+--------------+----------+---------------+--------------+--------+
| TeX (XeLaTeX)  | TeXLive 2015 | TeXLive 2012 |    §     | §             |              |        |
+----------------+--------------+--------------+----------+---------------+--------------+--------+

\•
  Required
◦
  Optional
†
  Optional, needed to build the API reference
‡
  Optional, needed to build the manual pages
§
  Optional, needed to build the manual (HTML and PDF)
