Feature: Edit User
  As a registered user of the website
  I want to edit my user profile
  so I can change my username

    Scenario: I sign in and edit my account
      Given I am a user named "foo" with an email "user@test.com" and password "please"
      And I go to the sign in page
      When I sign in with email "user@test.com" and password "please"
      Then I should be signed in
      And I go to the account page
      When I follow edit account link
      And I fill in name with baz
      And I fill in current password with please
      And I press update button
      And I should see registrations information updated message
      Then I should see user named baz