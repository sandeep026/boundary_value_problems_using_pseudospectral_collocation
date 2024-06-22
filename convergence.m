clear

N=5:5:40;
E=zeros(1,length(N));

for i=1:length(N)
E(i)=BVP(N(i));
end

semilogy(N,E,'linewidth',3)
xlabel('grid size [N]','FontSize',16)
ylabel('discretization error','FontSize',16)
set(gca,'FontSize',16)
grid on
print('exp.svg', '-dsvg', '-r600')
