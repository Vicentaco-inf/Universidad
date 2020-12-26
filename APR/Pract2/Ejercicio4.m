#!/usr/bin/octave -qf

load("t10k-images-idx3-ubyte.mat.gz");
load("t10k-labels-idx1-ubyte.mat.gz");
load("train-images-idx3-ubyte.mat.gz");
load("train-labels-idx1-ubyte.mat.gz");
CValues = [0.0001 1 1000];

#file = fopen('Ej4.dat','w');

for i=1:3
  c = num2str(i)
  #valor = [];
  #fprintf(file, "%d ", [i]);
  for j=0:3
    t = num2str(CValues(j))
    cad = cstrcat('-t ',t,'-c ',c);
    res = svmtrain(xl, X, cad);
    #Cad tendra la estructura -> -t 0 -c 0.0001 en la primera iteracion
    trainlabels = svmpredict(yl,Y, res,' ');
    #Obtenemos la media de las Y que estan mal clasificadas
    ErrorMedio=mean(trainlabels!=yl)

    epsilon = 1.96 * sqrt(ErrorMedio*(1-ErrorMedio)/rows(Y))

    #Varianza de error
    CotaMax = ErrorMedio + epsilon
    CotaMin = ErrorMedio - epsilon
    #valor = [ErrorMedio CotaMax CotaMin];
    #fprintf(file, "%f %f %f ", [valor]);
  endfor
  #fprintf(file, "\n");
endfor

#fclose('Ej4.dat');