%Google_alpha.m
%Rank Values vs Alpha
%Written by Kenny Nakazawa
%Based off directed graph in [Govan et al. 2008]


a = 0:0.05:1;
PageRank = zeros(length(a),5)';

for j = 1:length(a)
    
N=5;

H = [0 0 1/3 1/3 1/3;0 0 0 0 0; 0 1 0 0 0;1/2 0 1/2 0 0; 1/2 0 0 1/2 0];

%Initial ranking, equal importance to all
z0=zeros(N,1)';
for i=1:N
    z0(i)=1/N;
end
z0;

%Make H stochastic, all entries in a row are non-negative
%and add to 1. Fix dangling nodes, rows of H that are all 0.
S=H;
for i=1:length(S)
    if S(i,:) == zeros(length(S),1)'
        S(i,:) = ones(length(S),1)'*1./length(S);
    end
end

S;

%Make S irreducible and create google matrix G
v = [1/5 1/5 1/5 1/5 1/5]; %Personalization vector
e = ones(length(v),1);
E = e*v;


G = a(j)*S + (1-a(j))*E; %make G stochastic and irreducible

%Use Perron-Frobenius Theorem to solve lim (k-->inf) z0*G^k
%(G')^k*z0 = dominant eigenvalue^k * c(1) * corresponding eigenvector 
%Recall z0 = v*c (z0 = c(1)v1 + c(2)v2+...+c(n)vn
%By PFT, the dominant eigenvector is 1.
%so (G')^k*z0 = c(1) * v1
[v l] = eig(G');
c = v\z0';
pi = c(1)*v(:,1);


a(j);
PageRankValues = abs(pi);
PageRank(:,j)=PageRankValues';

end

a
PageRank

figure
plot(a,PageRank(1,:),a,PageRank(2,:),a, PageRank(3,:), a, PageRank(4,:), a, PageRank(5,:))
title('Rank Values vs Alpha')
xlabel('Alpha (a)')
ylabel('Rank Values')
legend('P1', 'P2', 'P3', 'P4', 'P5')
legend('Location','eastoutside') 
line([a(18) a(18)],[0 0.3], 'Color','k', 'LineStyle',':');
set(gca,'YLim',[0 0.3], 'XTick',0:0.1:1)

