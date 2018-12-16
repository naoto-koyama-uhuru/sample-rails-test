require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  describe "#full_name" do
    subject { user.full_name }
    it { is_expected.to eq "first_name last_nam" }
  end
end
