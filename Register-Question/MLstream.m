
function ML_diff = MLstream(N, T, n)

% function to calculate the difference of M and L
% n: size of simulation sample (make it large: e.g.10m)

rng(121); % generated controled samples
numbers = randi(10,n,T); % inclusive [1,10]
numbers_in_des = sort(numbers,2, 'descend');
M_numbers = numbers_in_des(1:n,1:N);
L_numbers = numbers(1:n,end-N+1:end);
M = prod(M_numbers,2);
L = prod(L_numbers,2);
ML_diff = M - L;


