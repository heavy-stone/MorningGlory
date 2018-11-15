# -*- encoding: utf-8 -*-
# stub: acts_as_list 0.9.17 ruby lib

Gem::Specification.new do |s|
  s.name = "acts_as_list".freeze
  s.version = "0.9.17"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["David Heinemeier Hansson".freeze, "Swanand Pagnis".freeze, "Quinn Chaffee".freeze]
  s.date = "2018-10-29"
  s.description = "This \"acts_as\" extension provides the capabilities for sorting and reordering a number of objects in a list. The class that has this specified needs to have a \"position\" column defined as an integer on the mapped database table.".freeze
  s.email = ["swanand.pagnis@gmail.com".freeze]
  s.homepage = "http://github.com/swanandp/acts_as_list".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2".freeze)
  s.rubyforge_project = "acts_as_list".freeze
  s.rubygems_version = "2.7.6".freeze
  s.summary = "A gem adding sorting, reordering capabilities to an active_record model, allowing it to act as a list".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>.freeze, [">= 3.0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 1.0.0"])
    else
      s.add_dependency(%q<activerecord>.freeze, [">= 3.0"])
      s.add_dependency(%q<bundler>.freeze, [">= 1.0.0"])
    end
  else
    s.add_dependency(%q<activerecord>.freeze, [">= 3.0"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.0.0"])
  end
end
