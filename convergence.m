clear

N=5:1:20;
E=zeros(1,length(N));

for i=1:length(N)
E(i)=BVP(N(i));
end

semilogy(N,E)
xlabel('grid size [N]')
ylabel('discretization error')
