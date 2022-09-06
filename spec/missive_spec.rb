require_relative "../missive.rb"

RSpec.describe do
  describe "content of missive" do
    it "stores a name on a missive" do
      missive = Missive.new("Rory", "")
      expect(missive.name).to eq "Rory"
    end

    it "stores a message on a missive" do
      missive = Missive.new("", "Lore ipsum est")
      expect(missive.message).to eq "Lore ipsum est"
    end
  end
end
