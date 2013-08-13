class Domain < Mustache
  def initialize(config)
    @application_name = config['application_name']

    @models = {}
    config['models'].each do |name, spec|
      @models[name] = Model.new(name, spec, self)
    end
  end

  def application_name
    @application_name
  end

  def models
    @models.values
  end

  def get_model(name)
    @models[name]
  end

  def public_models
    @public_models ||= models.select(&:public?)
  end

  def private_models
    [] # TODO: Implement me!
  end
end
