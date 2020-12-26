#!/usr/bin/octave -qf

#Cargamos datos de test y training
load("t10k-images-idx3-ubyte.mat.gz");
load("train-images-idx3-ubyte.mat.gz");
load("train-labels-idx1-ubyte.mat.gz");
load("t10k-labels-idx1-ubyte.mat.gz");

#Matriz PCA
[m, W] = pca(X);

file = fopen('ejercicio5_2.dat','w');

#Reduccion PCA de 10 en 10 hasta 100
for i = 10:10:100
  #Reducimos matrices a diferentes tamanyos
  XR = (X - m)*W(:,1:i);
  YR = (Y - m)*W(:,1:i);
  
  #result obtendra el error de clasificacion con el PCA i y epsilon 1.0
  result = Ejercicio_5(XR,xl,YR,yl,1,1.0);

  #Lo escribimos en ejercicio4_1.dat para plotear
  fprintf(file, "%d %f \n", [i, result]);
  printf("Para i = %d y epsilon 1.0, resultado = %f\n", i, result);
  
endfor

fclose(file);