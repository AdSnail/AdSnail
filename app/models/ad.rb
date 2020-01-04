class Ad < ApplicationRecord
    validates :title, presence: true,
    length: {minimum:2, maximum:32}
end
