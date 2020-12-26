def evaluate(cases):
    for case in cases:
        days_lost = 0
        # week and i are created because in the first week Friday and saturday are on days 6 and 7
        # and after that week the friday is on the next (6*week)+i
        week = 1
        i = 0
        for day in range(1,case[0]+1):
            if day != 6*(week)+i and day != 7*(week):
                for hartal in case[1]:
                    if day % hartal == 0:
                        days_lost += 1
                        break
            if day > 7*(week):
                week += 1
                i += 1
        print(days_lost)

if __name__ == '__main__':
    try:
        N = int(input().strip()) #testcases
        total = [] #it is going to obtain a tuple with the num of days and the hartal days
        while N > 0:
            P = int(input().strip()) #number of parties
            num_hartals = int(input().strip()) #number of hartal day
            hartal_days = [] #list of hartal days
            while num_hartals > 0:
                hartal_days.append(int(input().strip()))
                num_hartals -=1
            total +=[[P,hartal_days]]
            N-=1
        evaluate(total)
    except EOFError as error:
        print()
