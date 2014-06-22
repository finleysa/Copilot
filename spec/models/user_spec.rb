require 'spec_helper'

describe User do
  it { should have_many :trips }
  it { should validate_uniqueness_of :username }
  it { should validate_uniqueness_of :email }

  describe 'username' do
    it { should allow_value('matt').for(:username) }
    it { should_not allow_value('as df jkl').for(:username) }
    it { should_not allow_value('matt?').for(:username) }
    it { should_not allow_value('matt=matt').for(:username) }
    it { should_not allow_value('matt%').for(:username) }
  end
  
end
