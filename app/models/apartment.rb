class Apartment < ApplicationRecord
   validates :number, presence: true

   has_many :leases
   has_many :tenants
end
