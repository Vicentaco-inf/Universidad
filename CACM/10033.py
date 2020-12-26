def computation():
    pos = 0
    while(True):
        try:
            digits = input().strip()
            if(len(digits) != 0):
                mem[pos] = digits
                pos += 1
            else:
                break
        except EOFError:
            break
def evalcases():
    pos = 0
    cont = 0
    while(True):
        num = int(mem[pos][0])
        d = int(mem[pos][1])
        n = int(mem[pos][2])
        pos+= 1
        cont+=1
        if num == 1:
            break
        elif num == 2:
            r[d] = n
        elif num == 3:
            r[d] += n
            r[d] %= 1000
        elif num == 4:
            r[d] *= n
            r[d] %= 1000
        elif num ==  5:
            r[d] = r[n]
        elif num == 6:
            r[d] += r[n]
            r[d] %= 1000
        elif num ==  7:
            r[d] *= r[n]
            r[d] %= 1000
        elif num ==  8:
            r[d] = int(mem[r[n]])
        elif num ==  9:
            mem[r[n]] = str(r[d])
        elif r[n] != 0:
            pos = r[d]
    return cont
if __name__ == '__main__':
	numcases = int(input())
	input()
	while numcases > 0:
		r = [0]*10
		mem = ["000"]*1000
		computation()
		print(evalcases())
		numcases -=1
		if(numcases > 0):
			print()
