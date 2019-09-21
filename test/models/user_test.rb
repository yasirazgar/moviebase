require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "saves_when_all_the_attrs_are_present" do
    assert(!User.new(name: 'one', email: 'one@rm.com').valid?,
      "Should not be valid if title is missing.")
  end

  test "validations_fails_without_name" do
    one = users(:one)

    assert(!Movie.new(user: one).valid?,
      "Should not be valid if title is missing.")
  end
end
