try: 
    while True:
        a,b = map(int,input().split())
        x,y = 0,1
        lx,ly = 1,0
        while b:
            q = a//b
            a, b = b, a % b
            x,lx = lx-q*x,x
            y,ly = ly-q*y,y
        print(lx,ly,a)
except:
    pass