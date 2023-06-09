load('eigs.mat')
energyDiff = sparcEigens(1) - qeEigens(1);
qeEigens = qeEigens + energyDiff;
[sparcDOS,sparcE]=eig2DOS(sparcEigens',500,0.15);
[qeDOS,qeE]=eig2DOS(qeEigens',500,0.15);
curve1 = plot(qeE, qeDOS, '-k', 'linewidth',1.5);
hold on;
curve2 = plot(sparcE, sparcDOS, '--r', 'linewidth',1.5);
hold on;
fermiLevel = [-0.181403*27.2113897,0.00001;-0.181403*27.2113897,70]; % at the middle of LUMO and HOMO
% fermiLevel = [-1.6421052007E-01*27.2113897,0.00001;-1.6421052007E-01*27.2113897,35];
% fermiLevelHOMO = [-2.154790656337E-01*27.2113897,0.00001;-2.154790656337E-01*27.2113897,35];
% fermiLevelQE = [(-1.214139273819722e-1 + energyDiff)*27.2113897,0.00001;(-1.214139273819722e-1 + energyDiff)*27.2113897,35];
curve3 = plot(fermiLevel(:,1),fermiLevel(:,2),':b', 'linewidth',1.5);
% curve4 = plot(fermiLevelHOMO(:,1),fermiLevelHOMO(:,2),':o', 'linewidth',1.5);
% curve5 = plot(fermiLevelQE(:,1),fermiLevelQE(:,2),':r', 'linewidth',1.5);
axis([-20 -2 0 70]);
ylabel('Density of states','Interpreter','latex');
yticks([0 14 28 42 56 70]);
yticklabels({'0.0','14.0','28.0','42.0','56.0','70.0'});
xticks([-20 -14 -8 -2]);
xticklabels({'-20.0', '-14.0', '-8.0', '-2.0'});
xlabel('Energy (eV)','Interpreter','latex');
set(gca,'fontsize',18);
set(gca,'fontname','Times New Roman');
set(gca,'TickLabelInterpreter','latex');
lgd = legend([curve2,curve1],'SPARC','QE','Location','northwest');
% lgd = legend([curve2,curve1],'SPARC','QE','Location','northwest');
set(lgd,'fontsize',14,'FontName','Times New Roman','Interpreter','Latex');