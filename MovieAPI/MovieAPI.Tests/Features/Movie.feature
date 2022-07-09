Feature: Movie

Features linked to movies

Scenario: Get - Movie exists
	Given I'm pointing on movie
	Given an id 634649
	When I try to get data
	Then I have data

Scenario: Get - Movie doesn't exists
	Given I'm pointing on movie
	Given an id 0
	When I try to get data
	Then no content was found

Scenario: Search movies - Multiple results
	Given I'm pointing on movie
	Given a search for Spiderman
	When I make a search
	Then multiple results were found

Scenario: Search movies - No results
	Given I'm pointing on movie
	Given a search for Spidermansss
	When I make a search
	Then no results were found

Scenario: Popular movies
	Given I'm pointing on movie
	When I want a list of popular content
	Then multiple results were found