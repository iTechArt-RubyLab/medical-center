require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'notify' do
    let(:destination) { create(:user) }
    let(:mail) do
      described_class.with(user: destination, host: 'http://localhost:3000').registration_confirmation.deliver
    end

    it 'renders the subject' do
      expect(mail.subject).to eq('Registration Confirmation')
    end

    it 'renders the destination' do
      expect(mail.to).to eq([destination.email])
    end

    it 'renders the sender' do
      expect(mail.from).to eq([ENV['email_user_name']])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi')
    end

    it 'sends an email' do
      described_class.with(user: destination, host: 'http://localhost:3000').registration_confirmation.deliver
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end
