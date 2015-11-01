%Exp de Miilikan LFEB %Constantesrho=973;eta=18.52e-6;g=9.8;e=1.6e-19;p=1.013e5%MedidasD=6.08e-3 % distância entre placad=2.5e-3% distancia percorridaed=0.1e-3;t=16; % tempoet=0.1;U=258;  % tensão paragemeU=1;%calculos intermediosvL=d/tert=et/terd=ed/dervL=ert + erdeVL=abs(ervL*vL)
R=sqrt(9*eta*vL/2/rho/g)eR=1/2*R*ervL
%Carga da gotaq=6*pi*R*eta*vL*D/Ueq=(eR/R+ ervL + eU/U)*q%carga corrigidab=7.88e-3; qcor=q*(1/(1+b/p/R))^(3/2)eqcor=eq*(1/(1+b/p/R))^(3/2)
