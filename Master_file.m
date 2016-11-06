%file_name_train = input('Please mention the path to pick up clustering data');
%K = input('The desired number of clusters');
K = 3;
%eps = input('Tolerance of the data for EM');
eps = .0001;
%max_iter = input('maximum iterations for EM');
max_iter = 1000;
%load('C:\Users\sidds\OneDrive\Documents\MATLAB\Project\cifar-10-batches-mat\data_batch_1.mat');
load('fisheriris.mat');
T = meas;
Y = species;
X = im2double(T);
[theta] = EM(X, max_iter, K,eps,1);
[N,D] = size(X);
S = 1;
co_var_mat = {K};
mu = zeros(K,D);
prior = zeros(1,K);
for k = 1:K
   co_var_mat{k} = theta{S,1,k};
   mu(k,:) = theta{S,2,k};
   prior(1,k) = theta{S,3,k};
end
Probabilities = P_h_givn_x(X, K,prior, mu, co_var_mat);
 for i = 1:K
    c=flipud(unique(sort(Probabilities(:,i))));
    result=c(1:5); 
    ind=find(Probabilities(:,i)>=c(10));
    disp(ind);
 end    
 acc_clst = [];
 rej_clst = [];
 str = input('Do you want feedback Y/N','s');
 disp(class(str));
 if eq(str,'Y')
     for z = 1:K
         indice = input('accepted cluster number, press 0 when you are done');
         if indice == 0 break; end
         acc_clst = [acc_clst,indice];
     end
     for z = 1:K
         indice = input('rejected cluster number, press 0 when you are done');
         if indice == 0 break; end
         rej_clst = [rej_clst,indice];
     end
 end    
 [theta] = EM(X, max_iter, K,eps,2,theta, rej_clst, acc_clst);
 for k = 1:K
   co_var_mat{k} = theta{S,1,k};
   mu(k,:) = theta{S,2,k};
   prior(1,k) = theta{S,3,k};
end
Probabilities = P_h_givn_x(X, K,prior, mu, co_var_mat);
 for i = 1:K
    c=flipud(unique(sort(Probabilities(:,i))));
    result=c(1:5); 
    ind=find(Probabilities(:,i)>=c(10));
    disp(ind);
 end    
