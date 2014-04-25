%NFL_alpha2.m
%Rank Values vs Alpha
%Alternative adjustment for how we create stochastic matrix (don't penalize undefeated team)
%based on 2005 NFL regular season
%Written by Kenny Nakazawa


a = 0:0.05:1;
TeamRank = zeros(length(a),5)';

for j = 1:length(a)
    
N=5;

teams = {'Carolina', 'Pittsburgh', 'Chicago', 'Tampa Bay', 'New Orleans'};
H = [0 0 10/33 20/33 3/33;0 0 0 0 0; 0 1 0 0 0;10/13 0 3/13 0 0; 3/17 0 0 14/17 0];

%Initial ranking, equal importance to all
z0=zeros(N,1)';
for i=1:N
    z0(i)=1/N;
end
z0;

%Make H stochastic, all entries in a row are non-negative
%and add to 1. Adjust the zero row by putting a 1 on the diagonal. 
%This is interpreted as saying that the undefeated team votes only for 
%itself in the ?election.? 
S=H;
for i=1:length(S)
    if S(i,:) == zeros(length(S),1)'
        S(i,i) = 1;
    end
end
S;

%Make S irreducible and create google matrix G
v = [1/5 1/5 1/5 1/5 1/5]; %Personalization vector
e = ones(length(v),1);
E = e*v;

 %"a" is the significance of the hyperlink structure of the 
%internet (represented by the matrix S) in the ranking process

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
teams=teams';
TeamRankValues = abs(pi);
TeamRank(:,j)=TeamRankValues';

end

teams
a
TeamRank

figure
plot(a,TeamRank(1,:),a,TeamRank(2,:),a, TeamRank(3,:), a, TeamRank(4,:), a, TeamRank(5,:))
title('Rank Values vs Alpha')
xlabel('Alpha (a)')
ylabel('Rank Values')
legend(teams)
legend('Location','eastoutside') 
line([a(18) a(18)],[0 1], 'Color','k', 'LineStyle',':');
set(gca,'YLim',[0 1], 'XTick',0:0.1:1)

