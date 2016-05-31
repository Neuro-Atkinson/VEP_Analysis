%Calculate amplitudes for sessions
EndPlotData_SessionAmps{1,1}='File Name';
maxminL=0;
maxmaxL=0;
maxminR=0;
maxmaxR=0;

for file_number=1:alphamax
    
    EndPlotData_SessionAmps{file_number+1,1}=groupfiles{1,file_number};
    
    EventNum=handles.MainStructure.(GroupName).(groupfiles{1,file_number}(1,1:end-4)).EventNum;
    
    colorvector=lines(EventNum);
    
    EventName_Total=(EventNum*4)-1;
    
%I'm going to rewrite the label of EndPlotData_SessionAmps a lot, so i'll
%have to optimize that later.
    
    for EventName_LoopLoc=1:4:EventName_Total
        
            LH_Code=sprintf('Sessions%s%s_Amps',EventNames{(EventName_LoopLoc)},EventNames{(EventName_LoopLoc+2),1});
            RH_Code=sprintf('Sessions%s%s_Amps',EventNames{(EventName_LoopLoc+1)},EventNames{(EventName_LoopLoc+3),1});

        %session_number*2 since we are storing LH and RH in one pass.    
        for Session_Num=1:2:(session_number*2)
                true_session_num=(Session_Num+1)/2;
           
           EndPlotData_SessionAmps{1,Session_Num}=sprintf('LH_Ses_%s_Amp',Session_Num);
           EndPlotData_SessionAmps{1,Session_Num+1}=sprintf('RH_Ses_%s_Amp',Session_Num+1);
           
           SessionDataLH(:,:)=handles.MainStructure.(GroupName).(groupfiles{1,file_number}(1,1:end-4)).(LH_Code)(true_session_num,:,:);
           SessionDataRH(:,:)=handles.MainStructure.(GroupName).(groupfiles{1,file_number}(1,1:end-4)).(RH_Code)(true_session_num,:,:);
           
            [meansessionminLH,minlocLH]=(min(SessionDataLH(20:100,1)));
            minlocLH = minlocLH + 19;
            [meansessionmaxLH,maxlocLH]=(max(SessionDataLH(minloc:250,1)));
            meanampLH=meansessionmaxLH-meansessionminLH;
            
            [meansessionminRH,minlocRH]=(min(SessionDataRH(20:100,1)));
            minlocRH = minlocRH + 19;
            [meansessionmaxRH,maxlocRH]=(max(SessionDataRH(minloc:250,1)));
            meanampRH=meansessionmaxRH-meansessionminRH;
           
            EndPlotData_SessionAmps{file_number+1,Session_Num}=meanampLH;
            EndPlotData_SessionAmps{file_number+1,Session_Num+1}=meanampRH;
            
        end
    end  
end