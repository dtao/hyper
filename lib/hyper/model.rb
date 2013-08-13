class Model < Mustache
  self.template_extension = 'rb.mustache'

  attr_reader :name, :domain

  def initialize(name, spec, domain)
    @name   = name
    @domain = domain
    @spec   = spec
  end

  def class_name
    @name
  end

  def plural_name
    class_name.pluralize
  end

  def singular_ref
    @name.underscore
  end

  def plural_ref
    singular_ref.pluralize
  end

  def instance_ref
    '@' + singular_ref
  end

  def public?
    @spec['public'] != false
  end

  def attributes
    load_attributes!
    @attributes.values
  end

  def get_attribute(name)
    load_attributes!
    @attributes[name]
  end

  def requirements
    @requirements ||= attributes.select(&:dependency?).map(&:type)
  end

  def dependents
    @dependents ||= @domain.models.select { |model| model.requirements.include?(self) }
  end

  def primary_attribute
    @primary_attribute ||= attributes.find(&:primary?)
  end

  def required_attributes
    @required_attributes ||= attributes.select(&:required?)
  end

  def indexed_attributes
    @indexed_attributes ||= attributes.select(&:dependency?) # TODO: Implement me more!
  end

  # ----- Output helper methods -----

  def format_instance
    primary_attribute ? "\#\{#{instance_ref}.#{primary_attribute.name}\}" : class_name
  end

  def required_attributes_as_symbols
    required_attributes.map { |attribute| ":#{attribute.name}" }.join(', ')
  end

  def singular_css_class
    singular_ref.dasherize
  end

  def plural_css_class
    plural_ref.dasherize
  end

  def to_s
    "#{class_name} (Model)"
  end

  def inspect
    to_s
  end

  private

  def load_attributes!
    @attributes ||= begin
      hash = {}
      (@spec['attributes'] || {}).each do |name, properties|
        hash[name] = Attribute.new(name, properties, self)
      end
      hash
    end
  end
end
