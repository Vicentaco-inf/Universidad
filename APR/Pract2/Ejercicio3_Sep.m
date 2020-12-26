#!/usr/bin/octave -qf

#Cargamos datos de las separables
load("data/mini/trSep.dat");
load("data/mini/trSeplabels.dat");

#t 0 ya que usamos un kernel lineal
res = svmtrain(trlabels, tr, '-t 0 -c 1000');

#sop contendra todos los vectores soporte de tr
Vsop = tr(res.sv_indices,:);

peso = res.sv_coef'*Vsop;

#Puntos de corte con el eje x y con el eje y para poder trazar la recta de separacion de clases
Px = [res.rho/peso(1,1) 0];
Py = [0 res.rho/peso(1,2)];
#Recta de sep verde   Puntos a clasificar clase 1 x rojas                              
plot(Px, Py, 'g', tr(trlabels==1,1),tr(trlabels==1,2),'xr',
#Puntos a clasificar clase 2  x azules 
tr(trlabels==2,1),tr(trlabels==2,2),'xb',
#Vectores soporte de la clase 1 marcados como cuadrados rojos
Vsop(trlabels(res.sv_indices)==1,1), Vsop(trlabels(res.sv_indices)==1,2),'sr',
#Vectores soporte de la clase 2 marcados como cuadrados azules
Vsop(trlabels(res.sv_indices)==2,1), Vsop(trlabels(res.sv_indices)==2,2),'sb');
print -djpg Ej3_Sep.jpg;

