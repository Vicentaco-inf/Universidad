function [etiq] = OneHotEncoding(etiquetas, NumClases)
  #Matriz de ceros para iterar sobre ella y poner 1 en el sitio idoneo
  etiq = zeros(length(NumClases), rows(etiquetas));
  
  for i = 1:length(NumClases)
    %Buscamos donde poner el 1
    pos = find(etiquetas==NumClases(i));
    etiq(i, pos) = 1;
  endfor
endfunction