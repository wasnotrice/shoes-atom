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

Here's a "Hello, world!" example.

```ruby
Shoes.app :width => 300, :height => 300 do
  banner "Hello, world!"
end
```

![shoes-atom](https://www.dropbox.com/s/3rrgeyachu1ofq2/Screenshot%202014-05-18%2022.17.14.png)
![Shoes 4 (Swt)](https://www.dropbox.com/s/p6mf03qw45rhi80/Screenshot%202014-05-18%2022.19.16.png)
![Shoes 3](https://www.dropbox.com/s/8zux0e1x9iljkse/Screenshot%202014-05-18%2022.19.46.png)

## Development status

Proof-of-concept. You can pretty much just write a "Hello, world!" app.
Currently, this project also uses a patched version of Shoes. Mostly, we are
just ignoring the filesystem for now, but this shouldn't be a limitation in the
future.


## Getting started

[Download atom-shell](https://github.com/atom/atom-shell/releases) and install it. On OS X, unzip the download and drag it to `/Applications`.

Pick a directory and clone this repository.

    cd ~/code
    git clone https://www.github.com/wasnotrice/shoes-atom

Clone Shoes as a sibling of your `shoes-atom` and check out the `opal` branch.

    cd ~/code
    git clone https://www.github.com/wasnotrice/shoes4
    cd shoes4
    git checkout 'opal'

Build the project. This compiles Opal, Shoes, and a sample app. Build products
get installed into the sample directory `ruby-app`.

    cd ../shoes-atom
    rake

Open the app with your downloaded Atom shell. For OS X,

    /Applications/Atom.app/Contents/MacOS/Atom ruby-app

That's it!

## Contributing

Contributions are very welcome. Fork, hack, and make a pull request. Cheers!

