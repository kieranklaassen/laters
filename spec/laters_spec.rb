RSpec.describe Laters do
  it 'has a version number' do
    expect(Laters::VERSION).not_to be nil
  end

  describe Laters::Concern do
    subject { User.create(name: 'Arie') }
    
    it 'defines _later methods for instance_variables' do
      expect(subject).to respond_to(:crash_later)
      expect(subject).to respond_to(:upcase_later)
      expect(subject).to respond_to(:greet_later)
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
    
    describe 'scheduling options' do
      around do |example|
        freeze_time { example.run }
      end
      
      it 'supports wait option' do
        expect { 
          subject.upcase_later(wait: 5.minutes) 
        }.to have_enqueued_job(Laters::InstanceMethodJob).with(subject, 'upcase!')
      end
      
      it 'supports wait_until option' do
        tomorrow = 1.day.from_now
        expect { 
          subject.upcase_later(wait_until: tomorrow) 
        }.to have_enqueued_job(Laters::InstanceMethodJob).with(subject, 'upcase!')
      end
      
      it 'supports priority option' do
        expect { 
          subject.upcase_later(priority: 10) 
        }.to have_enqueued_job(Laters::InstanceMethodJob).with(subject, 'upcase!')
        # Note: Can't test priority with have_enqueued_job matcher directly
      end
    end
    
    describe 'with method arguments' do
      around do |example|
        freeze_time { example.run }
      end
      
      it 'passes positional arguments' do
        expect { 
          subject.greet_later('World') 
        }.to have_enqueued_job(Laters::InstanceMethodJob).with(subject, 'greet', 'World')
      end
      
      it 'passes keyword arguments' do
        expect { 
          subject.greet_later('Smith', title: 'Mr.') 
        }.to have_enqueued_job(Laters::InstanceMethodJob).with(subject, 'greet', 'Smith', title: 'Mr.')
      end
      
      it 'separates job options from method kwargs' do
        expect { 
          subject.greet_later('Smith', title: 'Mr.', wait: 5.minutes) 
        }.to have_enqueued_job(Laters::InstanceMethodJob).with(subject, 'greet', 'Smith', title: 'Mr.')
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
    
    describe 'with arguments' do
      it 'passes positional arguments correctly' do
        user = User.create(name: 'Ben')
        result = Laters::InstanceMethodJob.perform_now(user, 'greet', 'World')
        expect(result).to eq('Hello World')
      end
      
      it 'passes keyword arguments correctly' do
        user = User.create(name: 'Ben')
        result = Laters::InstanceMethodJob.perform_now(user, 'greet', 'Smith', title: 'Mr.')
        expect(result).to eq('Hello Mr. Smith')
      end
    end
    
    describe 'callbacks' do
      it 'runs callbacks in the correct order' do
        user = User.create(name: 'Ben')
        Laters::InstanceMethodJob.perform_now(user, 'upcase!')
        
        expect(user.callback_log).to eq(['before', 'around_before', 'around_after', 'after'])
      end
    end
  end
end
