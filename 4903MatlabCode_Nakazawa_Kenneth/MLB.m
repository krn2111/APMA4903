%MLB.m
%2014 MLB AL East, Rank Values for 4/15-4/22
%Written by Kenny Nakazawa
%Used actual game results

set(0,'DefaultFigureVisible','off') %turn off bar graphs in these m-files
MLB_415; %m-file
MLB_416; %m-file
MLB_417; %m-file
MLB_418; %m-file
MLB_419; %m-file
MLB_420; %m-file
MLB_421; %m-file
MLB_422; %m-file
set(0,'DefaultFigureVisible','on')

%Setting up my plot of rank values over time
%Put team rank values from each date in matrix. Then plot.
x=1:8;
Dates = {'4/15' '4/16' '4/17' '4/18' '4/19' '4/20' '4/21' '4/22'}
TeamRankValues_overtime= [TeamRankValues_415, TeamRankValues_416, TeamRankValues_417, TeamRankValues_418, TeamRankValues_419, TeamRankValues_420 TeamRankValues_421 TeamRankValues_422]


figure
plot(x,TeamRankValues_overtime(1,:),x,TeamRankValues_overtime(2,:),x, TeamRankValues_overtime(3,:), x, TeamRankValues_overtime(4,:), x, TeamRankValues_overtime(5,:))
set(gca, 'XTick',1:8, 'XTickLabel',{'4/15', '4/15', '4/17', '4/18', '4/19', '4/20', '4/21', '4/22'})
ylabel('Rank Values')
title('2014 MLB AL East, Rank Values for 4/15-4/22, (a=0.85)')
legend('Bal','Bos', 'NY', 'TB', 'TOR')
legend('Location','eastoutside') 
