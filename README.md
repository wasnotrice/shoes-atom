# shoes-atom

A Javascript backend for [Shoes](https://www.github.com/shoes/shoes4) that uses
the [Opal](http://opalrb.org/) Ruby to Javascript compiler and the
[atom-shell](https://github.com/atom/atom-shell) cross-platform application
shell.

Shoes apps work like the web. The layout flows like HTML. When _why first
started writing Hackety Hack, he event tried to render apps using Firefox's
Gecko engine. That makes complete sense, but unfortunately, it didn't work out.
Now, we have a convergence of sorts, where we can compile Ruby into Javascript,
and also render HTML/Javascript apps into a native window. This project is
working a layer above where _why struck out with Gecko. Instead of trying to
generate C code from Ruby and hook into the rendering engine primitives, we are
generating Javascript and HTML code from Ruby and using the engine's normal DOM
rendering, only in a custom application shell.

## Development status

Proof-of-concept. You can pretty much just write a "Hello, world!" app.
Currently, this project also uses a patched version of Shoes. Mostly, we are
just ignoring the filesystem for now, but this shouldn't be a limitation in the
future.


## Getting started

[Download atom-shell](https://github.com/atom/atom-shell/releases).

Pick a directory and clone this repository.

    cd ~/code
    git clone https://www.github.com/wasnotrice/shoes-atom

Clone Shoes as a sibling of your `shoes-atom` and check out the `atom` branch.

    cd ~/code
    git clone https://www.github.com/shoes/shoes4
    git checkout 'atom'

Build the project.

    cd shoes-atom
    rake

