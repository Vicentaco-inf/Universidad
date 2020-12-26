c = int(input())
for _ in range(c):
    x = input()
    z = input()
    counters = []
    counters.append([0]*len(x))
    counters.append([0]*len(x))
    for i in range(len(x)):
       if x[i] == z[0]: 
           counters[0][i]+=1
    k=0
    for j in range(1,len(z)):
        l=(k+1)%2
        counter = 0
        for i in range(j,len(x)):
            counter += counters[k][i-1]
            if x[i] == z[j]:
                counters[l][i] = counter
        counters[k] = [0] * len(x)
        k=l
    print(sum(counters[k][:]))