# License

Copyright (C) 2015 by Josef Friedrich <josef@friedrich.rocks>
------------------------------------------------------------------------
This work may be distributed and/or modified under the conditions of
the LaTeX Project Public License, either version 1.3 of this license
or (at your option) any later version.  The latest version of this
license is in:

  http://www.latex-project.org/lppl.txt

and version 1.3 or later is part of all distributions of LaTeX
version 2005/12/01 or later.

# Repository

https://github.com/Josef-Friedrich/fontspcm

# Installation

Get source:

    git clone git@github.com:Josef-Friedrich/fontspcm.git
    cd fontspcm

Compile:

    make

or manually:

    luatex fontspcm.ins
    lualatex fontspcm.dtx
    makeindex -s gglo.ist -o fontspcm.gls fontspcm.glo
    makeindex -s gind.ist -o fontspcm.ind fontspcm.idx
    lualatex fontspcm.dtx
