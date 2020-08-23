RSpec.describe Laters do
  it 'has a version number' do
    expect(Laters::VERSION).not_to be nil
  end

  describe Laters::Concern do
    subject { User.create(name: 'Arie') }
    it 'defines _later methods for instance_variables' do
      expect(subject).to respond_to(:crash_later)
      expect(subject).to respond_to(:upcase_later)
    end

    describe 'User#upcase_later' do
      it 'queues the instance method job' do
        expect { subject.upcase_later }.to have_enqueued_job(Laters::InstanceMethodJob).with(subject, 'upcase!').exactly(:once).on_queue(:default)
      end
    end

    describe 'User#crash_later' do
      it 'queues the instance method job' do
        expect { subject.crash_later }.to have_enqueued_job(Laters::InstanceMethodJob).with(subject, 'crash').exactly(:once).on_queue(:default)
      end
    end

    describe 'Comment#call_later on low queue' do
      subject { Comment.create }

      it 'queues the instance method job' do
        expect { subject.call_me_later }.to have_enqueued_job(Laters::InstanceMethodJob).with(subject, 'call_me').exactly(:once).on_queue(:low)
      end
    end
  end

  describe Laters::InstanceMethodJob do
    describe '#upcase_later' do
      it 'calls upcase!' do
        user = User.create(name: 'Ben')
        Laters::InstanceMethodJob.perform_now(user, 'upcase!')
        user.reload
        expect(user).to have_attributes name: 'BEN'
      end
    end

    describe '#crash_later' do
      it 'calls crash' do
        user = User.create(name: 'Ben')
        expect { Laters::InstanceMethodJob.perform_now(user, 'crash') }.to raise_error(Laters::Error)
      end
    end
  end
end
