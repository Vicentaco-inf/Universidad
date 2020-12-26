addpath('~/asigDSIC/ETSINF/apr/bayes/BNT')
addpath(genpathKPM('~/asigDSIC/ETSINF/apr/bayes/BNT'))

N = 5; Plcn = 1; Fum = 2; CdP = 3; RX = 4; Dis = 5;
grafo = zeros(N, N);
grafo(Plcn,CdP) = 1;
grafo(Fum,CdP) = 1;
grafo(CdP,RX) = 1;
grafo(CdP,Dis) = 1;

nodosDiscretos = 1:N;
tallaNodos = 2*ones(1,N);
tallaNodos(1,4) = 3
redB = mk_bnet(grafo, tallaNodos,'discrete', nodosDiscretos);

redB.CPD{Plcn} = tabular_CPD(redB, Plcn, [0.9 0.1]);
redB.CPD{Fum} = tabular_CPD(redB, Fum, [0.7 0.3]);
redB.CPD{CdP} = tabular_CPD(redB, CdP, [0.999 0.97 0.95 0.92 0.001 0.03 0.05 0.08]);
redB.CPD{RX} = tabular_CPD(redB, RX, [0.80 0.1 0.1 0.2 0.1 0.7]);
redB.CPD{Dis} = tabular_CPD(redB, Dis, [0.7 0.35 0.3 0.65]);

motor = jtree_inf_engine(redB);

evidencia = cell(1,N);
evidencia{Fum} = 1;
evidencia{RX} = 1;
evidencia{Dis} = 2;
[motor, logVerosimi] = enter_evidence(motor, evidencia);
m = marginal_nodes(motor,CdP);
m.T'

