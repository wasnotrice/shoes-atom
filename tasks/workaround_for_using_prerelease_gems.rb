# For some reason prerelease gems aren't being loaded by
# Gem::Specification.find_by_name. See
# https://github.com/rubygems/rubygems/issues/988#issuecomment-68886157
# So...we copy the relevant method (with typos) and monkeypatch it :D
module Opal
  def self.require_paths_for_gem(gem_name, include_dependecies)
    paths = []
    spec = Gem::Specification.find_by_name(gem_name)

    # This is the only real change. The rest is copied.
    if spec.nil?
      spec = Gem::Specification.find_all_by_name(gem_name).last
    end

    spec.runtime_dependencies.each do |dependency|
      paths += require_paths_for_gem(dependency.name, include_dependecies)
    end if include_dependecies

    gem_dir = spec.gem_dir
    spec.require_paths.map do |path|
      paths << File.join(gem_dir, path)
    end

    paths
  end
end

