%% Resolution des equations aux derievee partielles
%% Equation de poisson
%%
clc, clear all
    %Donnee du systeme
eps0=1;
rho0=1;
H=1024;
h = 6.626068e-34;
A=-1/4;
C=h^2/(4*eps0);

    %Creation des axes
x=0:H;
y=0:H;

rho=zeros(H);
rho(round(0.38*H):round(0.42*H),round(0.25*H):round(0.75*H))=rho0;
rho(round(0.58*H):round(0.62*H),round(0.25*H):round(0.75*H))=-rho0;



b=reshape(C*rho,H^2,1);
    %Creation de la matrice L
%L=(diag(ones(H^2,1))+diag(A*ones(H^2-1,1),-1)+diag(A*ones(H^2-1,1),1)...
% +diag(A*ones(H^2-H,1),-H)+diag(A*ones(H^2-H,1),H));
%L=sparse(L);
tic
un=ones(H^2,1);
L=spdiags([un*A un*A un un*A un*A],[-H -1 0 1 H],H^2,H^2);
toc

%tic
    %utile pour mesurer la duree prise pour la resolution de l'equation
z=L\b;
%toc

z=reshape(z,H,H);

clf
figure(1)
imagesc([0 1],[0 1], z)
axis xy

figure (2)
contour(0:1/(H-1):1,0:1/(H-1):1,z,10)
axis xy
hold on

%reduction = permet de diminuer le nombre de point pris pour ...
%la creation du champ de vecteurs electrique afin d'avoir ...
% un graphique plus lisible.

for i=1:4
    table=[1:2:length(z)];
    z(table,:)=[];
    z(:,table)=[];
end

[Ex,Ey]=gradient(z,0.05);
precision=length(z);
quiver(0:1/(precision-1):1,0:1/(precision-1):1,Ex,Ey)
axis ([0 1 0 1])