# frozen_string_literal: true

# User and stock models many-to-many association
class UserStock < ApplicationRecord
  belongs_to :user
  belongs_to :stock
end
