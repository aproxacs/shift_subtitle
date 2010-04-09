# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 

require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'

spec = Gem::Specification.new do |s|
  s.name = 'ShiftSubtitle'
  s.version = '0.0.1'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README', 'LICENSE']
  s.summary = 'Shifts times of SubRip subtitle'
  s.description = s.summary
  s.author = 'aproxacs'
  s.email = 'aproxacs@gmail.com'
  s.executables = ['shift_subtitle']
  s.files = %w(LICENSE README Rakefile) + Dir.glob("{bin,lib,spec}/**/*")
  s.require_path = "lib"
  s.bindir = "bin"
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end

Rake::RDocTask.new do |rdoc|
  files =['README', 'LICENSE', 'lib/**/*.rb']
  rdoc.rdoc_files.add(files)
  rdoc.main = "README" # page to start on
  rdoc.title = "ShiftSubtitle Docs"
  rdoc.rdoc_dir = 'doc/rdoc' # rdoc output folder
  rdoc.options << '--line-numbers'
end
