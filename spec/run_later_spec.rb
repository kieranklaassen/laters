RSpec.describe RunLater do
  it "has a version number" do
    expect(RunLater::VERSION).not_to be nil
  end

  describe User do
    it { is_expected.to have_attributes(name: 'Kieran') }
  end
end
