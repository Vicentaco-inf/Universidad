#!/usr/bin/octave -qf

load("train-labels-idx1-ubyte.mat.gz");
load("t10k-labels-idx1-ubyte.mat.gz");
load("t10k-images-idx3-ubyte.mat.gz");
load("train-images-idx3-ubyte.mat.gz");

[m, W] = pca(X);

for i = 10:10:30
  #reduccion pca
  XR = (X - m)*W(:, 1:i);
  YR = (Y - m)*W(:, 1:i);
  i
  error = GenRed(XR, xl, YR, yl)
  
  epsilon = 1.96 * sqrt(error*(1-error)/rows(Y))
  
  Mayor = error + epsilon
  Menor = error - epsilon
  
endfor