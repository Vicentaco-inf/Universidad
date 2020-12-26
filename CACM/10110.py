#!/usr/bin/env python3

#LightMoreLight

import math

number = int(input())

while number != 0:
    ans = math.sqrt(number)
    cont = number % ans

    if cont == 0:
        print("yes")
    else:
        print("no")

    number = int(input())

