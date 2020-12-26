#!/usr/bin/octave -qf

#Cargamos los datos de test y training
load("t10k-images-idx3-ubyte.mat.gz");
load("train-images-idx3-ubyte.mat.gz");
load("train-labels-idx1-ubyte.mat.gz");
load("t10k-labels-idx1-ubyte.mat.gz");

#Matriz PCA
[m, W] = pca(X);

file = fopen('ejercicio4_2.dat','w');

#Reduccion PCA de 10 en 10 hasta 100
for i = 10:10:100
  aux = [];
  #Diferentes epsilons que usaremos para los diferentes i PCA
  for epsilon = [0.1 0.2 0.5 0.9 1.0]
    
    #Reducimos matrices a diferentes tamanyos
    XR = (X - m)*W(:,1:i);
    YR = (Y - m)*W(:,1:i);
    
    #result obtendra el error de clasificacion con el PCA i y epsilon 
    result = gaussian(XR,xl,YR,yl,epsilon);
    
    #estructura de aux -> PCA 0.1 0.2 0.5 0.9 1.0
    #                      k   x   x   x   x   x
    aux = [aux result];
    printf("Para i = %d y epsilon %f, resultado = %f\n", i, epsilon, result);
  
  endfor
  
  #Lo escribimos en ejercicio4_2.dat para plotear
  fprintf(file, "%d %f %f %f %f %f\n", [i, aux]);
  
endfor

fclose(file); 