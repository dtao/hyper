class Domain < Mustache
  attr_reader :application_name, :tagline, :description

  def initialize(config)
    @application_name = config['name']
    @tagline          = config['tagline']
    @description      = config['description']

    @models = {}
    config['models'].each do |name, spec|
      @models[name] = Model.new(name, spec, self)
    end
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
