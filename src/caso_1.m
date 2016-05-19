%% Prior and Posterior Predictive, Second Example

clear;

%% Data
n = 10;
k1 = 3;
k2 = 4;
k3 = 10;


%% Sampling
% MCMC Parameters
nchains = 2; % How Many Chains?
nburnin = 10e2; % How Many Burn-in Samples?
nsamples = 10e4;  %How Many Recorded Samples?
nthin = 1; % How Often is a Sample Recorded?
doparallel = 0; % Parallel Option

% Assign Matlab Variables to the Observed Nodes
datastruct = struct('k1',k1,'k2',k2,'k3',k3,'n',n);

% Initialize Unobserved Variables
for i=1:nchains
    S.theta1 = 0.5; % Intial Value
    S.theta2 = 0.8; % Intial Value
    S.theta3 = 0.5; % Intial Value
    S.alpha = randi([1 3]); % Intial Value
    init0(i) = S;
end


% Use JAGS to Sample
tic
fprintf( 'Running JAGS ...\n' );
[samples, stats] = matjags( ...
    datastruct, ...
    fullfile(pwd, 'caso_1.txt'), ...
    init0, ...
    'doparallel' , doparallel, ...
    'nchains', nchains,...
    'nburnin', nburnin,...
    'nsamples', nsamples, ...
    'thin', nthin, ...
    'monitorparams', {'theta1','theta2','theta3', 'alpha'}, ...
    'savejagsoutput' , 1 , ...
    'verbosity' , 1 , ...
    'cleanup' , 0 , ...
    'workingdir' , 'tmpjags' );
toc

% %% Analysis
% figure(5);clf;
% set(gcf,'units','norm','pos',[.2 .2 .6 .4],'paperpositionmode','auto');

% % Parameter Space
x = linspace(0,3, length(samples.alpha(1,:)))
y = samples.alpha(1,:)

barplot(x, y)

% % Data Space
% subplot(122);hold on;
% axis equal;
% axis([-1 n1+1 -1 n2+1]);
% sc=70;
% for i=0:n1
%     for j=0:n2
%         match=length(find(samples.postpredk1==i&samples.postpredk2==j))/nsamples/nchains;
%         if match>0
%             ph=plot(i,j,'ks');
%         set(ph,'markersize',sc*sqrt(match));
%         end;
%     end;
% end;
% ph=plot(k1,k2,'kx');
% set(ph,'markersize',16,'linewidth',4);
% set(gca,'box','on','fontsize',14,'xtick',[0:n1],'ytick',[0:n2]);
% xlabel('Success Count 1','fontsize',16);
% ylabel('Success Count 2','fontsize',16);