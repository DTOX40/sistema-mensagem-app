require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'welcome_email' do
    let(:user) { create(:user, email: 'test@example.com') }
    let(:mail) { UserMailer.welcome_email(user) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Welcome to Our Application')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['programador.rails@gmail.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match("Bem vindo, #{user.name}")
    end
  end
end
