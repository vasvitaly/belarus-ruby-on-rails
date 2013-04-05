require 'spec_helper'

describe Answer do
  it { should allow_mass_assignment_of :gist }
  it { should belong_to(:question) }
  it { should have(1).error_on(:gist) }
end
