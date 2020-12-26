#!/usr/bin/env python3

cases = int(input())

while(cases > 0):
    Turtles = int(input())
    TurtlesOrd = Turtles
    TurtlesList = []
    TurtlesListOrd = []
    while(Turtles > 0):
        TurtlesList.append(input())
        Turtles = Turtles - 1
    while(TurtlesOrd > 0):
        TurtlesListOrd.append(input())
        TurtlesOrd = TurtlesOrd - 1

    



    cases = cases - 1
print(TurtlesList)
print(TurtlesListOrd)
