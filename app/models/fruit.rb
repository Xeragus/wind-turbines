class Fruit < ApplicationRecord
  after_create_commit { broadcast_append_to 'fruits' }
end
