%%Equation d'onde 1D
clc, clf, clear all

L=1;
c1=1;
c2=1; % c2=sqrt(2) permet d'observer un phenomene de reflection a l'interface
deltax=0.0001;
deltaT=min(deltax/c1,deltax/c2);
N=30000;
H=1+L/deltax;

x=[0:deltax:L];
t=[0:N-1]*deltaT;

beta=zeros(H,1);
beta(1:1+L/(2*deltax))=(c1*deltaT/deltax)^2;
beta(1+L/(2*deltax):H)=(c2*deltaT/deltax)^2;

U=zeros(N,H);
U(:,1)=exp(-(((t-0.05)/0.01).^2));

%Corde de Melde :
%U(:,1)=sin(10*t);

%Pour la corde de Melde il faut excuter sur une plus grande fenetre pour
%les interferences ainsi que pour le temps. (N=20000)



for n=2:N
    for i=2:H-1
        U(n+1,i)=beta(i+1)*U(n,i+1)+beta(i-1)*U(n,i-1)+2*(1-beta(i))*U(n,i)-U(n-1,i);
    end
    
    
end
% On va afficher la propagation de l'onde calculée dans la matrice U sur un
% pas de 10 afin que l'animatin soit plus rapide. (On ne peut pas le faire directement dans la boucle de calcul)
v=VideoWriter('C2=sqrt2_Excitation2.avi');
open(v);
iteration=2:100:N;
for n=iteration
    plot(x,U(n+1,:))
    axis([0 1 -1 1])
    title (["Propagation d'une Onde en 1D en fonction du temps"])
    xlabel (['X=',num2str(L),'m'])
    F= getframe
    writeVideo(v,F);
end
close(v);
clf
figure 
imshow(F.data)
