require 'rails_helper'

RSpec.describe SendWelcomeEmailJob, type: :job do
  let(:user) { create(:user) }

  it 'queues the job' do
    expect { described_class.perform_later(user) }
      .to have_enqueued_job(described_class)
      .with(user)
      .on_queue('default')
  end

  it 'executes perform' do
    expect(UserMailer).to receive(:welcome_email).with(user).and_call_original
    perform_enqueued_jobs { described_class.perform_later(user) }
  end
end
