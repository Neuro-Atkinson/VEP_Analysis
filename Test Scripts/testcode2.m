% handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,1)=min(min(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormL(EventNum,AcuityWindowL(1,1):AcuityWindowL(1,2))));
% handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,1)=min(min(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormR(EventNum,AcuityWindowR(1,1):AcuityWindowR(1,2))));
% handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,2)=max(max(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormR(EventNum,AcuityWindowR(1,1):AcuityWindowR(1,2))));

filename_group1=fields(handles.MainStructure.GroupA);
filename_group2=fields(handles.MainStructure.GroupB);
filename_group3=fields(handles.MainStructure.GroupC);

delname1='EventWaveform_mean';
delname2='RecFreq';
delname3='AmpGain';

filename_group1(strcmp((delname1),filename_group1)) = [];
filename_group1(strcmp((delname2),filename_group1)) = [];
filename_group1(strcmp((delname3),filename_group1)) = [];

filename_group2(strcmp((delname1),filename_group2)) = [];
filename_group2(strcmp((delname2),filename_group2)) = [];
filename_group2(strcmp((delname3),filename_group2)) = [];

filename_group3(strcmp((delname1),filename_group3)) = [];
filename_group3(strcmp((delname2),filename_group3)) = [];
filename_group3(strcmp((delname3),filename_group3)) = [];

for testgroup=1:3
    
    GroupName=GroupNames{1,testgroup};
    if testgroup==1
        test=filename_group1;
    elseif testgroup ==2
        test=filename_group2;
    else
        test=filename_group3;
    end
    filelength=length(test);
    
    for filetest=1:filelength
    figure;
    
    
    for eventnum=1:8
%         subplot(8,2,((eventnum*2)-1));
        subplot(8,1,eventnum)

%         for marglar=1:400
%             plotdata(:,:)=handles.MainStructure.(GroupName).(test{filetest,1}).MergedWaveFormsL(eventnum,marglar,:);
%             hold on
%             plot(plotdata);
%             plotdata(:,:)=handles.MainStructure.(GroupName).(test{filetest,1}).MergedWaveFormsR(eventnum,marglar,:);
%             plotdata=plotdata-mean(plotdata(1:25,1));
%             plot(plotdata,'Color','r');
%         end
%         ylim([-2 2]);
%         subplot(8,2,(eventnum*2));
%         thetitle=sprintf('%s (cyc/deg)',AcuityCodes{1,eventnum});
%         title(thetitle);
%         hold on;
%         test1(:,:)=handles.MainStructure.(GroupName).(test{filetest,1}).MergedWaveFormsR(eventnum,:,:);
%         test2(:,:)=handles.MainStructure.(GroupName).(test{filetest,1}).MergedWaveFormsL(eventnum,:,:);
%         test3=[test1;test2];
%         for datapoint=1:495
%             mean_waveform(1,datapoint)=nanmean(test3(:,datapoint));
%         end
% 
%         clear test1 test2 test3
%         plot(mean_waveform,'Color','k','LineWidth',3)
%         [minamp,minloc]=min(mean_waveform(41:60));
%         [maxamp,maxloc]=max(mean_waveform(80:130));
%         line([minloc+41 minloc+41],[minamp-.025 minamp+0.025],'Color','g','LineWidth',3);
%         line([maxloc+80 maxloc+80],[maxamp-.025 maxamp+0.025],'Color','g','LineWidth',3);
        plot(handles.MainStructure.(GroupName).(test{filetest,1}).AveragedWaveFormL(eventnum,:))
        hold on;
        if eventnum==1
            title(test{filetest,1},'interpreter','none');
        end
        plot(handles.MainStructure.(GroupName).(test{filetest,1}).AveragedWaveFormR(eventnum,:),'Color','r')
%         clear mean_waveform
        ylim([-.2 .2])
    end
    end
    
end

figure;
maxchecker=0;
minchecker=0;
for grpplotter=1:totalgroups
    GroupName=GroupNames{1,grpplotter};
    for betaA=1:EventNum
        subplot(totalgroups,EventNum,(betaA+((grpplotter-1)*EventNum)))
        [testmax,maxloc]=max(handles.MainStructure.(GroupName).EventWaveform_mean(betaA,:));
        [testmin,minloc]=min(handles.MainStructure.(GroupName).EventWaveform_mean(betaA,:));
        if minchecker > testmin
            minchecker=testmin;
        end
        if maxchecker < testmax
            maxchecker=testmax;
        end
        plot(handles.MainStructure.(GroupName).EventWaveform_mean(betaA,:))
        hold on;
        
        line([],[],'Color','r')
        line([],[],'Color','r')
        
        line([],[],'Color','r')
        line([],[],'Color','r')
        
        if grpplotter==1
           thetitle=sprintf('%s (cyc/deg)',AcuityCodes{1,betaA});
           title(thetitle);
        end
        if betaA==1
            ytitle=sprintf('Group %s',num2str(grpplotter));
            ylabel(ytitle);
        end
        if grpplotter==totalgroups
            xtitle=sprintf('Time (ms)');
            xlabel(xtitle);
        end

    end
end
for grpplotter=1:totalgroups
   for betaA=1:EventNum
       subplot(totalgroups,EventNum,(betaA+((grpplotter-1)*EventNum)))
       ylim([minchecker maxchecker]);
   end
end