require 'test_helper'

class FresherTest < ActionMailer::TestCase
  test "new_verification" do
    mail = Fresher.new_verification
    assert_equal "New verification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
