# Voting patterns
2024 repository for exam in Social and Cultural Dynamics

## Purpose
This repository serves a collection of data and code for the 2024 exam in Social and Cultural Dynamics on the bachelors degree of Cognitive Science.
The aim of the exam is to examine the patterns of voters, specifically in the country of Denmark.

Interesting parameters to examine include:
- **Limiting voting age range eg. 18-80**
- **Lowering voting age to eg. 16**
- **Raising voting age to eg. 25**

## Planned frameworks and methods
In terms of framework and methods, Agent Based Models (ABM) are considered, along with, if the scope of the project allows it, Network Models.

In terms of data, I wish to use voting data from the past elections and school elections. Perhaps, gathering data using a survey on reasons for voting and voting pattern.
This should include age, occupation, area of residency (Municipality or region) etc.

## Assumptions
The assumptions of this project include: 
- That every agent acts according to a set value system, that directly influences their voting patterns.
- That younger voters/new voters will be more extreme in their voting patterns and value systems.
- Older voters/experienced voters will be more set in their ways and less prone to influence and will consequently vote similarly each time

## Perceived challenges
- Lack of expertise in ABM
- Data (Lack of data, data for only Denmark)
- Causal explanatory power

### ABM Modelling languages + packages
**Python**
- pyabm: https://pypi.org/project/pyabm/0.3.1/#description
- AgentPy: https://agentpy.readthedocs.io/en/latest/
- Mesa: https://github.com/projectmesa/mesa

**Netlogo**
- Download Netlogo: https://ccl.northwestern.edu/netlogo/

All packages and models are included: https://ccl.northwestern.edu/netlogo/models/

### Videos for building an ABM
Mesa: https://www.youtube.com/watch?v=1wa9lysIaD8

## ToDo
- [x] Look into workings of urban suite model
- [x] set some patches as information center to change vote
- [x] set turtles to be colored by each vote option
- [x] fix to go and look into why tick cannot be used there
- [x] Set age specific votechange behavior
- [ ] Make sure model works as expected
