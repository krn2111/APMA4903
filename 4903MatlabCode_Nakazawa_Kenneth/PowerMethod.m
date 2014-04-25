%PowerMethod.m
%Written by Kenny Nakazawa

function [x,l]=PowerMethod(G,x0,N)
%Input: G=matrix, x0=initial vector guess, N=number of iterations
%Output: l=dominant eigenvalue, x=corresponding eigenvector
x = x0; 
 
for i = 1:N 
 xnext = G*x; 
 l = norm(xnext,inf)/norm(x,inf); 
 x = xnext; 
end 
 
x = x/norm(x); %normalize x 


