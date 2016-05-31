for zeta=1:120
grp1_trials_day5nov(zeta,:)=grp1(6,(1+((zeta-1)*100):(zeta*100)));
grp2_trials_day5nov(zeta,:)=grp2(6,(1+((zeta-1)*100):(zeta*100)));
end

for zeta=1:120
grp1_trials_day5fam(zeta,:)=grp1(5,(1+((zeta-1)*100):(zeta*100)));
grp2_trials_day5fam(zeta,:)=grp2(5,(1+((zeta-1)*100):(zeta*100)));
end

for zeta=1:120
grp1_trials_day1fam(zeta,:)=grp1(1,(1+((zeta-1)*100):(zeta*100)));
grp2_trials_day1fam(zeta,:)=grp2(1,(1+((zeta-1)*100):(zeta*100)));
end

%Run first
for zeta=1:120
[output,y]=cumplot(grp1_trials_day5nov(zeta,:));
chknan=length(output);
if chknan >= 100
    grp1_cumsum_day5nov(zeta,:)=output;
end
clear output
clear y

[output,y]=cumplot(grp2_trials_day5nov(zeta,:));
chknan=length(output);
if chknan >= 100
    grp2_cumsum_day5nov(zeta,:)=output;
end
clear output
clear y

[output,y]=cumplot(grp1_trials_day5fam(zeta,:));
chknan=length(output);
if chknan >= 100
    grp1_cumsum_day5fam(zeta,:)=output;
end
clear output
clear y

[output,y]=cumplot(grp2_trials_day5fam(zeta,:));
chknan=length(output);
if chknan >= 100
    grp2_cumsum_day5fam(zeta,:)=output;
end
clear output
clear y

[output,y]=cumplot(grp1_trials_day1fam(zeta,:));
chknan=length(output);
if chknan >= 100
    grp1_cumsum_day1fam(zeta,:)=output;
end
clear output
clear y

[output,y]=cumplot(grp2_trials_day1fam(zeta,:));
chknan=length(output);
if chknan >= 100
    grp2_cumsum_day1fam(zeta,:)=output;
end
clear output
clear y

end

%Run second
runlength=length(grp1_cumsum_day5nov);
for zeta=1:runlength
grp1_75th_day5nov(1,zeta)=prctile(grp1_cumsum_day5nov(zeta,:),75);
end

runlength=length(grp2_cumsum_day5nov);
for zeta=1:runlength
grp2_75th_day5nov(1,zeta)=prctile(grp2_cumsum_day5nov(zeta,:),75);
end

runlength=length(grp1_cumsum_day5fam);
for zeta=1:runlength
grp1_75th_day5fam(1,zeta)=prctile(grp1_cumsum_day5fam(zeta,:),75);
end

runlength=length(grp2_cumsum_day5fam);
for zeta=1:runlength
grp2_75th_day5fam(1,zeta)=prctile(grp2_cumsum_day5fam(zeta,:),75);
end

runlength=length(grp1_cumsum_day1fam);
for zeta=1:runlength
grp1_75th_day1fam(1,zeta)=prctile(grp1_cumsum_day1fam(zeta,:),75);
end

runlength=length(grp2_cumsum_day1fam);
for zeta=1:runlength
grp2_75th_day1fam(1,zeta)=prctile(grp2_cumsum_day5fam(zeta,:),75);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Run second
runlength=length(grp1_cumsum_day5nov);
for zeta=1:runlength
grp1_25th_day5nov(1,zeta)=prctile(grp1_cumsum_day5nov(zeta,:),25);
end

runlength=length(grp2_cumsum_day5nov);
for zeta=1:runlength
grp2_25th_day5nov(1,zeta)=prctile(grp2_cumsum_day5nov(zeta,:),25);
end

runlength=length(grp1_cumsum_day5fam);
for zeta=1:runlength
grp1_25th_day5fam(1,zeta)=prctile(grp1_cumsum_day5fam(zeta,:),25);
end

runlength=length(grp2_cumsum_day5fam);
for zeta=1:runlength
grp2_25th_day5fam(1,zeta)=prctile(grp2_cumsum_day5fam(zeta,:),25);
end

runlength=length(grp1_cumsum_day1fam);
for zeta=1:runlength
grp1_25th_day1fam(1,zeta)=prctile(grp1_cumsum_day1fam(zeta,:),25);
end

runlength=length(grp2_cumsum_day1fam);
for zeta=1:runlength
grp2_25th_day1fam(1,zeta)=prctile(grp2_cumsum_day5fam(zeta,:),25);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Run second
runlength=length(grp1_cumsum_day5nov);
for zeta=1:runlength
grp1_1st_day5nov(1,zeta)=prctile(grp1_cumsum_day5nov(zeta,:),1);
end

runlength=length(grp2_cumsum_day5nov);
for zeta=1:runlength
grp2_1st_day5nov(1,zeta)=prctile(grp2_cumsum_day5nov(zeta,:),1);
end

runlength=length(grp1_cumsum_day5fam);
for zeta=1:runlength
grp1_1st_day5fam(1,zeta)=prctile(grp1_cumsum_day5fam(zeta,:),1);
end

runlength=length(grp2_cumsum_day5fam);
for zeta=1:runlength
grp2_1st_day5fam(1,zeta)=prctile(grp2_cumsum_day5fam(zeta,:),1);
end

runlength=length(grp1_cumsum_day1fam);
for zeta=1:runlength
grp1_1st_day1fam(1,zeta)=prctile(grp1_cumsum_day1fam(zeta,:),1);
end

runlength=length(grp2_cumsum_day1fam);
for zeta=1:runlength
grp2_1st_day1fam(1,zeta)=prctile(grp2_cumsum_day5fam(zeta,:),1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot_data(1,1)=mean(grp1_75th_day1fam(1,:));
plot_data(1,2)=mean(grp1_25th_day1fam(1,:));
plot_data(1,3)=mean(grp1_1st_day1fam(1,:));

plot_data(1,4)=mean(grp2_75th_day1fam(1,:));
plot_data(1,5)=mean(grp2_25th_day1fam(1,:));
plot_data(1,6)=mean(grp2_1st_day1fam(1,:));

plot_data(1,7)=mean(grp1_75th_day5fam(1,:));
plot_data(1,8)=mean(grp1_25th_day5fam(1,:));
plot_data(1,9)=mean(grp1_1st_day5fam(1,:));

plot_data(1,10)=mean(grp2_75th_day5fam(1,:));
plot_data(1,11)=mean(grp2_25th_day5fam(1,:));
plot_data(1,12)=mean(grp2_1st_day5fam(1,:));

plot_data(1,13)=mean(grp1_75th_day5nov(1,:));
plot_data(1,14)=mean(grp1_25th_day5nov(1,:));
plot_data(1,15)=mean(grp1_1st_day5nov(1,:));

plot_data(1,16)=mean(grp2_75th_day5nov(1,:));
plot_data(1,17)=mean(grp2_25th_day5nov(1,:));
plot_data(1,18)=mean(grp2_1st_day5nov(1,:));

plot_data(2,1)=std(grp1_75th_day1fam(1,:))/sqrt(length(grp1_75th_day1fam(1,:)));
plot_data(2,2)=std(grp1_25th_day1fam(1,:))/sqrt(length(grp1_25th_day1fam(1,:)));
plot_data(2,3)=std(grp1_1st_day1fam(1,:))/sqrt(length(grp1_1st_day1fam(1,:)));

plot_data(2,4)=std(grp2_75th_day1fam(1,:))/sqrt(length(grp2_75th_day1fam(1,:)));
plot_data(2,5)=std(grp2_25th_day1fam(1,:))/sqrt(length(grp2_25th_day1fam(1,:)));
plot_data(2,6)=std(grp2_1st_day1fam(1,:))/sqrt(length(grp2_1st_day1fam(1,:)));

plot_data(2,7)=std(grp1_75th_day5fam(1,:))/sqrt(length(grp1_75th_day5fam(1,:)));
plot_data(2,8)=std(grp1_25th_day5fam(1,:))/sqrt(length(grp1_25th_day5fam(1,:)));
plot_data(2,9)=std(grp1_1st_day5fam(1,:))/sqrt(length(grp1_1st_day5fam(1,:)));

plot_data(2,10)=std(grp2_75th_day5fam(1,:))/sqrt(length(grp2_75th_day5fam(1,:)));
plot_data(2,11)=std(grp2_25th_day5fam(1,:))/sqrt(length(grp2_25th_day5fam(1,:)));
plot_data(2,12)=std(grp2_1st_day5fam(1,:))/sqrt(length(grp2_1st_day5fam(1,:)));

plot_data(2,13)=std(grp1_75th_day5nov(1,:))/sqrt(length(grp1_75th_day5nov(1,:)));
plot_data(2,14)=std(grp1_25th_day5nov(1,:))/sqrt(length(grp1_25th_day5nov(1,:)));
plot_data(2,15)=std(grp1_1st_day5nov(1,:))/sqrt(length(grp1_1st_day5nov(1,:)));

plot_data(2,16)=std(grp2_75th_day5nov(1,:))/sqrt(length(grp2_75th_day5nov(1,:)));
plot_data(2,17)=std(grp2_25th_day5nov(1,:))/sqrt(length(grp2_25th_day5nov(1,:)));
plot_data(2,18)=std(grp2_1st_day5nov(1,:))/sqrt(length(grp2_1st_day5nov(1,:)));
figure
barwitherr(plot_data(2,:),plot_data(1,:))



find(grp1_trials(zeta,:)==NaN)
isnan(grp1_trials(zeta,:))
isempty(ans)