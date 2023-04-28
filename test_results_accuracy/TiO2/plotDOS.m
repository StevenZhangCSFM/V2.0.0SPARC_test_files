load('eigs.mat')
[sparcDOS,sparcE]=eig2DOS(eigsSPARC,500,0.15);
% eigsQE = eigsQE + (eigsSPARC(SPARCGamma,1) - eigsQE(qeGamma,1));
[qeDOS,qeE]=eig2DOS(eigsQE,500,0.15);
shift = sparcE(1) - qeE(1);
curve1 = plot(qeE + shift, qeDOS, '-k', 'linewidth',1.5);
hold on;
curve2 = plot(sparcE, sparcDOS, '--r', 'linewidth',1.5);
hold on;
fermiLevel = [-0.25078*27.2113897,0.00001;-0.25078*27.2113897,54]; % at the middle of LUMO and HOMO
% fermiLevelQE = [1.512299078679678e-1*27.2113897 + shift,0.00001;1.512299078679678e-1*27.2113897 + shift,24];
curve3 = plot(fermiLevel(:,1),fermiLevel(:,2),':b', 'linewidth',1.5);
% curve4 = plot(fermiLevelQE(:,1),fermiLevelQE(:,2),':r', 'linewidth',1.5);
axis([-33 -3 0 48]);
ylabel('Density of states','Interpreter','latex');
yticks([0 12 24 36 48]);
yticklabels({'0.0','12.0','24.0','36.0','48.0'});
xlabel('Energy (eV)','Interpreter','latex');
xticks([-33 -27 -21 -15 -9 -3]);
xticklabels({'-33.0','-27.0','-21.0','-15.0','-9.0','-3.0'});
set(gca,'fontsize',18);
set(gca,'fontname','Times New Roman');
set(gca,'TickLabelInterpreter','latex');
% lgd = legend([curve2,curve1,curve3,curve4],'SPARC','QE','Fermi level','Fermi Energy QE','Location','northwest');
lgd = legend([curve2,curve1],'SPARC','QE','Location','northwest');
set(lgd,'fontsize',14,'FontName','Times New Roman','Interpreter','Latex');
