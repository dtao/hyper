class Attribute
  attr_reader :name, :type

  def initialize(name, properties, model)
    @name   = name
    @model  = model
    @domain = model.domain

    load_type(properties)
    load_properties!(properties)
  end

  def primary?
    @tags.include?('!primary')
  end

  def required?
    @required
  end

  def dependency?
    self.type.is_a?(Model)
  end

  # ----- Output helper methods -----

  def label
    name.titleize
  end

  def accessor
    self.dependency? && "#{@name}_id" || @name
  end

  def column_type
    self.dependency? && 'integer' || @type
  end

  def form_helper
    case self.type
    when Model
      "hidden_field(:#{accessor})"

    when 'string'
      "text_field(:#{accessor})"

    when 'text'
      "text_area(:#{accessor})"

    else
      "text_field(:#{accessor})" # TODO: Implement other form helpers.
    end
  end

  private

  def load_type(properties)
    properties = properties['type'] if properties.is_a?(Hash)
    type_name, *tags = properties.split(/\s+/)
    @type = @domain.get_model(type_name) || type_name
    @tags = tags
  end

  def load_properties!(properties)
    properties = {} if !properties.is_a?(Hash)
    @required = properties['required'] || true
  end
end
