import math

fib = [1, 1]
while True:
    aux = str(fib[-1]+fib[-2])
    if len(aux) > 101:
        fib.pop()
        break
    else:
        fib.append(int(aux))


while True:

    inp = input().split(" ")

    a = int(inp[0])
    b = int(inp[1])

    if a == 0 and b == 0:
        break
    else:

        cont = 0
        if a <= 1 and b >= 1:
            cont = -1

        for i in fib:
            if i >= a and i <= b:
                cont += 1
        print(cont)