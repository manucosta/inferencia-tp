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
    S.theta2 = 0.5; % Intial Value
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

% Distribucion de las 4 variables a predecir

% alpha
[a,b] = hist([samples.alpha(1,:),samples.alpha(2,:)],unique(samples.alpha))
uno = a(1)/(a(1)+a(2)+a(3))
%media_alpha = stats.mean.alpha
%desvioStandard_alpha = stats.std.alpha
% theta1
%histfit([samples.theta1(1,:),samples.theta1(2,:)])
%media_t1 = stats.mean.theta1
%desvioStandard_t1 = stats.std.theta1

% theta2
%histfit([samples.theta2(1,:),samples.theta2(2,:)])
%media_t2 = stats.mean.theta2
%desvioStandard_t2 = stats.std.theta2

% theta3
%histfit([samples.theta3(1,:),samples.theta3(2,:)])
%media_t3 = stats.mean.theta3
%desvioStandard_t3 = stats.std.theta3

% correlacion
%theta1 = [samples.theta1(1,:),samples.theta1(2,:)]
%theta3 = [samples.theta3(1,:),samples.theta3(2,:)]
%figure
%scatterhist(theta1,theta3)
