# shoes-atom

A Javascript backend for [Shoes](https://www.github.com/shoes/shoes4) that uses
the [Opal](http://opalrb.org/) Ruby to Javascript compiler and the
[atom-shell](https://github.com/atom/atom-shell) cross-platform application
shell.

Shoes apps work like the web. The layout flows like HTML. When _why first started writing Hackety Hack, he even tried to render Shoes apps using Firefox's Gecko engine. Unfortunately, that didn't work out. Now, a few years later, we have a convergence of 3 projects:

* Opal: compiles Ruby into Javascript,
* Atom-shell: renders HTML/Javascript apps into a native window
* Shoes 4: supports multiple backend implementations for Shoes apps

That's all we need to use a browser's rendering engine for Shoes apps. The difference this time is that, instead of generating C code from Ruby and trying to hook into the rendering engine primitives, we are generating Javascript and HTML code from Ruby and using the engine's normal DOM rendering, only in a custom application shell. Fun, right?

Here's a "Hello, world!" example.

```ruby
Shoes.app :width => 300, :height => 300 do
  banner "Hello, world!"
end
```

![shoes-atom](https://dl.dropboxusercontent.com/spa/0dcvxe71jtnccsf/ccjx9fb2.png)
![Shoes 4 (Swt)](https://dl.dropboxusercontent.com/spa/0dcvxe71jtnccsf/3hyful8z.png)
![Shoes 3](https://dl.dropboxusercontent.com/spa/0dcvxe71jtnccsf/njr4w2da.png)

## Development status

Proof-of-concept. You can pretty much just write this "Hello, world!" app. Currently, this project also uses a patched version of Shoes. Mostly, we are just ignoring the filesystem for now, but this shouldn't be a limitation in the future.


## Getting started

0. [Download atom-shell](https://github.com/atom/atom-shell/releases) and install it. On OS X, unzip the download and drag it to `/Applications`.

1. Clone this repository.

        $ git clone https://www.github.com/wasnotrice/shoes-atom
        $ cd shoes-atom

2. Install Shoes and friends.

        $ bundle install

3. Build the project. This compiles Opal, Shoes, and an example app.

        $ rake

    Shoes gets compiled to `dist/shoes.js`. The example app in `examples/hello/src` gets compiled to `examples/hello/dist`.

4. Open the example app with your Atom app. On OS X, that looks like this:

        $ /Applications/Atom.app/Contents/MacOS/Atom examples/hello/dist

Congratulations. You're running a Shoes app :D

## Contributing

Contributions are very welcome. Fork, hack, and make a pull request. Cheers!

