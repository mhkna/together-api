require 'rails_helper'

RSpec.describe Comment, type: :model do
  # Association test
  it { should belong_to(:account) }
  # Validation test
  it { should validate_presence_of(:text) }
end
