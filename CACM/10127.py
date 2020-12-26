def calculo(number):
    counter = 0
    x = number
    while(x > 0):
        while(x % 10 == 1):
            counter+=1
            x = int(x/10)
        if(x > 0):
            x += number
    return counter


if __name__ == '__main__':
    try:
        num = input().strip()
        while(len(num) > 0):
            print(calculo(int(num)))
            num = input().strip()
    except EOFError as error:
        pass
