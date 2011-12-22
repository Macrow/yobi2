Feature: Sign in
  In order to get access to protected sections of the site
  A user
  Should be able to sign in

    Scenario: User is not signed up
      Given I am not logged in
      And no user exists with an email of "user@test.com"
      When I go to the sign in page
      And I sign in with email "user@test.com" and password "please"
      Then I should see invalid email or password message
      And I go to the account page
      And I should be signed out

    Scenario: User enters wrong password
      Given I am not logged in
      And I am a user named "foo" with an email "user@test.com" and password "please"
      When I go to the sign in page
      And I sign in with email "user@test.com" and password "wrongpassword"
      Then I should see invalid email or password message
      And I go to the account page
      And I should be signed out

    Scenario: User signs in successfully with email
      Given I am not logged in
      And I am a user named "foo" with an email "user@test.com" and password "please"
      When I go to the sign in page
      And I sign in with email "user@test.com" and password "please"
      Then I should see signed in successful message
      And I should be signed in
      When I return next time
      Then I should be already signed in
    
    Scenario: User signs in successfully with name
      Given I am not logged in
      And I am a user named "foo" with an email "user@test.com" and password "please"
      When I go to the sign in page
      And I sign in with name "foo" and password "please"
      Then I should see signed in successful message
      And I should be signed in
      When I return next time
      Then I should be already signed in
    
    
    
