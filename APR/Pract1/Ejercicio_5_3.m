#!/usr/bin/octave -qf

#Cargamos datos de test y training
load("t10k-images-idx3-ubyte.mat.gz");
load("train-images-idx3-ubyte.mat.gz");
load("train-labels-idx1-ubyte.mat.gz");
load("t10k-labels-idx1-ubyte.mat.gz");

#Matriz PCA
[m, W] = pca(X);

file = fopen('ejercicio5_3.dat','w');

#Reduccion PCA de 10 en 10 hasta 100
for i = 10:10:100
  aux = [];
  for k = 1:5
    #Reducimos matrices a diferentes tamanyos
    XR = (X - m)*W(:,1:i);
    YR = (Y - m)*W(:,1:i);
    
    #result obtendra el error de clasificacion con el PCA i y epsilon 1.0
    result = Ejercicio_5(XR,xl,YR,yl,k,0.9);
    aux = [aux result];
    printf("Para i = %d, epsilon 0.9 y %d mixturas, resultado = %f\n", i, k, result);
  endfor
  #Lo escribimos en ejercicio5_3.dat para plotear
  fprintf(file, "%d %f %f %f %f %f\n", [i, aux]);
endfor

fclose(file);