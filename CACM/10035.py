#!/usr/bin/env python3
#Primary numbers
numbers = input()
#While input is diferent from 0 0, do
while(numbers != "0 0"):
    #Get the 2 numbers to see the carry
    numbers = numbers.split()
    numb1 = int(numbers[0]) 
    numb2 = int(numbers[1])

    #Start with 0 carries and the carry is the number to sum on the next operation
    carry = 0
    NCarries = 0

    #The biggest number has 10 numbers
    for item in range(10):
        #suma has the value of the sum
        suma = numb1%10 + numb2%10 + carry
        #Needs to carry something if suma is bigger than 1 digit
        if suma >= 10:
            carry = 1
            NCarries = NCarries + 1
        else:
            carry = 0
        #Check the next digit
        numb1 //= 10
        numb2 //= 10
    if NCarries == 0:
       
        print("No carry operation.")
    elif NCarries == 1:
       
        print("1 carry operation.")
    else:
        print(str(NCarries), "carry operations.")
    numbers = input()
