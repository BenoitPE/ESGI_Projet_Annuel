Feature: Movie

Features linked to movies

Scenario: Get - Movie exists
	Given a movie id is 634649
	When I try to get this movie
	Then I have the data from the movie

Scenario: Get - Movie doesn't exists
Given a movie id is 0
	When I try to get this movie
	Then no movie was found