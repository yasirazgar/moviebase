require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "saves_when_all_the_attrs_are_present" do
    assert(!User.new(name: 'yasir', email: 'yasir@rm.com').valid?,
      "Should not be valid if name is missing.")
  end

  test "validations_fails_without_name" do
    yasir = users(:yasir)

    assert(!User.new(email: 'yasir@rm.com').valid?,
      "Should not be valid if name is missing.")
  end

  test "validations_fails_without_email" do
    yasir = users(:yasir)

    assert(!User.new(name: 'yasir').valid?,
      "Should not be valid if email is missing.")
  end

  test "validations_fails_without_unique_email" do
    yasir = users(:yasir)

    assert(!User.new(name: 'risky yasir', email: 'yasir@risk.com').valid?,
      "Should not be valid if email is not unique.")
  end
end
