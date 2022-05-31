Feature: Serie

Features linked to series

Scenario: Get - Serie exists
	Given a serie id is 154521
	When I try to get this serie
	Then I have the data from the serie

Scenario: Get - Serie doesn't exists
Given a serie id is 0
	When I try to get this serie
	Then no serie was found