%NFL3.m
%Example of Ranking NFL Teams (based on 2005 regular season)
%Written by Kenny Nakazawa

%a=0.85, v = [8/30 10/30 6/30 2/30 4/30] (different personalization vector)

N=5;

teams = {'Carolina', 'Pittsburgh', 'Chicago', 'Tampa Bay', 'New Orleans'}
H = [0 0 10/33 20/33 3/33;0 0 0 0 0; 0 1 0 0 0;10/13 0 3/13 0 0; 3/17 0 0 14/17 0]

%Initial ranking, equal importance to all
z0=zeros(N,1)';
for i=1:N
    z0(i)=1/N;
end
z0

%Make H stochastic, all entries in a row are non-negative
%and add to 1. Row of all 0s indicates an undefeated season.
S=H;
for i=1:length(S)
    if S(i,:) == zeros(length(S),1)'
        S(i,:) = ones(length(S),1)'*1./length(S);
    end
end

S

%Make S irreducible and create google matrix G
v = [8/30 10/30 6/30 2/30 4/30] %Personalization vector
e = ones(length(v),1)
E = e*v

a = 0.85 %"a" is the significance of the hyperlink structure of the 
%internet (represented by the matrix S) in the ranking process

G = a*S + (1-a)*E %make G stochastic and irreducible

%Use Perron-Frobenius Theorem to solve lim (k-->inf) z0*G^k
%(G')^k*z0 = dominant eigenvalue^k * c(1) * corresponding eigenvector 
%Recall z0 = v*c (z0 = c(1)v1 + c(2)v2+...+c(n)vn
%By PFT, the dominant eigenvector is 1.
%so (G')^k*z0 = c(1) * v1
[v l] = eig(G');
c = v\z0';
pi = c(1)*v(:,1);


disp('===================================================================');
teams=teams'
TeamRankValues = abs(pi)
[values team_ranking_high_to_low_index]=sort(TeamRankValues,'descend');

for i=1:length(team_ranking_high_to_low_index)
    Team_Rankings_Best_to_Worst{i}=teams{team_ranking_high_to_low_index(i)};
end

Team_Rankings_Best_to_Worst=Team_Rankings_Best_to_Worst'
disp('===================================================================');

%Plot Figure
x=1:5;
figure
bar(x,TeamRankValues)
set(gca, 'XTick',1:5, 'XTickLabel',{'Carolina', 'Pittsburgh', 'Chicago', 'Tampa Bay', 'New Orleans'})
ylabel('Rank Values')
title('NFL (based on 2005 regular season)')
