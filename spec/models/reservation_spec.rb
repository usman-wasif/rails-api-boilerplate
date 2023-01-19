RSpec.describe Reservation, type: :model do
 it { should belong_to(:vehicle) }
 it { should belong_to(:customer) }

 it { should validate_presence_of(:date) }
 it { should validate_presence_of(:time) }
end