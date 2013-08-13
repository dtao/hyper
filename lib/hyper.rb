# Needed for Model#singular_ref, #plural_ref, etc.
require 'active_support/inflector'

# All models that get rendered inherit from Mustache
require 'mustache'

# Used by Hyper::boom!
require 'yaml'
require 'fileutils'

# Pull in everything from lib/ (but in the proper order)
require 'hyper/version'
require 'hyper/domain'
require 'hyper/model'
require 'hyper/attribute'

def read_template_file(*args)
  File.read(File.join(File.dirname(__FILE__), '..', 'templates', *args) + '.mustache')
end

def write_file(*args)
  # Treat the last argument as the file contents
  content = args.pop

  # Ensure the directory exists
  FileUtils.mkdir_p(args[0...-1].join('/'))

  # Open the file, write to its input stream, close it
  File.open(File.join(*args), 'w') do |f|
    f.write(content)
  end
end

module Hyper
  def self.boom!(options={})
    input_dir  = options[:input_dir]  || Dir.pwd
    output_dir = options[:output_dir] || File.join(input_dir, 'app')

    # Load domain definitions from YAML
    config = YAML.load_file(File.join(input_dir, 'hyper.yml'))
    domain = Domain.new(config)

    Mustache.template_path = File.join(File.dirname(__FILE__), '..', 'templates')

    # Generate model files
    domain.models.each do |model|
      write_file(output_dir, 'models', "#{model.singular_ref}.rb", model.render)
    end

    # Generate controller files
    controller_template = read_template_file('controller.rb')
    domain.models.each do |model|
      write_file(output_dir, 'controllers', "#{model.plural_ref}_controller.rb", Mustache.render(controller_template, model))
    end

    # Generate routes.rb
    routes_template = read_template_file('routes.rb')
    write_file(output_dir, 'config', 'routes.rb', Mustache.render(routes_template, domain))

    # Generate application layout
    layout_template = read_template_file('views', 'layouts', 'application.html.haml')
    write_file(output_dir, 'views', 'layouts', 'application.html.haml', Mustache.render(layout_template, domain))

    # Generate views
    ['_form', 'index', 'show', 'new'].each do |view|
      view_template = read_template_file('views', "#{view}.html.haml")
      domain.models.each do |model|
        write_file(output_dir, 'views', model.plural_ref, "#{view}.html.haml", Mustache.render(view_template, model))
      end
    end
  end
end