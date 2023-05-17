class Lease < ApplicationRecord
    validates :rent, presence: true

    belongs_to :apartment
    belongs_to :tenant
end
