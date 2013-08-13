require File.join(File.dirname(__FILE__), 'spec_helper')

describe Model do
  describe '#public?' do
    it 'defaults to true' do
      @post_model.public?.should be_true
    end
  end

  describe '#requirements' do
    it 'provides a list of all the models the current model belongs to' do
      @post_model.requirements.should == [@user_model]
    end
  end

  describe '#dependents' do
    it 'provides a list of all the models that depend on the current model' do
      @post_model.dependents.should == [@comment_model]
    end
  end
end
