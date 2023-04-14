load('eigs_more.mat');
totalXcoord = [0-sqrt(3)/5, 0, sqrt(3)/5, 2*sqrt(3)/5, 3*sqrt(3)/5, 4*sqrt(3)/5, sqrt(3), sqrt(3)+sqrt(2)/5, sqrt(3)+2*sqrt(2)/5, sqrt(3)+3*sqrt(2)/5, sqrt(3)+4*sqrt(2)/5, sqrt(3)+sqrt(2), sqrt(3)+sqrt(2)+sqrt(2)/5];
totalEigenSPARC = [eigensSPARC(:, 1+1), eigensSPARC, eigensSPARC(:, 11-1)]*27.2113897;
totalEigenAbinit = [eigensAbinit(:, 1+1), eigensAbinit, eigensAbinit(:, 11-1)]*27.2113897;
figure('Renderer', 'painters', 'Position', [1361 558 300 420])
for line = 1:24
	curve1 = plot(totalXcoord, totalEigenAbinit(line,:), 'xk','linewidth',1.5, 'markersize', 6);
    hold on;
	curve2 = plot(totalXcoord, totalEigenSPARC(line,:), 'or', 'markersize', 6);
	hold on;
	k_interp = linspace(totalXcoord(1),totalXcoord(end),1000);
	lambda_interp_abinit = interp1(totalXcoord,totalEigenAbinit(line,:), k_interp, 'spline');
	plot(k_interp, lambda_interp_abinit, '-k', 'linewidth',1.5);
	hold on;
	lambda_interp_msparc = interp1(totalXcoord,totalEigenSPARC(line,:), k_interp, 'spline');
	plot(k_interp, lambda_interp_msparc, '--r', 'linewidth',1.5);
	hold on;
	% legendInfo{i} = ['$n$ = ' num2str(n)];
end
fermiLevel = [totalXcoord(1),4.3936989749E-01*27.2113897;totalXcoord(end),4.3936989749E-01*27.2113897];
curve3 = plot(fermiLevel(:,1),fermiLevel(:,2),':b', 'linewidth',1.5);
% Xline = [1,0; 1,20];
% Mline = [2,0; 2,20];
% Gline = [2+sqrt(2),0;2+sqrt(2),20];
Rline = [sqrt(3),0;sqrt(3),20];
plot(Rline(:,1),Rline(:,2),'-k');
axis([totalXcoord(2) totalXcoord(end-1) 7.5 17.5]);
ylabel('Energy (eV)','Interpreter','latex');
yticks([7.5 10 12.5 15 17.5]);
yticklabels({'7.5','10.0','12.5','15.0','17.5'});
xticks([0 sqrt(3) sqrt(2)+sqrt(3)]);
xticklabels({'$\Gamma$','R','X'});
xlabel('Wavevector','Interpreter','latex');
set(gca,'fontsize',18);
set(gca,'fontname','Times New Roman');
set(gca,'TickLabelInterpreter','latex');
lgd = legend([curve2,curve1,curve3],'SPARC','ABINIT','Fermi level','Location','northwest');
set(lgd,'fontsize',14,'FontName','Times New Roman','Interpreter','Latex');