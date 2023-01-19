
RSpec.describe Customer, type: :model do
   it { should have_many(:reservations) }
   it { should validate_presence_of(:email) }
end
