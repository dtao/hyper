require File.join(File.dirname(__FILE__), 'spec_helper')

describe Attribute do
  describe '#type' do
    it 'for plain vanilla attributes, uses the specified string as its type' do
      @user_model.get_attribute('name').type.should == 'string'
    end

    it 'for associations, provides the actual corresponding model' do
      @post_model.get_attribute('user').type.should == @user_model
    end
  end

  describe '#required?' do
    it 'defaults to true' do
      @user_model.get_attribute('name').required?.should be_true
    end
  end
end
