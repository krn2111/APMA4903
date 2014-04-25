%test_PM.m
%Written by Kenny Nakazawa
%Test power method function on google matrix from Google.m

G= [0.0300    0.0300    0.3133    0.3133    0.3133
    0.2000    0.2000    0.2000    0.2000    0.2000
    0.0300    0.8800    0.0300    0.0300    0.0300
    0.4550    0.0300    0.4550    0.0300    0.0300
    0.4550    0.0300    0.0300    0.4550    0.0300];

v1=[.2 .2 .2 .2 .2]'; %initial guess
disp('Power Method');
[eigenvector,eigenvalue] = PowerMethod(G',v1,15)

disp('Eig()');
[v l] = eig(G');
eigenvector_EIG=abs(v(:,1))
eigenvector_EV=l(1)