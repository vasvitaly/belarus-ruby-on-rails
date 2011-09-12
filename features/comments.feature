Feature: Comments management for custom news.

  Scenario: Logged in users can add comments for custom news
    Given I am logged in
    And I have 1 custom news article
    And I have no comments
    When I follow "Add comment"
    And I fill in "Message" with "Nice article!"
    Then I should have 1 comment

  Scenario: Logged in users can delete their comments
    Given I am logged in
    And I have 1 comment for custom news article "Ruby rocks"
    When I am on custom news path for "Ruby rocks"
    And I follow "Delete comment"
    Then I should have no comments
