%MLB_422.m
%Example of Ranking MLB, American League East Division Teams (as of 4/22/14)
%Written by Kenny Nakazawa
%Used actual game results

N=5;

teams = {'Baltimore', 'Boston', 'New York', 'Tampa Bay', 'Toronto'};
H = [0 8/28 4/28 0 16/28;6/19 0 13/19 0 0; 10/37 2/37 0 21/37 4/37;9/22 0 12/26 0 5/26; 1/19 0 6/19 12/19 0];

%Initial ranking, equal importance to all
z0=zeros(N,1)';
for i=1:N
    z0(i)=1/N;
end
z0;

%Make H stochastic, all entries in a row are non-negative
%and add to 1. Row of all 0s indicates an undefeated season.
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

a = 0.85; %"a" is the significance of the hyperlink structure of the 
%internet (represented by the matrix S) in the ranking process

G = a*S + (1-a)*E; %make G stochastic and irreducible

%Use Perron-Frobenius Theorem to solve lim (k-->inf) z0*G^k
%(G')^k*z0 = dominant eigenvalue^k * c(1) * corresponding eigenvector 
%Recall z0 = v*c (z0 = c(1)v1 + c(2)v2+...+c(n)vn
%By PFT, the dominant eigenvector is 1.
%so (G')^k*z0 = c(1) * v1
[v l] = eig(G');
c = v\z0';
pi = c(1)*v(:,1);

disp('===================================================================');
disp('As of 4/22/14');
teams=teams'
TeamRankValues_422 = abs(pi)
[values team_ranking_high_to_low_index]=sort(TeamRankValues_422,'descend');

for i=1:length(team_ranking_high_to_low_index)
    Team_Rankings_Best_to_Worst{i}=teams{team_ranking_high_to_low_index(i)};
end

Team_Rankings_Best_to_Worst=Team_Rankings_Best_to_Worst'
disp('===================================================================');

%Plot Figure
x=1:5;
figure
bar(x,TeamRankValues_422)
set(gca, 'XTick',1:5, 'XTickLabel',{'Baltimore', 'Boston', 'New York', 'Tampa Bay', 'Toronto'})
ylabel('Rank Values')
title('MLB, American League East Division (as of 4/22/14)')