Gamz project
============

Quality games on the web, without Flash.

License is not yet determined, you can fork, make pull request and use at home, but not build business on top of it.
More informations to come later.


Installation
------------

1.  As Gamz is a [Symfony2](http://symfony.com/) project, you first need PHP 5.3 and the webserver of your choice.

2.  Javascripts are written in [CoffeeScript](http://jashkenas.github.com/coffee-script)
    so you'll need [Node.js](http://nodejs.org) and [npm](http://npmjs.org/):

    -   [Install Node.js](https://github.com/joyent/node/wiki/Installation)
    -   [Install npm](https://github.com/isaacs/npm)
    -   Install CoffeeScript compiler: `npm install -g coffee-script`

3.  CSS are written with [Sass](http://sass-lang.com/) and [Compass](http://compass-style.org/)
    wich need [Ruby](http://www.ruby-lang.org/):

    -   [Install Ruby](http://www.ruby-lang.org/en/downloads/)
    -   [Install Sass](http://sass-lang.com/download.html)
    -   [Install Compass](http://compass-style.org/install)

3.  Get the sources via git with submodules

        git clone git@github.com:gamz/GamzProject.git
        git submodule update --init

4.  Install vendors:

        ./bin/vendor install

5.  Configure parameters:

        cp app/config/parameters.yml.dist app/config/parameters.yml
        vim app/config/parameters.yml
