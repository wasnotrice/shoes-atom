source 'https://rubygems.org'

# All 3 of these declarations for 'shoes-core' fail. See
# tasks/workaround_for_using_prerelease_gems.rb
# The git version also doesn't work because shoes-core isn't in its own repository
# gem 'shoes-core', git: 'git@github.com:shoes/shoes4.git/shoes-core', branch: 'master'
# gem 'shoes-core', path: './vendor/shoes-core'
gem 'shoes-core', '~> 4.0.0.pre', path: './vendor/shoes-core-4.0.0.pre2'

gem 'opal', git: 'git@github.com:opal/opal.git', branch: 'master'
gem 'rake'

group :development, :test do
  gem 'rspec', '~>3'
  gem 'opal-rspec', git: 'git@github.com:opal/opal-rspec.git', branch: 'master'
  gem 'rspec-its', '~>1.1.0'

  gem 'webmock'
end
