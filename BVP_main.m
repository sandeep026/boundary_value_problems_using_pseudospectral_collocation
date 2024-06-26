% solve boundary value problems using PS methods
% ode: x''-tx'-x=0
% BCs: x(-1)=x(1)=1
%sol : exp((t^2-1)/2)

import casadi.*

N=25;
Nx=1;
t0=-1;
tf=1;

opti=casadi.Opti();

X=opti.variable(Nx,N+1);


%LGL grid points and quadrature weights
[tau,wi]=legslb(N+1);
tau=tau';
wi=wi';
% differentiation matrix
D=legslbdiff(N+1,tau);


t=(tf-t0)/2*tau+(tf+t0)/2;

Xd=2/(tf-t0)*(D*X')';
Xdd=2/(tf-t0)*(D*Xd')';

res=Xdd-t.*Xd-X;

opti.minimize(0)
opti.subject_to(res(2:end-1)==0)
opti.subject_to(X(1)==1)
opti.subject_to(X(N+1)==1)

opti.set_initial(X,zeros(Nx,N+1))

opti.solver('ipopt')
sol=opti.solve();


Xs=sol.value(X);
Xa=exp((t.^2-1)/2);
plot(t,Xs,'d')
plot(t,Xa,'linewidth',3);
xlabel('time [s]')
ylabel('x(t)')
grid on
set(gca,'FontSize',16)
print('sol.svg', '-dsvg', '-r600')
figure
semilogy((abs(Xs-Xa)),'linewidth',3);
xlabel('time [s]')
ylabel('Error')
set(gca,'FontSize',16)
print('esol.svg', '-dsvg', '-r600')
grid on
err=norm(Xs-Xa,2,'fro');
