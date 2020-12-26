import math
def isPalyndrom(number):#Check if the number is Palyndrome
    if number > 0:
        length = (int)(math.log10(number)+1) #number of digits
        number = str(number)
        for i in range(length//2):
            if number[i] != number[length-i-1]:
                return False
    return True
def palyndrom(number):
    res = int(number) + int(number[::-1]) #sum the number + its reverse number
    count = 1
    while(isPalyndrom(res) != True):
        count += 1
        aux = str(res)
        res= res + int(aux[::-1]) #loop to count the number of sum we have to do to be palyndrome
    return count,res
if __name__== '__main__':
    numcases = int(input())
    res = []
    while(numcases > 0):
        num = input()
        res.append(palyndrom(num))
        numcases-=1
    for n in res:
        print(' '.join(map(str,n)))