require 'rails_helper'

RSpec.describe Round, type: :model do
  # Association test
  it { should have_many(:accounts) }
  # Validation tests
end
