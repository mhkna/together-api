require 'rails_helper'

RSpec.describe Account, type: :model do
  # Association test
  it { should have_many(:comments).dependent(:destroy) }
  it { should belong_to(:round) }
  # Validation tests
  it { should validate_presence_of(:website) }
  it { should validate_presence_of(:username) }
end
