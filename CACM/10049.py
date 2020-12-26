#!/usr/bin/env python3

#from 0 to 2000000000
n=60000

g=[1,2,2,3]
for i in range(3,n):
    print(i)
    g+=[i]*g[i-1]
f= open("precalculus10049.txt","w+")
f.write(str(g))
f.close()