Feature: Sign out
  To protect my account from unauthorized access
  A signed in user
  Should be able to sign out

    Scenario: User signs out
      Given I am a user named "foo" with an email "user@test.com" and password "please"
      And I go to the sign in page
      When I sign in with email "user@test.com" and password "please"
      Then I should be signed in
      And I should see signed in successful message
      And I sign out
      Then I should see signed out message
      When I return next time
      Then I should be signed out
      