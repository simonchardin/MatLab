%% Equation de diffusion

clear all
clf

L=5;
phi0=1;
D=1;
deltax=0.05
deltat=(deltax).^2/(2*D)
X=[-L:deltax:L]';
Phi = phi0*(X<0.15*L).*(X>-0.15*L);
N=1000;

%Methode FTCS

v=VideoWriter('MethodeFTCS.avi');
open(v);

alpha=(D*deltat)/(deltax).^2
H=1+2*L/deltax;
        
un = ones(H,1);

M=spdiags([alpha*un (1-2*alpha)*un alpha*un],[-1 0 1],H,H);

for j=1:N
    Phi = M*Phi;
    if mod(j,10)==0 %On reduit le nombre d'image de la video
        plot(X,Phi);
        title('Phi(x,t) pour le schéma FTCS');
        xlabel('x');
        ylabel('Concentration');
        axis([-L L 0 phi0]);
        F= getframe
        writeVideo(v,F);
    end

end

close(v);
figure (1)
imshow(F.data)

%% Methode BTCS


clear all
clf

L=5;
phi0=1;
D=1;
deltax=0.05
deltat=(deltax).^2/(2*D)
X=[-L:deltax:L]';
Phi = phi0*(X<0.15*L).*(X>-0.15*L);
N=5000;

v=VideoWriter('MethodeBTCS.avi');
open(v);

alpha=(D*deltat)/(deltax).^2
H=1+2*L/deltax;

un = ones(H,1);

M=spdiags([-alpha*un (1+2*alpha)*un -alpha*un],[-1 0 1],H,H);

for j=1:N
    Phi=M\Phi;
    if mod(j,10)==0 %idem methode FTCS
        plot(X,Phi);
        title('Phi(x,t) pour le schéma BTCS');
        xlabel('x');
        ylabel('Concentration');
        axis([-L L 0 phi0]);
        F= getframe
        writeVideo(v,F);
    end
end

close(v);
figure (1)
imshow(F.data)
