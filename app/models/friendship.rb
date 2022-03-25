# frozen_string_literal: true

# User self-referential model
class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
end
