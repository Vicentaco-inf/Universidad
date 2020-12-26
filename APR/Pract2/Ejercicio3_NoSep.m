#!/usr/bin/octave -qf

load("data/mini/tr.dat");
load("data/mini/trlabels.dat");

res = svmtrain(trlabels, tr, '-t 0 -c 1000');

Vsop = tr(res.sv_indices,:)

peso = res.sv_coef' * Vsop

#Puntos de la recta de separacion de clases
Px = [res.rho/peso(1,1) 0]
Py = [0 res.rho/peso(1,2)]

#Margen inferior
MarBajoX = [(res.rho-1)/peso(1,1) 0];
MarBajoY = [0 (res.rho-1)/peso(1,2)];

#Margen superior
MarAltoX = [(res.rho+1)/peso(1,1) 0];
MarAltoY = [0 (res.rho+1)/peso(1,2)];

#Conseguimos el vector tolerancia para saber como maximo cuanto se puede ir un punto de la clasificacion de su clase
tolerancia = 1 - sign(res.sv_coef').*(peso*Vsop' - res.rho);

#Plot frontera decision y margenes
plot(MarAltoX, MarAltoY, 'y', 
MarBajoX, MarBajoY, 'y',
Px, Py, 'g', 
#Plot puntos
tr(trlabels==1,1),tr(trlabels==1,2),'xr',
tr(trlabels==2,1),tr(trlabels==2,2),'xb',
Vsop(abs(res.sv_coef)==1000,1), Vsop(abs(res.sv_coef)==1000,2), '*k', 'markersize', 15,
Vsop(trlabels(res.sv_indices)==1,1), Vsop(trlabels(res.sv_indices)==1,2), 'sr', 
Vsop(trlabels(res.sv_indices)==2,1), Vsop(trlabels(res.sv_indices)==2,2), 'sb' );

#Recorremos todos los puntos y utilizamos su x y su y para imprimir en su punto
for i = 1:1:rows(tr);
  
  x = tr(i,1);
  y = tr(i,2);
  #ploteamos la informacion de los puntos que son vectores soporte
  h = text(x, y, sprintf("%.2f\n%.2f", 0.0, 0.0));
  if(res.sv_coef(i==res.sv_indices))
    delete(h);
    text(x, y, sprintf("%.2f\n%.2f", abs(res.sv_coef(i==res.sv_indices)), tolerancia(i==res.sv_indices)));
    continue
  endif
  printf("%d, %d\n", x, y);
endfor

print -djpg Ej3_NoSep.jpg;