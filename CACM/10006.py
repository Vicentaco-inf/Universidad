#!/usr/bin/env python3
sol = [561,1105,1729,2465,2821,6601,8911,10585,15841,29341,41041,46657,52633,62745,63973]
res = []
while True:
    num = int(input())
    if num == 0:
        break
    else:
        if num in sol:
            print("The number",num,"is a Carmichael number.")
        else:
            print(num,"is normal.")
            
