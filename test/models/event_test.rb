# frozen_string_literal: true

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "the truth" do
    event = Event.new
    assert event.save
  end
end
