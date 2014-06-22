require 'spec_helper'

describe Trip do
  it { should belong_to :user }
  it { should validate_presence_of :date }
  it { should validate_presence_of :lat_dest }
  it { should validate_presence_of :lng_dest }
  it { should validate_presence_of :lat_local }
  it { should validate_presence_of :lng_local }
  it { should validate_presence_of :location_start }
  it { should validate_presence_of :location_end }
  it { should validate_presence_of :time }
  it { should validate_presence_of :vehicle }
  it { should validate_presence_of :mpg }
  it { should validate_presence_of :seats_available }

end
