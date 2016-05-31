%Select Files In Group (only process one group at a time)
files = char([]);
[fname,pathname] = uigetfile('*.mat','Select binary data files','MultiSelect','on');
z=1;
TotalChans=8;
combofilename=sprintf('%s%s',pathname,fname{1,z});
    fileID = fopen(combofilename);
    A = fread(fileID,inf,'float');
    filelength=length(A);
    clear A;
    Data = multibandread(combofilename, [1 (filelength/TotalChans) TotalChans], 'float', 0, 'bip', 'ieee-le' );
    fclose(fileID);


% clear F y f t pbase
% [y,f,t,pbase] = spectrogram(Data(1,300044:347043,1),300,[],1:1:500,1000);
% powervalues=10*log10(abs(pbase));
% for i = 1:312
% sumpow(1,i)=sum((powervalues(200:500,i)));
% end



LH_tracker=1;
RH_tracker=1;
daytrack=1;
filenum=1;
noveltracker=1;
nextfileisnovel=1;
%For each file in the group
for z=1:5:length(fname)
if nextfileisnovel==1
    daytrack=1;
else
    daytrack=0;
end
if rem(z,5)==0
    nextfileisnovel=1;
else
    nextfileisnovel=0;
end
    %Load the data from a specific file in the list
    combofilename=sprintf('%s%s',pathname,fname{1,z});
    load(combofilename,'DataStructure');
    Temp_LFP_LH=DataStructure.LFP_LH;
    Temp_LFP_RH=DataStructure.LFP_RH;
    clear DataStructure
    [~,sessionnum]=size(Temp_LFP_LH{1,3});
    
    for session = 1:sessionnum
%          figure('units','normalized','outerposition',[0 0 1 1])
%          subplot(3,1,1)
        [yLH,fLH,tLH,pbaseLH] = spectrogram(Temp_LFP_LH{1,3}(:,session),250,[],1:1:500,1000);
        pbaseLH_log=10*log10(abs(pbaseLH));
%          surf(tLH,fLH,pbaseLH_log_novel,'EdgeColor','none');
%          axis xy; axis tight; colormap(jet); view(0,90);
%          xlabel('Time');
%          ylabel('Frequency (Hz)');
%          subplot(3,1,2)
%          plot(Temp_LFP_LH{1,3}(:,session)); 
%          set(gca,'XTickLabel',[]);
%          xlen=length(Temp_LFP_LH{1,3}(:,session));
%          xlim([1 xlen])
        
        [yRH,fRH,tRH,pbaseRH] = spectrogram(Temp_LFP_RH{1,3}(:,session),250,[],1:1:500,1000);
        pbaseRH_log=10*log10(abs(pbaseRH));
        
        if daytrack==1
            [yLH,fLH,tLH,pbaseLH] = spectrogram(Temp_LFP_LH{1,6}(:,session),250,[],1:1:500,1000);
            pbaseLH_log_novel=10*log10(abs(pbaseLH));
            
            [yRH,fRH,tRH,pbaseRH] = spectrogram(Temp_LFP_RH{1,6}(:,session),250,[],1:1:500,1000);
            pbaseRH_log_novel=10*log10(abs(pbaseRH));
        end

        [~,freqrange]=size(pbaseLH_log);
               
        for freq=1:freqrange
            sumpow_LH(1,freq)=sum((pbaseLH_log(250:500,freq)));
            
            sumpow_RH(1,freq)=sum((pbaseRH_log(250:500,freq)));
            
            if daytrack==1
                sumpow_LH_novel(1,freq)=sum((pbaseLH_log_novel(250:500,freq)));
                sumpow_RH_novel(1,freq)=sum((pbaseRH_log_novel(250:500,freq)));
            end
            
        end
        
        %%%Start Added Code
        if vettedbackup_normoxic{z,session*2} >= 1
            if vettedbackup_normoxic{z,session*2} == 1
                sumpow_LH_mean=nanmean(sumpow_LH);
                sumpow_LH_zeromean=sumpow_LH-sumpow_LH_mean;
            else
                sumpow_LH_mean=nanmean(sumpow_LH);
                sumpow_LH_zeromean=sumpow_LH-sumpow_LH_mean;
                sumpow_LH_zeromean=sumpow_LH_zeromean*-1;
            end
        
        else
            sumpow_LH_zeromean=nan(1,length(sumpow_LH));
        end
        
        
        if vettedbackup_normoxic{z,session*2+1} >= 1
            if vettedbackup_normoxic{z,session*2+1} == 1
                sumpow_RH_mean=nanmean(sumpow_RH);
                sumpow_RH_zeromean=sumpow_RH-sumpow_RH_mean;
            else
                sumpow_RH_mean=nanmean(sumpow_RH);
                sumpow_RH_zeromean=sumpow_RH-sumpow_RH_mean;
                sumpow_RH_zeromean=sumpow_RH_zeromean*-1;
            end
        
        else
            sumpow_RH_zeromean=nan(1,length(sumpow_RH));
        end
        
        
        if daytrack==1
            
            %%%Start Added Code
            if vettedbackup_novel_normoxic{z,session*2} >= 1
                if vettedbackup_novel_normoxic{z,session*2} == 1
                    sumpow_LH_novel_mean=nanmean(sumpow_LH_novel);
                    sumpow_LH_novel_zeromean=sumpow_LH_novel-sumpow_LH_novel_mean;
                else
                    sumpow_LH_novel_mean=nanmean(sumpow_LH_novel);
                    sumpow_LH_novel_zeromean=sumpow_LH_novel-sumpow_LH_novel_mean;
                    sumpow_LH_novel_zeromean=sumpow_LH_novel_zeromean*-1;
                end

            else
                sumpow_LH_novel_zeromean=nan(1,length(sumpow_LH_novel));
            end


            if vettedbackup_novel_normoxic{z,session*2+1} >= 1
                if vettedbackup_novel_normoxic{z,session*2+1} == 1
                    sumpow_RH_novel_mean=nanmean(sumpow_RH_novel);
                    sumpow_RH_novel_zeromean=sumpow_RH_novel-sumpow_RH_novel_mean;
                else
                    sumpow_RH_novel_mean=nanmean(sumpow_RH_novel);
                    sumpow_RH_novel_zeromean=sumpow_RH_novel-sumpow_RH_novel_mean;
                    sumpow_RH_novel_zeromean=sumpow_RH_novel_zeromean*-1;
                end

            else
                sumpow_RH_novel_zeromean=nan(1,length(sumpow_RH_novel));
            end   
            
        end
        
        
        
        sumpow_zeromean_combined=[sumpow_LH_zeromean;sumpow_RH_zeromean];
        
        if daytrack==1
           sumpow_zeromean_combined_novel=[sumpow_LH_novel_zeromean;sumpow_RH_novel_zeromean]; 
        end
        
        
        for datapoint=1:length(sumpow_LH_zeromean)
           mean_session(1,datapoint)=nanmean(sumpow_zeromean_combined(:,datapoint));
           if daytrack==1
               mean_session_novel(1,datapoint)=nanmean(sumpow_zeromean_combined_novel(:,datapoint));
           end
        end
        %%%End Added Code
        
        
%         subplot(3,1,3)
%         plot(sumpow_LH);
%         set(gca,'XTickLabel',[]);
%         xlen=length(sumpow_LH);
%         xlim([1 xlen])
%         
%         pause
%         close 
%         


        
        
        LFP_LH_Data{filenum,session}=sumpow_LH_zeromean;
        LH_tracker=LH_tracker+1;
        
        LFP_RH_Data{filenum,session}=sumpow_RH_zeromean;
        RH_tracker=RH_tracker+1;
%         

        LFP_Mean_Data{filenum,session}=mean_session;
        if daytrack==1
            LFP_Mean_Data_Novel{noveltracker,session}=mean_session_novel; 
        end

       if session == 5
            filenum=filenum+1;
            noveltracker=noveltracker+1;
       end



        
        clear sumpow_LH sumpow_RH freqrange pbaseLH_log pbaseRH_log
        clear FRH yRH fRH tRH pbaseLH pbaseRH FLH yLH fLH
    end
    disp=sprintf('File %s of %s',num2str(z),num2str(length(fname)))
            clear combofilename Temp_LFP_LH Temp_LFP_RH

end






%Compress session powers into one average vector for each file (day)
animal=1;
filenum=1;
for file=1:5:length(fname)
    for day=1:5
        clear temp_session_data
        for session=1:sessionnum
%            temp_LH(session,:)=LFP_LH_Data{file,session}(1,:);
%            temp_RH(session,:)=LFP_RH_Data{file,session}(1,:);


%              if max(LFP_Mean_Data{(file+day-1),session}(1,1:75))>1500
%                  temp_session_data(session,:)=nan(1,559);
%              else
                temp_mean=nanmean(LFP_Mean_Data{(file+day-1),session}(1,1:75));
                temp_session_data(session,:)=abs(LFP_Mean_Data{(file+day-1),session}-temp_mean);
%              end
               
                temp_mean_novel=nanmean(LFP_Mean_Data_Novel{(file+day-1),session}(1,1:75));
                temp_session_data_novel(session,:)=abs(LFP_Mean_Data_Novel{(file+day-1),session}-temp_mean_novel);
                
        end
%         for session=1:sessionnum
% %             min_val_LH=min(LFP_LH_Data{file,session}(1,:));
% %             min_val_RH=min(LFP_RH_Data{file,session}(1,:));
% %             temp_LH(session,:)=(-1*LFP_LH_Data{file,session}(1,:))./min_val_LH;
% %             temp_RH(session,:)=(-1*LFP_RH_Data{file,session}(1,:))./min_val_RH;
% %            
%             mean_val_LH=mean(LFP_LH_Data{filenum,session}(1,:));
%             mean_val_RH=mean(LFP_RH_Data{filenum,session}(1,:));
%            temp_LH(session,:)=(LFP_LH_Data{filenum,session}(1,:))-mean_val_LH;
%            temp_RH(session,:)=(LFP_RH_Data{filenum,session}(1,:))-mean_val_RH;
%            
%            
%         end
        [~,datapoints]=size(temp_session_data);
        for datapoint=1:datapoints
            LFP_AVG_Data{animal,day}(1,datapoint)=nanmean(temp_session_data(:,datapoint));
            LFP_AVG_Data_Novel{animal,day}(1,datapoint)=nanmean(temp_session_data_novel(:,datapoint));
        end
        clear temp_LH temp_RH
    end
    
    animal=animal+1;
end



for day=1:5
    for current_animal=1:(animal-1)
        temp_mean=nanmean(abs(LFP_AVG_Data{current_animal,day}(1,1:75)));
        temp_Animal(current_animal,:)=abs(LFP_AVG_Data{current_animal,day}(1,:));
        temp_Animal(current_animal,:)=temp_Animal(current_animal,:)-temp_mean;
        
        temp_mean_novel=nanmean(abs(LFP_AVG_Data_Novel{current_animal,day}(1,1:75)));
        temp_Animal_novel(current_animal,:)=abs(LFP_AVG_Data_Novel{current_animal,day}(1,:));
        temp_Animal_novel(current_animal,:)=temp_Animal_novel(current_animal,:)-temp_mean_novel;
    end
    
    for datapoint=1:datapoints
        Final_Data(day,datapoint)=nanmean(temp_Animal(:,datapoint));
        Final_Data_Novel(day,datapoint)=nanmean(temp_Animal_novel(:,datapoint));
    end
    
end

figure
for i=1:5
    if i == 1
        subplot(5,1,5)
    else
        subplot(5,1,i-1);
    end
    hold on
    plot(Final_Data(i,:))
    plot([80 80],[-320 400],'k--','LineWidth',2);
    plot([1 559],[0 0],'k-','LineWidth',2);
    ylim([-320 400]);
    if i ==1
        plot(Final_Data_Novel(i,:),'Color','r');
    end
end


movavgwin=20;
color='b';
for i = 1:5
    if i == 1
        day=5;
    elseif i == 5
        day = 1;
    else
        day = i;
    end
    subplot(5,1,day)
    hold on;
    test=tsmovavg(Final_Data(day,:),'s',movavgwin);
    plot(test,'Color',color)
    clear test
end


figure(5)
absolute=1;
for i = 1:5:length(fname)
%     subplot(6,1,1)
%     hold all
%     for j=1:5
%         mean_value=mean(LFP_Mean_Data{i+1,j});
%         ModifiedData=LFP_Mean_Data{i+1,j}-mean_value;
%         if absolute==1
%             if isnan(sum(ModifiedData))
%             else
%             plot(abs(ModifiedData));
%             end
%         else
%             plot(ModifiedData);
%         end
%         plot([80 80],[-1000 4000],'k--','LineWidth',2);
%         ylim([-1000 4000])
%     end
%     
%     
%     
%     subplot(6,1,2)
%     hold all
%     for j=1:5
%         mean_value=mean(LFP_Mean_Data{i+2,j});
%         ModifiedData=LFP_Mean_Data{i+2,j}-mean_value;
%         if absolute==1
%             if isnan(sum(ModifiedData))
%             else
%             plot(abs(ModifiedData));
%             end
%         else
%             plot(ModifiedData);
%         end
%         plot([80 80],[-1000 4000],'k--','LineWidth',2);
%         ylim([-1000 4000])
%     end
%     
%     
%     
%     subplot(6,1,3)
%     hold all 
%     for j=1:5
%         mean_value=mean(LFP_Mean_Data{i+3,j});
%         ModifiedData=LFP_Mean_Data{i+3,j}-mean_value;
%         if absolute==1
%             if isnan(sum(ModifiedData))
%             else
%             plot(abs(ModifiedData));
%             end
%         else
%             plot(ModifiedData);
%         end
%         plot([80 80],[-1000 4000],'k--','LineWidth',2);
%         ylim([-1000 4000])
%         
%     end
%     
%     
%     
%     subplot(6,1,4)
%     hold all
%      for j=1:5
%         mean_value=mean(LFP_Mean_Data{i+4,j});
%         ModifiedData=LFP_Mean_Data{i+4,j}-mean_value;
% %         if max(ModifiedData(1,1:80))<1500
% %             figure(6)
% %             hold on
% %             plot(ModifiedData);
% %             i=i
% %             j=j
% %             figure(5)
% %         end
%         if absolute==1
%             if isnan(sum(ModifiedData))
%             else
%             plot(abs(ModifiedData));
%             end
%         else
%             plot(ModifiedData);
%         end
%         plot([80 80],[-1000 4000],'k--','LineWidth',2);
%         ylim([-1000 4000])
%      end
%      

    subplot(2,1,1)
    hold all
    for j=1:5
        mean_value=mean(LFP_Mean_Data{i,j});
        ModifiedData=LFP_Mean_Data{i,j}-mean_value;
        if absolute==1
            if isnan(sum(ModifiedData))
            else
            plot(abs(ModifiedData));
            end
        else
            plot(ModifiedData);
        end
        plot([80 80],[-1000 4000],'k--','LineWidth',2);
        ylim([-1000 4000])
    end
    
    subplot(2,1,2)
    hold all
    for j=1:5
        mean_value=mean(LFP_Mean_Data_Novel{i,j});
        ModifiedData=LFP_Mean_Data_Novel{i,j}-mean_value;
        if absolute==1
            if isnan(sum(ModifiedData))
            else
            plot(abs(ModifiedData));
            end
        else
            plot(ModifiedData);
        end
        plot([80 80],[-1000 4000],'k--','LineWidth',2);
        ylim([-1000 4000])
    end

end

    




