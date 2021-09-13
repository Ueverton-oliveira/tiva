require 'rails_helper'

RSpec.describe Professional, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:cell_phone) }
end

