def evaluate(res):
    lista = ["Erdos, P."]
    visitados = ["Erdos, P."]
    val = {}
    val["Erdos, P."] = 0
    while lista: #while the list is not empty and all the authors have been visited
        name = lista.pop(0)
        for elem in res[name]:
            if elem not in visitados:
                val[elem] = val[name]+1
                visitados.append(elem)
                lista.append(elem)
    return val

def authors():
    for _ in range(P):
        paper = input().strip().split(":")
        autores = paper[0]
        autores = autores.strip().split(".,")
        autores = [x.strip(". ") for x in autores]
        for autor in autores:
            autor+="."
            vecinos = res.get(autor,set())
            for secautor in autores:
                secautor+="."
                if autor == secautor:
                    continue
                vecinos.add(secautor)
            res[autor] = vecinos


def output(name):
    try:
        print(name,result[name])
    except:
        print(name,"infinity")

if __name__=='__main__':
    numcases = int(input()) #number of cases
    scenario = 1
    while numcases > 0:
        data = input().strip().split() #take the number  of papers and the number of authors we want to show
        P = int(data[0]) # number of papers
        N = int(data[1]) # number of authors
        res = {}
        authors() #take every paper and assign per each author his neighbour in res
        result = evaluate(res) #assign a value per each author starting with Erdos P and his neighbours
        print("Scenario",scenario)
        for _ in range(N):
            output(input().strip()) #show value
        scenario+=1
        numcases-=1

