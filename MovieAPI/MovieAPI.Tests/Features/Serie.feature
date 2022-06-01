Feature: Serie

Features linked to series

Scenario: Get - Serie exists
	Given I'm pointing on serie
	Given an id 154521
	When I try to get data
	Then I have data

Scenario: Get - Serie doesn't exists
	Given I'm pointing on serie
	Given an id 0
	When I try to get data
	Then no content was found

Scenario: Search series - Multiple results
	Given I'm pointing on serie
	Given a search for Spiderman
	When I make a search
	Then multiple results were found

Scenario: Search series - No results
	Given I'm pointing on serie
	Given a search for Spidermansss
	When I make a search
	Then no results were found

Scenario: Popular movies
	Given I'm pointing on serie
	When I want a list of popular content
	Then multiple results were found