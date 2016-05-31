%Load a mainstructure file and rename it Data.  This code only supports 5
%SRP Days at the moment.

groupnum=2;
srpdays=5;
SrpThresh=120;
WeekTwo = 0;
AmpGain=1000;
grpcolors=[0 0 1;1 0 0];

use_session_amps=1;

for group=1:groupnum
    
    if use_session_amps==0
        groupname=Data.GroupNames{1,group};
        [preAnimalNum ~]=size(Data.(groupname).EndPlotData);
        AnimalNum=(preAnimalNum-1)/srpdays;

        if srpdays==5
            grouptracker=ones(1,6);
        else
            grouptracker=ones(1,srpdays);
        end
        trueanimal=1;
        for animalloop=2:srpdays:preAnimalNum
            DayHolder=0;
            if srpdays < 5
                    while DayHolder<srpdays
                        groupdata(group,grouptracker(1,DayHolder+1),DayHolder+1)=Data.(groupname).EndPlotData{animalloop+DayHolder,2}; %LH Familiar Always
                        grouptracker(1,DayHolder+1)=grouptracker(1,DayHolder+1)+1;
                        groupdata(group,grouptracker(1,DayHolder+1),DayHolder+1)=Data.(groupname).EndPlotData{animalloop+DayHolder,3}; %RH Familiar Always
                        grouptracker(1,DayHolder+1)=grouptracker(1,DayHolder+1)+1;
                        DayHolder=DayHolder+1;
                    end
            end
            if srpdays == 5
                    while DayHolder<srpdays
                       if WeekTwo==1
                           if DayHolder==1
                                if RemoveLeft==1
                                    groupdata(group,grouptracker(1,6),srpdays+1)=NaN;
                                    grouptracker(1,6)=grouptracker(1,6)+1;
                                    groupdata(group,grouptracker(1,5),srpdays)=NaN;
                                    grouptracker(1,5)=grouptracker(1,5)+1;
                                else
                                    groupdata(group,grouptracker(1,6),srpdays+1)=Data.(groupname).EndPlotData{animalloop+DayHolder,4}; %LH Novel Always
                                    grouptracker(1,6)=grouptracker(1,6)+1;
                                    groupdata(group,grouptracker(1,5),srpdays)=Data.(groupname).EndPlotData{animalloop+DayHolder,2}; %LH Familiar Always
                                    grouptracker(1,5)=grouptracker(1,5)+1;
                                end
                                if RemoveRight==1
                                    groupdata(group,grouptracker(1,6),srpdays+1)=NaN;
                                    grouptracker(1,6)=grouptracker(1,6)+1;
                                    groupdata(group,grouptracker(1,5),srpdays)=NaN;
                                    grouptracker(1,5)=grouptracker(1,5)+1;
                                else
                                    groupdata(group,grouptracker(1,6),srpdays+1)=Data.(groupname).EndPlotData{animalloop+DayHolder,5}; %RH Novel Always
                                    grouptracker(1,6)=grouptracker(1,6)+1;
                                    groupdata(group,grouptracker(1,5),srpdays)=Data.(groupname).EndPlotData{animalloop+DayHolder,3}; %RH Familiar Always
                                    grouptracker(1,5)=grouptracker(1,5)+1;
                                end





                                DayHolder=DayHolder+1;
                           else
                               if DayHolder==0
                                    RemoveLeft=0;
                                    RemoveRight=0;
                                    %CHECK SRP ENDPLOT DAY 1 VALUE
                                    clear clearhemi
                                    %Determine the animal number change from
                                    %week1srp to week2srp since wee2srp files
                                    %are missing and thus are not in the same
                                    %order as week1srp.
                                    if group==1
                                       keynum=customkey_normoxic(1,trueanimal); 
                                    elseif group==2
                                       keynum=customkey_hypoxic(1,trueanimal);
                                    end
                                    %determine endplot location based on
                                    %week1srp animal number and endplot
                                    %structure. Works with 5 SRP days only.
                                    customloop=((keynum-1)*5)+2
                                    check_value=week1key.Cleaned_SRPData.(groupname).EndPlotData{customloop,2}; %LH Day 1 Binoc SRP Value
                                    if check_value < SrpThresh/AmpGain
                                        RemoveLeft=1;
                                    end
                                    check_value=week1key.Cleaned_SRPData.(groupname).EndPlotData{customloop,3}; %LH Day 1 Binoc SRP Value
                                    if check_value < SrpThresh/AmpGain
                                        RemoveRight=1;
                                    end

                                    if RemoveLeft==1
                                        groupdata(group,grouptracker(1,1),1)=NaN;
                                        grouptracker(1,1)=grouptracker(1,1)+1;
                                    else
                                        groupdata(group,grouptracker(1,1),1)=Data.(groupname).EndPlotData{animalloop+DayHolder,4}; %LH Novel Always
                                        grouptracker(1,1)=grouptracker(1,1)+1;
                                    end
                                    if RemoveRight==1
                                        groupdata(group,grouptracker(1,1),1)=NaN;
                                        grouptracker(1,1)=grouptracker(1,1)+1;
                                    else
                                        groupdata(group,grouptracker(1,1),1)=Data.(groupname).EndPlotData{animalloop+DayHolder,5}; %RH Novel Always
                                        grouptracker(1,1)=grouptracker(1,1)+1;
                                    end
                                    DayHolder=DayHolder+1;

                               else
                                    if RemoveLeft==1
                                        groupdata(group,grouptracker(1,DayHolder),DayHolder)=NaN;
                                        grouptracker(1,DayHolder)=grouptracker(1,DayHolder)+1;
                                    else
                                        groupdata(group,grouptracker(1,DayHolder),DayHolder)=Data.(groupname).EndPlotData{animalloop+DayHolder,2}; %LH Familiar Always
                                        grouptracker(1,DayHolder)=grouptracker(1,DayHolder)+1;
                                    end
                                    if RemoveRight==1
                                        groupdata(group,grouptracker(1,DayHolder),DayHolder)=NaN;
                                        grouptracker(1,DayHolder)=grouptracker(1,DayHolder)+1;
                                    else
                                        groupdata(group,grouptracker(1,DayHolder),DayHolder)=Data.(groupname).EndPlotData{animalloop+DayHolder,3}; %RH Familiar Always
                                        grouptracker(1,DayHolder)=grouptracker(1,DayHolder)+1;
                                    end
                                DayHolder=DayHolder+1;
                               end
                           end
                       else
                           if DayHolder==0
                                groupdata(group,grouptracker(1,6),srpdays+1)=Data.(groupname).EndPlotData{animalloop+DayHolder,4}; %LH Novel Always
                                grouptracker(1,6)=grouptracker(1,6)+1;
                                groupdata(group,grouptracker(1,6),srpdays+1)=Data.(groupname).EndPlotData{animalloop+DayHolder,5}; %RH Novel Always
                                grouptracker(1,6)=grouptracker(1,6)+1;

                                groupdata(group,grouptracker(1,5),srpdays)=Data.(groupname).EndPlotData{animalloop+DayHolder,2}; %LH Familiar Always
                                grouptracker(1,5)=grouptracker(1,5)+1;
                                groupdata(group,grouptracker(1,5),srpdays)=Data.(groupname).EndPlotData{animalloop+DayHolder,3}; %RH Familiar Always
                                grouptracker(1,5)=grouptracker(1,5)+1;
                                DayHolder=DayHolder+1;
                           else
                                groupdata(group,grouptracker(1,DayHolder),DayHolder)=Data.(groupname).EndPlotData{animalloop+DayHolder,2}; %LH Familiar Always
                                grouptracker(1,DayHolder)=grouptracker(1,DayHolder)+1;
                                groupdata(group,grouptracker(1,DayHolder),DayHolder)=Data.(groupname).EndPlotData{animalloop+DayHolder,3}; %RH Familiar Always
                                grouptracker(1,DayHolder)=grouptracker(1,DayHolder)+1;
                                DayHolder=DayHolder+1;
                           end
                       end
                    end
            end
            trueanimal=trueanimal+1;
        end

        [grpanimal,grpdata,grpdays]=size(groupdata);
        for i=1:grpanimal
            %Scan day 1 for values less than thresh
           delvals=find(groupdata(i,:,1)==0);
           for j=1:length(delvals)
               for k=1:6
                  groupdata(i,delvals(1,j),k)=NaN;
               end
           end
        end
        threshgroupdata=groupdata;
        [grpanimal,grpdata,grpdays]=size(groupdata);

        threshdays=grpdays;

        WorkingThresh=SrpThresh/1000;
        for i=1:grpanimal
            %Scan day 1 for values less than thresh
           delvals=find(groupdata(i,:,1)<WorkingThresh);
           for j=1:length(delvals)
               for k=1:threshdays
                   %eliminate those hemispheres across all days that fell
                   %below threshold.
                  threshgroupdata(i,delvals(1,j),k)=NaN;
               end
           end
        end

        if group==groupnum
            for i=1:grpanimal
                [~,totalhemis,~]=size(groupdata(i,:,1));
                grouphemitracker(1,i)=0;
                groupanimaltracker(1,i)=0;
                for hemichecker=1:2:totalhemis
                    if ~isnan(threshgroupdata(i,hemichecker,1))
                        grouphemitracker(1,i)=grouphemitracker(1,i)+1;
                    end
                    if ~isnan(threshgroupdata(i,hemichecker+1,1))
                        grouphemitracker(1,i)=grouphemitracker(1,i)+1;
                    end
                    if ~isnan(threshgroupdata(i,hemichecker,1)) || ~isnan(threshgroupdata(i,hemichecker+1,1))
                        groupanimaltracker(1,i)=groupanimaltracker(1,i)+1;
                    end
                end
            end
        end

        grpnumsanimal(1,group)=AnimalNum;
        for i=1:grpanimal
         for j=1:grpdays
                  grpplot(i,j)=nanmean(threshgroupdata(i,:,j)*AmpGain);
                  grperror(i,j)=nanstd(threshgroupdata(i,:,j)*AmpGain)/sqrt(length(find(~isnan(threshgroupdata(i,:,j)))));
         end
         if group==i
             if exist('grphemis')==1 %Calculates number of group hemispheres
                 if length(grphemis) < group
                     grphemis(1,group)=length(find(~isnan(threshgroupdata(i,:,1))));
                 else
                     grphemis(1,group)=grphemis(1,group)+length(find(~isnan(threshgroupdata(i,:,1))));
                 end
             else
                 grphemis(1,group)=length(find(~isnan(threshgroupdata(i,:,1))));
             end
         end
        end

        if group==groupnum
        finalsrpfig=figure;
        hold on
        VepEventSymbols={'s','o','d','p','h'};

        for i=1:grpanimal
           if grpdays==6
                  errorbar(grpplot(i,1:5),grperror(i,1:5),VepEventSymbols{1,grpanimal},'MarkerSize',14,'Color',grpcolors(i,:));
                  novel=nan(1,5);
                  novelerr=nan(1,5);
                  novel(1,5)=grpplot(i,6);
                  novelerr(1,5)=grperror(i,6);
                  errorbar(novel,novelerr,VepEventSymbols{1,grpanimal},'MarkerSize',14,'MarkerFaceColor',grpcolors(i,:),'MarkerEdgeColor',grpcolors(i,:),'Color',grpcolors(i,:));
           else
                  errorbar(grpplot(i,:),grperror(i,:),VepEventSymbols{1,grpanimal},'MarkerSize',14,'Color',grpcolors(i,:));
           end
        end
        GroupNames=Data.GroupNames;
        if grpdays==6
            for i=1:grpanimal
                if i==1
                   legendInfo{1,1}=sprintf('%s Familiar',GroupNames{1,1});
                   legtxtnov=sprintf('%s Novel',GroupNames{1,1});
                   legendInfo=[legendInfo legtxtnov];
                else
                   legtxt=sprintf('%s Familiar',GroupNames{1,i});
                   legnovtxt=sprintf('%s Novel',GroupNames{1,i});
                   legendInfo=[legendInfo legtxt legnovtxt]; 
                end
            end
            legend(legendInfo,'Location','NorthWest');
        else
            for i=1:grpanimal
               if i==1
                   legendInfo{1,1}=sprintf('%s Familiar',GroupNames{1,1});
               else
                   legtxt=sprintf('%s Familiar',GroupNames{1,i});
                   legendInfo=[legendInfo legtxt];
               end
            end
            legend(legendInfo,'Location','NorthWest'); 
        end
        ylabel('Vep Amplitude (microVolts)');
        if grpdays==6
        xticks=linspace(1,grpdays-1,grpdays-1);
        else
        xticks=linspace(1,grpdays,grpdays);
        end
        set(gca,'XTick',xticks)
        xtitle=sprintf('Recording Days\nVep Threshold: %s microVolts\nAnimalsGrp1:%s\nAnimalsGrp2:%s\nHemisGrp1:%s\nHemisGrp2:%s',num2str(SrpThresh),num2str(groupanimaltracker(1,1)),num2str(groupanimaltracker(1,2)),num2str(grouphemitracker(1,1)),num2str(grouphemitracker(1,2)));
        xlabel(xtitle);
        title('SRP using Total Average Waveform');

        end
    
    else
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        groupname=Data.GroupNames{1,group};
        [preAnimalNum ~]=size(Data.(groupname).EndPlotData);
        AnimalNum=(preAnimalNum-1)/srpdays;

        if srpdays==5
            grouptracker=ones(1,6);
        else
            grouptracker=ones(1,srpdays);
        end
        trueanimal=1;
        for animalloop=2:srpdays:preAnimalNum
            DayHolder=0;
%             if srpdays < 5
%                     while DayHolder<srpdays
%                         clear tempsessLH tempsessRH
%                         %EndPlotData_SessionAmps
%                         Data.(groupname).EndPlotData{animalloop+DayHolder,2}; %LH Familiar Always
%                         Data.(groupname).EndPlotData{animalloop+DayHolder,3}; %RH Familiar Always
%                         
%                         
%                         groupdata(group,grouptracker(1,DayHolder+1),DayHolder+1)=Data.(groupname).EndPlotData{animalloop+DayHolder,2}; %LH Familiar Always
%                         grouptracker(1,DayHolder+1)=grouptracker(1,DayHolder+1)+1;
%                         groupdata(group,grouptracker(1,DayHolder+1),DayHolder+1)=Data.(groupname).EndPlotData{animalloop+DayHolder,3}; %RH Familiar Always
%                         grouptracker(1,DayHolder+1)=grouptracker(1,DayHolder+1)+1;
%                         DayHolder=DayHolder+1;
%                     end
%             end
            if srpdays == 5
                    while DayHolder<srpdays
                       if WeekTwo==1
                        %%
%                            if DayHolder==1
%                                 if RemoveLeft==1
%                                     groupdata(group,grouptracker(1,6),srpdays+1)=NaN;
%                                     grouptracker(1,6)=grouptracker(1,6)+1;
%                                     groupdata(group,grouptracker(1,5),srpdays)=NaN;
%                                     grouptracker(1,5)=grouptracker(1,5)+1;
%                                 else
%                                     groupdata(group,grouptracker(1,6),srpdays+1)=Data.(groupname).EndPlotData{animalloop+DayHolder,4}; %LH Novel Always
%                                     grouptracker(1,6)=grouptracker(1,6)+1;
%                                     groupdata(group,grouptracker(1,5),srpdays)=Data.(groupname).EndPlotData{animalloop+DayHolder,2}; %LH Familiar Always
%                                     grouptracker(1,5)=grouptracker(1,5)+1;
%                                 end
%                                 if RemoveRight==1
%                                     groupdata(group,grouptracker(1,6),srpdays+1)=NaN;
%                                     grouptracker(1,6)=grouptracker(1,6)+1;
%                                     groupdata(group,grouptracker(1,5),srpdays)=NaN;
%                                     grouptracker(1,5)=grouptracker(1,5)+1;
%                                 else
%                                     groupdata(group,grouptracker(1,6),srpdays+1)=Data.(groupname).EndPlotData{animalloop+DayHolder,5}; %RH Novel Always
%                                     grouptracker(1,6)=grouptracker(1,6)+1;
%                                     groupdata(group,grouptracker(1,5),srpdays)=Data.(groupname).EndPlotData{animalloop+DayHolder,3}; %RH Familiar Always
%                                     grouptracker(1,5)=grouptracker(1,5)+1;
%                                 end
% 
% 
% 
% 
% 
%                                 DayHolder=DayHolder+1;
%                            else
%                                if DayHolder==0
%                                     RemoveLeft=0;
%                                     RemoveRight=0;
%                                     %CHECK SRP ENDPLOT DAY 1 VALUE
%                                     clear clearhemi
%                                     %Determine the animal number change from
%                                     %week1srp to week2srp since wee2srp files
%                                     %are missing and thus are not in the same
%                                     %order as week1srp.
%                                     if group==1
%                                        keynum=customkey_normoxic(1,trueanimal); 
%                                     elseif group==2
%                                        keynum=customkey_hypoxic(1,trueanimal);
%                                     end
%                                     %determine endplot location based on
%                                     %week1srp animal number and endplot
%                                     %structure. Works with 5 SRP days only.
%                                     customloop=((keynum-1)*5)+2
%                                     check_value=week1key.Cleaned_SRPData.(groupname).EndPlotData{customloop,2}; %LH Day 1 Binoc SRP Value
%                                     if check_value < SrpThresh/AmpGain
%                                         RemoveLeft=1;
%                                     end
%                                     check_value=week1key.Cleaned_SRPData.(groupname).EndPlotData{customloop,3}; %LH Day 1 Binoc SRP Value
%                                     if check_value < SrpThresh/AmpGain
%                                         RemoveRight=1;
%                                     end
% 
%                                     if RemoveLeft==1
%                                         groupdata(group,grouptracker(1,1),1)=NaN;
%                                         grouptracker(1,1)=grouptracker(1,1)+1;
%                                     else
%                                         groupdata(group,grouptracker(1,1),1)=Data.(groupname).EndPlotData{animalloop+DayHolder,4}; %LH Novel Always
%                                         grouptracker(1,1)=grouptracker(1,1)+1;
%                                     end
%                                     if RemoveRight==1
%                                         groupdata(group,grouptracker(1,1),1)=NaN;
%                                         grouptracker(1,1)=grouptracker(1,1)+1;
%                                     else
%                                         groupdata(group,grouptracker(1,1),1)=Data.(groupname).EndPlotData{animalloop+DayHolder,5}; %RH Novel Always
%                                         grouptracker(1,1)=grouptracker(1,1)+1;
%                                     end
%                                     DayHolder=DayHolder+1;
% 
%                                else
%                                     if RemoveLeft==1
%                                         groupdata(group,grouptracker(1,DayHolder),DayHolder)=NaN;
%                                         grouptracker(1,DayHolder)=grouptracker(1,DayHolder)+1;
%                                     else
%                                         groupdata(group,grouptracker(1,DayHolder),DayHolder)=Data.(groupname).EndPlotData{animalloop+DayHolder,2}; %LH Familiar Always
%                                         grouptracker(1,DayHolder)=grouptracker(1,DayHolder)+1;
%                                     end
%                                     if RemoveRight==1
%                                         groupdata(group,grouptracker(1,DayHolder),DayHolder)=NaN;
%                                         grouptracker(1,DayHolder)=grouptracker(1,DayHolder)+1;
%                                     else
%                                         groupdata(group,grouptracker(1,DayHolder),DayHolder)=Data.(groupname).EndPlotData{animalloop+DayHolder,3}; %RH Familiar Always
%                                         grouptracker(1,DayHolder)=grouptracker(1,DayHolder)+1;
%                                     end
%                                 DayHolder=DayHolder+1;
%                                end
%                            end

                       else
                           if DayHolder==0
                          clear tempsessLH tempsessRH tempsessLH_NOV tempsessRH_NOV
                                %EndPlotData_SessionAmps
                                for LH_sess_amp = 2:2:11
       
                                    if LH_sess_amp==2
                                        tempsessLH(1,1) = Data.(groupname).EndPlotData_SessionAmps{animalloop+DayHolder,LH_sess_amp}; %LH Familiar
                                    else

                                        tempsessLH(1,(end+1)) = Data.(groupname).EndPlotData_SessionAmps{animalloop+DayHolder,LH_sess_amp}; %LH Familiar
                                    end
                                end
                                
                                for RH_sess_amp = 3:2:11
        
                                    if RH_sess_amp==3
                                        tempsessRH(1,1) = Data.(groupname).EndPlotData_SessionAmps{animalloop+DayHolder,RH_sess_amp}; %RH Familiar
                                    else

                                        tempsessRH(1,(end+1)) = Data.(groupname).EndPlotData_SessionAmps{animalloop+DayHolder,RH_sess_amp}; %RH Familiar
                                    end
                                end
                                
                                
                               for LH_sess_amp_NOV = 12:2:21
       
                                    if LH_sess_amp_NOV==12
                                        tempsessLH_NOV(1,1) = Data.(groupname).EndPlotData_SessionAmps{animalloop+DayHolder,LH_sess_amp_NOV}; %LH Novel
                                    else

                                        tempsessLH_NOV(1,(end+1)) = Data.(groupname).EndPlotData_SessionAmps{animalloop+DayHolder,LH_sess_amp_NOV}; %LH Novel
                                    end
                                end
                                
                                for RH_sess_amp_NOV = 13:2:21
        
                                    if RH_sess_amp_NOV==13
                                        tempsessRH_NOV(1,1) = Data.(groupname).EndPlotData_SessionAmps{animalloop+DayHolder,RH_sess_amp_NOV}; %RH Novel
                                    else

                                        tempsessRH_NOV(1,(end+1)) = Data.(groupname).EndPlotData_SessionAmps{animalloop+DayHolder,RH_sess_amp_NOV}; %RH Novel
                                    end
                                end
                                
                                %2:2:11 LH
                                %1:2:11 RH
                                
                                groupdata(group,grouptracker(1,6),srpdays+1)=mean(tempsessLH_NOV); %LH Novel Always
                                grouptracker(1,6)=grouptracker(1,6)+1;
                                groupdata(group,grouptracker(1,6),srpdays+1)=mean(tempsessRH_NOV); %RH Novel Always
                                grouptracker(1,6)=grouptracker(1,6)+1;

                                groupdata(group,grouptracker(1,5),srpdays)=mean(tempsessLH); %LH Familiar Always
                                grouptracker(1,5)=grouptracker(1,5)+1;
                                groupdata(group,grouptracker(1,5),srpdays)=mean(tempsessRH); %RH Familiar Always
                                grouptracker(1,5)=grouptracker(1,5)+1;
                                DayHolder=DayHolder+1;
                           else
                                clear tempsessLH tempsessRH tempsessLH_NOV tempsessRH_NOV
                                %EndPlotData_SessionAmps
                                for LH_sess_amp = 2:2:11
       
                                    if LH_sess_amp==2
                                        tempsessLH(1,1) = Data.(groupname).EndPlotData_SessionAmps{animalloop+DayHolder,LH_sess_amp}; %LH Familiar
                                    else

                                        tempsessLH(1,(end+1)) = Data.(groupname).EndPlotData_SessionAmps{animalloop+DayHolder,LH_sess_amp}; %LH Familiar
                                    end
                                end
                                
                                for RH_sess_amp = 3:2:11
        
                                    if RH_sess_amp==3
                                        tempsessRH(1,1) = Data.(groupname).EndPlotData_SessionAmps{animalloop+DayHolder,RH_sess_amp}; %RH Familiar
                                    else

                                        tempsessRH(1,(end+1)) = Data.(groupname).EndPlotData_SessionAmps{animalloop+DayHolder,RH_sess_amp}; %RH Familiar
                                    end
                                end
                                
                                groupdata(group,grouptracker(1,DayHolder),DayHolder)=mean(tempsessLH);%LH Familiar Always
                                grouptracker(1,DayHolder)=grouptracker(1,DayHolder)+1;
                                groupdata(group,grouptracker(1,DayHolder),DayHolder)=mean(tempsessRH); %RH Familiar Always
                                grouptracker(1,DayHolder)=grouptracker(1,DayHolder)+1;
                                DayHolder=DayHolder+1;
                           end
                       end
                    end
            end
            trueanimal=trueanimal+1;
        end

        [grpanimal,grpdata,grpdays]=size(groupdata);
        for i=1:grpanimal
            %Scan day 1 for values less than thresh
           delvals=find(groupdata(i,:,1)==0);
           for j=1:length(delvals)
               for k=1:6
                  groupdata(i,delvals(1,j),k)=NaN;
               end
           end
        end
        threshgroupdata=groupdata;
        [grpanimal,grpdata,grpdays]=size(groupdata);

        threshdays=grpdays;

        WorkingThresh=SrpThresh/1000;
        for i=1:grpanimal
            %Scan day 1 for values less than thresh
           delvals=find(groupdata(i,:,1)<WorkingThresh);
           for j=1:length(delvals)
               for k=1:threshdays
                   %eliminate those hemispheres across all days that fell
                   %below threshold.
                  threshgroupdata(i,delvals(1,j),k)=NaN;
               end
           end
        end

        if group==groupnum
            for i=1:grpanimal
                [~,totalhemis,~]=size(groupdata(i,:,1));
                grouphemitracker(1,i)=0;
                groupanimaltracker(1,i)=0;
                for hemichecker=1:2:totalhemis
                    if ~isnan(threshgroupdata(i,hemichecker,1))
                        grouphemitracker(1,i)=grouphemitracker(1,i)+1;
                    end
                    if ~isnan(threshgroupdata(i,hemichecker+1,1))
                        grouphemitracker(1,i)=grouphemitracker(1,i)+1;
                    end
                    if ~isnan(threshgroupdata(i,hemichecker,1)) || ~isnan(threshgroupdata(i,hemichecker+1,1))
                        groupanimaltracker(1,i)=groupanimaltracker(1,i)+1;
                    end
                end
            end
        end

        grpnumsanimal(1,group)=AnimalNum;
        for i=1:grpanimal
         for j=1:grpdays
                  grpplot(i,j)=nanmean(threshgroupdata(i,:,j)*AmpGain);
                  grperror(i,j)=nanstd(threshgroupdata(i,:,j)*AmpGain)/sqrt(length(find(~isnan(threshgroupdata(i,:,j)))));
         end
         if group==i
             if exist('grphemis')==1 %Calculates number of group hemispheres
                 if length(grphemis) < group
                     grphemis(1,group)=length(find(~isnan(threshgroupdata(i,:,1))));
                 else
                     grphemis(1,group)=grphemis(1,group)+length(find(~isnan(threshgroupdata(i,:,1))));
                 end
             else
                 grphemis(1,group)=length(find(~isnan(threshgroupdata(i,:,1))));
             end
         end
        end

        if group==groupnum
        finalsrpfig=figure;
        hold on
        VepEventSymbols={'s','o','d','p','h'};

        for i=1:grpanimal
           if grpdays==6
                  errorbar(grpplot(i,1:5),grperror(i,1:5),VepEventSymbols{1,grpanimal},'MarkerSize',14,'Color',grpcolors(i,:));
                  novel=nan(1,5);
                  novelerr=nan(1,5);
                  novel(1,5)=grpplot(i,6);
                  novelerr(1,5)=grperror(i,6);
                  errorbar(novel,novelerr,VepEventSymbols{1,grpanimal},'MarkerSize',14,'MarkerFaceColor',grpcolors(i,:),'MarkerEdgeColor',grpcolors(i,:),'Color',grpcolors(i,:));
           else
                  errorbar(grpplot(i,:),grperror(i,:),VepEventSymbols{1,grpanimal},'MarkerSize',14,'Color',grpcolors(i,:));
           end
        end
        GroupNames=Data.GroupNames;
        if grpdays==6
            for i=1:grpanimal
                if i==1
                   legendInfo{1,1}=sprintf('%s Familiar',GroupNames{1,1});
                   legtxtnov=sprintf('%s Novel',GroupNames{1,1});
                   legendInfo=[legendInfo legtxtnov];
                else
                   legtxt=sprintf('%s Familiar',GroupNames{1,i});
                   legnovtxt=sprintf('%s Novel',GroupNames{1,i});
                   legendInfo=[legendInfo legtxt legnovtxt]; 
                end
            end
            legend(legendInfo,'Location','NorthWest');
        else
            for i=1:grpanimal
               if i==1
                   legendInfo{1,1}=sprintf('%s Familiar',GroupNames{1,1});
               else
                   legtxt=sprintf('%s Familiar',GroupNames{1,i});
                   legendInfo=[legendInfo legtxt];
               end
            end
            legend(legendInfo,'Location','NorthWest'); 
        end
        ylabel('Vep Amplitude (microVolts)');
        if grpdays==6
        xticks=linspace(1,grpdays-1,grpdays-1);
        else
        xticks=linspace(1,grpdays,grpdays);
        end
        set(gca,'XTick',xticks)
        xtitle=sprintf('Recording Days\nVep Threshold: %s microVolts\nAnimalsGrp1:%s\nAnimalsGrp2:%s\nHemisGrp1:%s\nHemisGrp2:%s',num2str(SrpThresh),num2str(groupanimaltracker(1,1)),num2str(groupanimaltracker(1,2)),num2str(grouphemitracker(1,1)),num2str(grouphemitracker(1,2)));
        xlabel(xtitle);
        title('SRP using Session Average Waveform');

        end
    
        
    end
end