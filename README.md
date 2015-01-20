# shoes-atom

A pair of Javascript backends for [Shoes](https://www.github.com/shoes/shoes4) that use the [Opal](http://opalrb.org/) Ruby to Javascript compiler and the [atom-shell](https://github.com/atom/atom-shell) cross-platform application shell for running Shoes apps as desktop applications.

## Background

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

As an added bonus, if you just want to compile your Shoes app to a web page that any modern browser can render, you can do that, too! You lose a little functionality (for instance, you can't use the filesystem), but browsers are everywhere.

![shoes-browser](https://dl.dropboxusercontent.com/spa/0dcvxe71jtnccsf/s6ir4d2z.png)

## Development status

Proof-of-concept. You can pretty much just write this "Hello, world!" app. Currently, this project tracks the HEAD version of Shoes 4, and includes minor monkeypatches to make things work nicely. Mostly, we are just ignoring the filesystem for now, but this shouldn't be a limitation in the future, except for the browser.


## Getting started

0. [Download atom-shell](https://github.com/atom/atom-shell/releases) and install it. On OS X, unzip the download and drag it to `/Applications`.

1. Clone this repository.

        $ git clone https://www.github.com/wasnotrice/shoes-atom.git
        $ cd shoes-atom

2. Create a local copy of Shoes 4. This step is necessary temporarily to work around [an issue with prerelease versions of gems](https://github.com/rubygems/rubygems/issues/988).

        $ git clone https://www.github.com/shoes/shoes4.git
        $ cd shoes4
        $ rake build:shoes-core
        $ cd ../shoes-atom/vendor
        $ gem unpack ../shoes4/shoes-core/pkg/shoes-core-4.0.0.pre3.gem
        $ cd ..

3. Install other dependencies.

        $ bundle install

4. Build the project. This compiles Opal, Shoes, and an example app.

        $ rake

    This compiles two versions of Shoes: `dist/shoes-browser.js` and `dist/shoes-atom.js`, for running in a browser, and in atom-shell, respectively. The example app in `examples/hello.rb` gets compiled to `build/hello/browser` and `build/hello/atom`.

5. Open the example app with your browser, or with your Atom app. On OS X, that looks like this:

        $ open build/hello/browser/index.html
        $ /Applications/Atom.app/Contents/MacOS/Atom build/hello/atom

Congratulations. You're running a Shoes app :D


## Tour of the project

The goal for this project is to provide two backends for Shoes apps: a `browser` backend and an `atom` backend. The browser backend will implement as many Shoes features as possible, but there are some that will not be possible because of the limitations of the browser environment (e.g. reading and writing to arbitrary files). The atom backend will extend the browser backend. Since this backend will run inside an atom shell, it will not be limited by the browser environment. The strategy is to implement as much as possible in the browser backend, and reuse browser code in the atom backend.


### The backends

The `lib` directory contains the bulk of the code:

- `lib/bootstrap` contains files for bootstrapping the opal environment
- `lib/shoes/core` contains monkeypatches to Shoes 4 so it can run on opal
- `lib/shoes/browser` contains the browser backend
- `lib/shoes/atom` contains the extensions to the browser backend for running in an atom shell

There are a few auxiliary files that need to exist in order for apps to run using the browser and atom backends. You'll find these in `skeleton`.


### Compiling an app

There isn't yet a great way to compile an app in some arbitrary location. However, there is a rake task for building all of the example apps, so you can drop an app `my_app.rb` into the `examples` directory and run

    $ rake build:examples
  
Now your app will be built to `build/my_app/browser` and `build/my_app/atom`. Open them like this:

        $ open build/my_app/browser/index.html
        $ /Applications/Atom.app/Contents/MacOS/Atom build/my_app/atom



### Specs

This repository contain a copy of the `shoes-core` specs. Eventually, these specs shoudl run unmodified for the atom backend, and with only minimal exclusions for the browser backend. There will be two spec runners:

- `spec/browser/browser_runner.erb/rb` runs shoes-core specs with the browser backend, and also specs for the browser backend itself
- `spec/atom/atom_runner.erb.rb` (doesn't exist yet) will run shoes-core specs with the atom backend, and also specs for the atom backend (which should include most if not all of the specs for the browser backend)

To add specs to the browser suite, add the file to the runner, like this:

```ruby
# Enumerate the specs we want to run, so we can turn them on/off easily.
# These paths are relative to the load paths set in our spec task.
# To run all of the specs, you'd replace this with
#     Dir.glob('spec/{browser,shoes}/**/*_spec.{rb,opal}')
<%
  active_specs = [
    # Add more specs to this list :)
    'shoes/app_spec.rb',
  ]
%>
```

To mark specs as not working with the browser backend, tag groups or examples with `:no_browser`, like this:

```ruby
describe 'fullscreen', :no_browser do
  # ...
end
```

```ruby
it "sets width", :no_browser do
  # ...
end
```

Run specs like this:

    $ rake spec:browser

_**Note:** you may have to use `bundle exec rake spec:browser`, depending on your setup_


### Samples

This repository includes a copy of the Shoes 4 samples. Ultimately, all of the samples should run with both the browser and the atom backends. The `samples/README` file contains a list of working samples. To mark one as working, uncomment it in this file, like this:

```
# nks_self.rb
nks_text_sizes.rb
# nks_trurl.rb
```

There are lots of rake tasks for running samples, taken from Shoes 4:

```
rake samples:bad                   # Run all non-working samples in random order
rake samples:bad_list              # Create list of non-working samples
rake samples:good[start_with]      # Run all working samples in alphabetical order
rake samples:random                # Run all working samples in random order
rake samples:subset[filename]      # Run all samples listed in samples/filename
```

When you build samples and examples, the build directory will contain an index.html file with links to all of the browser versions of the build samples and examples.

    $ open build/index.html



## Contributing

Contributions are very welcome. Fork, hack, and make a pull request. Cheers!

