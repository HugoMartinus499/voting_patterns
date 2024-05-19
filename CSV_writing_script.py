# -*- coding: utf-8 -*-
"""
Created on Sun May 19 20:23:48 2024

@author: hugo
"""

titles = ["RANDOM STATE", "GLOBALS", "TURTLES", "PATCHES", "LINKS", "PLOTS", "EXTENSIONS"]


file = open("C:/Users/hugov/Github/voting_patterns/Data/ABM netlogo world.txt", 'r')


to_file = open('dummy.txt', 'w')
for line in file :
    new_file = False
    for t in titles:
        if t in line:
            filename = line
            to_file = open(f'{t}.csv', 'w')
            new_file = True
    
    if not new_file:
        to_file.write(line)
        
    
        
        
    
    