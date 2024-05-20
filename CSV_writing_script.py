# -*- coding: utf-8 -*-
"""
Created on Sun May 19 20:23:48 2024

@author: hugo
"""

titles = ["RANDOM STATE", "GLOBALS", "TURTLES", "PATCHES", "LINKS", "PLOTS", "EXTENSIONS"]


file = open("C:/Users/hugov/Github/voting_patterns/Data/TXT_world_files/Sim_1_16_80.txt", 'r')


to_file = open('C:/Users/hugov/Github/voting_patterns/Data/dummy.txt', 'w')
for line in file :
    new_file = False
    for t in titles:
        if t in line:
            filename = line
            to_file = open(f'C:/Users/hugov/Github/voting_patterns/Data/CSV/{t}_1_16_80.csv', 'w')
            new_file = True
    
    if not new_file:
        to_file.write(line)
        
    
file = open("C:/Users/hugov/Github/voting_patterns/Data/TXT_world_files/Sim_1_16_100.txt", 'r')


to_file = open('C:/Users/hugov/Github/voting_patterns/Data/dummy.txt', 'w')
for line in file :
    new_file = False
    for t in titles:
        if t in line:
            filename = line
            to_file = open(f'C:/Users/hugov/Github/voting_patterns/Data/CSV/{t}_1_16_100.txt.csv', 'w')
            new_file = True
    
    if not new_file:
        to_file.write(line)        
        
file = open("C:/Users/hugov/Github/voting_patterns/Data/TXT_world_files/Sim_1_18_80.txt", 'r')


to_file = open('C:/Users/hugov/Github/voting_patterns/Data/dummy.txt', 'w')
for line in file :
    new_file = False
    for t in titles:
        if t in line:
            filename = line
            to_file = open(f'C:/Users/hugov/Github/voting_patterns/Data/CSV/{t}_1_18_80.csv', 'w')
            new_file = True
    
    if not new_file:
        to_file.write(line)
        
    
file = open("C:/Users/hugov/Github/voting_patterns/Data/TXT_world_files/Sim_1_18_100.txt", 'r')


to_file = open('C:/Users/hugov/Github/voting_patterns/Data/dummy.txt', 'w')
for line in file :
    new_file = False
    for t in titles:
        if t in line:
            filename = line
            to_file = open(f'C:/Users/hugov/Github/voting_patterns/Data/CSV/{t}_1_18_100.txt.csv', 'w')
            new_file = True
    
    if not new_file:
        to_file.write(line)   
        
    
    