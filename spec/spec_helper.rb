require 'hyper'
require 'pry'

DOMAIN = Domain.new(YAML.load_file(File.join(File.dirname(__FILE__), '..', 'example', 'hyper.yml')))

RSpec.configure do |config|
  config.before(:each) do
    @user_model    = DOMAIN.get_model('User')
    @post_model    = DOMAIN.get_model('Post')
    @comment_model = DOMAIN.get_model('Comment')
  end
end
