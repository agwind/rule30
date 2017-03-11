rule30
======

rule30 - An program to experiment with running [Elementary Cellular Automata](http://mathworld.wolfram.com/ElementaryCellularAutomaton.html)

This is two simple [Moose](https://metacpan.org/pod/Moose) classes, and a [Mojolicious::Lite](https://metacpan.org/pod/Mojolicious::Lite) app serving up our websocket for a [Vue.js](https://vuejs.org/) frontend.

## To install:

Install Mojolicious::Lite:

    # cpanm Mojolicious::Lite

Clone the repo:

    # git clone https://github.com/agwind/rule30.git

Run Mojolicious::Lite:

    # perl server.pl daemon


### To run tests

Install modules:

    # cpanm Test::More
    # cpanm Test::Deep

Run the tests:

    # perl server.pl test

## Warning

The current implementation will crush your browser if you let it run long enough.

## Copyright & License

Copyright (C) 2017, Benjamin Noggle,

This module is free software.  You can redistribute it and/or
modify it under the terms of the Artistic License 2.0.

This program is distributed in the hope that it will be useful,
but without any warranty; without even the implied warranty of
merchantability or fitness for a particular purpose.
