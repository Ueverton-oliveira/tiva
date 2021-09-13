require 'rails_helper'

RSpec.describe Schedule, type: :model do
  it { is_expected.to validate_presence_of(:initial_date) }
  it { is_expected.to validate_presence_of(:end_date) }
  it { is_expected.to validate_presence_of(:initial_hour) }
  it { is_expected.to validate_presence_of(:end_hour) }
end
