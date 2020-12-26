#!/usr/bin/env python3

def minMoreCases(inp):
    min_v = 0
    pos_v = -1
    for pos in range(len(inp)):
        if min_v == 1:
            break
        val = inp[pos]
        if val != 0 and (pos_v == -1 or val < min_v):
            min_v = val
            pos_v = pos
    return min_v

Cases = int(input())
input()

for case in range(Cases):

    NumCand = int(input())
    VotesOnCand = [0] * NumCand #Num of votes of each candidate
    Cand = []                   #List of active candidates
    Deleted = []                #List of deleted candidates
    Votes = []                  #List of votes 
    PplVoted = 0                #Cant of votes in int

    for cand in range(NumCand):
        Cand.append(input().strip())

    
    for i in range(1001):
        try:
            enter = ""
            enter = input()
        except:
            pass
        if enter != "":
            PplVoted += 1
            Votes.append([])
            Votes[i] = list(map(int, enter.split(" ")))
        else:
            break

    #Process of election
    while True:

        #Watch all the votes and sum the votes on each vote value
        for i in range(PplVoted):
            for j in range(len(Votes[i])):
                if(Votes[i][j] - 1) not in Deleted:
                    VotesOnCand[Votes[i][j] - 1] += 1
                    break
        #Get the maxium of votes
        MaxVotes = max(VotesOnCand)
        MaxPos = VotesOnCand.index(MaxVotes)

        #If exists a candidate with more of 50% of votes, show it and finish
        if MaxVotes > PplVoted / 2:
            print(Cand[MaxPos])
            break

        #Get the minimum of votes
        if len(Deleted) > 0:
            MinVotes = minMoreCases(VotesOnCand)
        else:
            MinVotes = min(VotesOnCand)

        #If all the candidates have the same votes
        if MaxVotes == MinVotes:
            for i in range(NumCand):
                if i not in Deleted:
                    print(Cand[i])
            break
        else:
            #Lets delete the candidates with the smallest number of votes
            for i in range(NumCand):
                if VotesOnCand[i] == MinVotes:
                    Deleted.append(i)
        
        VotesOnCand = [0] * NumCand

    if(case + 1) != Cases:
        print()







