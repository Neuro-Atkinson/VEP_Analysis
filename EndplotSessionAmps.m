% %Calculate amplitudes for sessions
% EndPlotData_SessionAmps{1,1}='File Name';
% maxminL=0;
% maxmaxL=0;
% maxminR=0;
% maxmaxR=0;
% 
% for alpha=1:alphamax
%     EndPlotData_SessionAmps{alpha+1,1}=groupfiles{1,alpha};
%     EventNum=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).EventNum;
%     colorvector=lines(EventNum);
%     for betaA=1:EventNum
%             sessionsname1=sprintf('Sessions%s%s_Amps',EventNames{(betaA)},EventNames{(betaA+2),1});
%             sessionsname2=sprintf('Sessions%s%s_Amps',EventNames{(betaA+1)},EventNames{(betaA+3),1});
% 
%         if betaA < 2
%             for Session_Num=1:session_number
%                 EndPlotData_SessionAmps{1,((betaA-1)*10)+(Session_Num+1)}=sprintf('LH Session %s',num2str(Session_Num));
%                 EndPlotData_SessionAmps{1,((betaA-1)*10)+(Session_Num+6)}=sprintf('RH Session %s',num2str(Session_Num));
%                 EndPlotData_SessionAmps{alpha+1,((betaA-1)*10)+(Session_Num+1)}=max(max(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(sessionsname1)(Session_Num,1,1:WindowSize)))-min(min(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(sessionsname1)(Session_Num,1,1:WindowSize)));
%                 EndPlotData_SessionAmps{alpha+1,((betaA-1)*10)+(Session_Num+6)}=max(max(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(sessionsname2)(Session_Num,1,1:WindowSize)))-min(min(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(sessionsname2)(Session_Num,1,1:WindowSize)));
%             end
%             
%         else
%             EndPlotData_SessionAmps{1,(betaA*2)}=sprintf('LH Novel');
%             EndPlotData_SessionAmps{1,(betaA*2+1)}=sprintf('RH Novel');
%             EndPlotData_SessionAmps{alpha+1,(betaA*2)}=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).Amplitudes(betaA,1);%LeftHemisphere
%             EndPlotData_SessionAmps{alpha+1,(betaA*2+1)}=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).Amplitudes(betaA,2);%RightHemisphere
%         end
%     end
%     
%  debug=1;   
% end
% handles.MainStructure.(GroupName).EndPlotData_SessionAmps=EndPlotData_SessionAmps;