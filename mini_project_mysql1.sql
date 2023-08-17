use ipl;

select*from ipl_bidding_details;
select*from ipl_bidder_points;
select*from ipl_bidding_details ;
select*from ipl_team ;
select*from ipl_match ;
select*from ipl_match_schedule;
 select*from ipl_team_players ;
 select * from ipl_bidder_points;



#1.	Show the percentage of wins of each bidder in the order of highest to lowest percentage.

SELECT bidder_name,bd1.bidder_id,COUNT(*) AS Total_Bids,SUM(CASE WHEN bid_status='Won' THEN 1 ELSE 0 END) AS Wins,
  COUNT(*)-SUM(CASE WHEN bid_status='Won' THEN 1 ELSE 0 END) AS Losses_Bid,
  SUM(CASE WHEN bid_status='Won' THEN 1 ELSE 0 END)*100/COUNT(*) AS WinPercentage
FROM ipl_bidding_details bd1
join ipl_bidder_details bd
on bd1.BIDDER_ID = bd.BIDDER_ID
GROUP BY bidder_id order by WinPercentage desc ;


#2.	Display the number of matches conducted at each stadium with stadium name, city from the database.

select count(ims.match_id),ist.stadium_id,ist.STADIUM_NAME,ist.CITY from ipl_stadium ist
join ipl_match_schedule ims
on ist.stadium_id = ims.stadium_id
group by stadium_id,STADIUM_NAME,CITY;

#3.	In a given stadium, what is the percentage of wins by a team which has won the toss?

select stadium_name,SUM(CASE WHEN toss_winner=MATCH_WINNER THEN 1 ELSE 0 END)*100/COUNT(*) AS WonMatch_WonToss_Percentage
from ipl_match im 
join ipl_match_schedule ims
on im.MATCH_ID=ims.MATCH_ID
join ipl_stadium ist
on ims.STADIUM_ID=ist.STADIUM_ID group by STADIUM_NAME;

#4.	Show the total bids along with bid team and team name.

select * from ipl_bidder_details;
select * from ipl_bidding_details;
select * from ipl_team;

select bid_team,team_name, sum(no_of_bids) as total_bids
from ipl_bidder_points ibp
join ipl_bidding_details ibd
on ibp.BIDDER_ID = ibd.BIDDER_ID
join ipl_team it
on ibd.BID_TEAM=it.TEAM_ID group by TEAM_NAME;

#5.	Show the team id who won the match as per the win details.

select  case when match_winner =  1 then team_id1 else team_id2 end as team_id, win_details 
from ipl_match;

#6.	Display total matches played, total matches won and total matches lost by team along with its team name.

select it.team_name,its.matches_played as total_matches_played,its.matches_won,its.matches_lost from ipl_team_standings its
join ipl_team it
on its.TEAM_ID=it.TEAM_ID group by TEAM_NAME;

#7.	Display the bowlers for Mumbai Indians team.
select * from ipl_player ;
select * from ipl_team;
select * from ipl_team_players;
select player_name,team_name,player_role from ipl_player ip
join ipl_team_players itp
on ip.PLAYER_ID=itp.PLAYER_ID
join ipl_team it
on itp.TEAM_ID = it.TEAM_ID where it.TEAM_NAME like "%mumbai%" and player_role like "%bowler" ;


#8.	How many all-rounders are there in each team, Display the teams with more than 4  all-rounder in descending order.

select itp.team_id,team_name,count(player_role) as count_of_all_rounders from ipl_team_players itp
join ipl_team it
on itp.TEAM_ID=it.TEAM_ID
where player_role like "%all%" group by TEAM_ID having count(PLAYER_ROLE) >4 
order by count_of_all_rounders desc;



