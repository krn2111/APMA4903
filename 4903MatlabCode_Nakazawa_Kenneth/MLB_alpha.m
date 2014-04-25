%MLB_alpha.m
%Rank Values vs Alpha
%Written by Kenny Nakazawa

%Ranking MLB, American League East Division Teams as of 4/22/14


a = 0:0.05:1;
TeamRank = zeros(length(a),5)';

for j = 1:length(a)
    
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
title('Rank Values vs Alpha (for 4/22/14)')
xlabel('Alpha (a)')
ylabel('Rank Values')
legend(teams)
legend('Location','eastoutside') 
line([a(18) a(18)],[0 0.3], 'Color','k', 'LineStyle',':');
set(gca,'YLim',[0 0.3], 'XTick',0:0.1:1)

