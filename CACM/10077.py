#!/usr/bin/env python3
#Brocot trie
number = input()

while(number != "1 1"):
    number = number.split(" ")
    number[0], number[1] = int(number[0]), int(number[1]) #Number contains the division. f.e -> [1, 2] = 1/2
    case = [[0,1],[1,1],[1,0]] #Initial state
    result = ""
    while(True):
        #The numbers to compare with
        izq = number[0] * case[1][1] 
        der = number[1] * case[1][0]
        
        if izq < der:
            #Our number is smaller than case[1]
            result = result + "L"
            case[2] = case[1]
            aux = [0,0]
            aux[0] = case[0][0] + case[2][0]
            aux[1]= case[0][1] + case[2][1]
            case[1] = aux

        elif izq > der:
            #Our number is bigger than case[1]
            result = result + "R"
            case[0] = case[1]
            aux = [0,0]
            aux[0] = case[0][0] + case[2][0]
            aux[1] = case[0][1] + case[2][1]
            case[1] = aux
        else:
            #Our number is the same than case[1]
            break
    
    print(result)
    number = input()
