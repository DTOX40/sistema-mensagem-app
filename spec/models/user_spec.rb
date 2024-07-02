require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      expect(build(:user)).to be_valid
    end

    it 'is not valid without a name' do
      expect(build(:user, name: nil)).not_to be_valid
    end

    it 'is not valid without an email' do
      expect(build(:user, email: nil)).not_to be_valid
    end

    it { should validate_presence_of(:name) }
    
    it 'validates that :email is case-insensitively unique within the scope of :provider' do
      create(:user, email: 'test@example.com', provider: 'email')
      expect(build(:user, email: 'test@example.com', provider: 'email')).not_to be_valid
    end
  end

  context 'factory' do
    it 'is valid with valid attributes' do
      expect(create(:user)).to be_valid
    end
  end

  describe '#search_users' do
    let!(:user1) { create(:user, name: 'test1') }
    let!(:user2) { create(:user, name: 'test2') }

    it 'searches and finds users by name' do
      expect(User.search_users(user1.name).count).to eq(1)
    end

    it 'searches and finds users by email' do
      expect(User.search_users(user1.email).count).to eq(1)
    end

    it 'searches using special characters' do
      user3 = create(:user, name: 'Maria')
      expect(User.search_users('maria').count).to eq(1)
    end

    it 'does not find users if there is no keyword match' do
      expect(User.search_users('nomatch').count).to eq(0)
    end
  end
end
