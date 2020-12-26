function [error] = GenRed(tr, trlabels, ts, tslabels)
  
  #Libreria nnet
  addpath("nnet");
  
  #La libreria nnet trabaja con datos por columnas asi que transponemos los datos
  mInput = tr';
  mOutput = trlabels';
  mTestInput = ts';
  mTestOutput = tslabels';
  
  #obtenemos un 80% de muestras de entrenamiento y un 20% de validacion
  [nFeat, nSamples] = size(mInput);
  nTr = floor(nSamples*0.4);
  nVal = nSamples - nTr;
  
  #Permutacion aleatoria
  rand('seed', 23);
  indices = randperm(nSamples);
  
  #Tomamos nTr primeras muestras para el entrenamiento y las restantes para la validacion
  mTrainInput = mInput(:,indices(1:nTr));
  mTrainOutput = mOutput(indices(1:nTr));
  mValiInput = mInput(:,indices((nTr+1):nSamples));
  mValiOutput = mOutput(indices((nTr+1):nSamples));
  
  #Necesitamos el numero de clases para poder codificarlas con el formato one hot encoding
  NumClases = unique(trlabels);
  
  #Una vez tenemos la cantidad de clases, podemos usar la funcion onehot encoding para obtener
  #los datos con sus propias etiquetas (OneHotEncoding esta implementado en la misma carpeta
  EtiqOneHot = OneHotEncoding(mValiOutput, NumClases);
  
  #Normalizacion con media 0 y desviacion tipica 1
  #Dat normaliz  #media      #Desv Tipica
  [mTrainInputN, cMeanInput, cStdInput] = prestd(mTrainInput);
  
  #Datos validacion de entrada (P) y salida (T)
  VV.P = mValiInput;
  VV.T = EtiqOneHot;
  
  #Normalizar usando la normalizacion de las muestras de entrada
  VV.P = trastd(VV.P, cMeanInput, cStdInput);
  
  #Pr min y max de datos de entrenamiento Dx2
  #ss vector fila con el numero de neuronas en cada capa oculta y en la capa de salida
  #trf la lista de funciones de activacion de cada capa (tansig para capa oculta, logsig capa salida)
  #btf algoritmo de entrenamiento de la red neuronal (trainlm)
  #blf parametro q no se usa
  #pf la funcion objetivo a minimizar (mse)
  
  #net = newff(Pr, ss, trf, btf, blf, pf)
  
  MLPnet = newff(minmax(mTrainInputN), [1 1 1 length(NumClases)], {"tansig", "tansig", "tansig", "logsig"}, "trainlm","","mse");

  #Algunos parametros
  MLPnet.trainParam.show = 10;    #Cuantas epoch queremos que se impriman
  MLPnet.trainParam.epochs = 300; #Num maximo de epoch a realizar

  #Finalmente entrenamos la red
  EtiqOneHotTrain = OneHotEncoding(mTrainOutput',NumClases);

  net = train(MLPnet,mTrainInputN,EtiqOneHotTrain,[],[],VV);
  #Antes de clasificar el conjunto de test(net), aplicamos normalizacion como se 
  #ha hecho anteriormente
  
  mTestInputN = trastd(mTestInput, cMeanInput, cStdInput);
  
  #Una vez normalizados, clasificamos
  simOut = sim(net, mTestInputN);
  
  #Implementamos una manera donde dada la salida de la MLP para el conjunto de test
  #(simOut), y sus etiquetas (tslabels) nos devuelva el error de clasificacion
  
  [_,clasificacion] = max(simOut);
  error = sum(NumClases(clasificacion)!=tslabels)/rows(tslabels);
  
endfunction