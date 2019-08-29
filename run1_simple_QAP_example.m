%---------------------------------------------------------------
%script_simple_QAP_example 
%INPUT
% �XXX TODO XXX
%---------------------------------------------------------------
clear all;
% min  [X]^T W [X]
% s.t.  X is permutation
n = 40;
Ent = 1;
%generate a premutation matrix
X = zeros(n);
idx = randperm(n);
for i = 1:n
    X(i,idx(i)) = 1;
end
figure(2); imagesc(X);
% W = rand(n^2, n^2);
A = rand(n,n); A = 0.5*(A + A'); 
noiseM = 0.1*(rand(n)*2-1); noiseM = 0.5*(noiseM + noiseM'); 
B = X*A*X' + noiseM;
W = -kron(A,B);


%---------------------------------------------------------------
% run experiments
%---------------------------------------------------------------
PMD_params.stop_critiria = 10^-3;%stopping critiria for outer iterations (PMD)
PMD_params.stop_critiria_sinkhorn = 10^-2;%stopping critiria for iner iterations (lifted sinkhorn)
PMD_params.entropy =1;%1
PMD_params.Z = zeros(n);%linear energy term
PMD_params.W = W;       %quadratic energy term
PMD_params.A = A;
PMD_params.B = B;
PMD_params.type = 'permutation'; %labelling
PMD_params.n = n; %the dimensions of unknown X
PMD_params.m = n;
PMD_params.max_iterations = 1000;
PMD_params.sparse = false;
PMD_params.Adj = [];
PMD_params.graphics = true;


[ O_params ] = PMD_sinkhorn( PMD_params );

disp(O_params.no_iterations)

