clear

fileID = fopen('Bmouse_Blue_Day1_20_Binoc_data.bin');
A = fread(fileID,'double','ieee-le');
fclose(fileID);


TotalChans=8;
        %sizebuff=length(A)/(TotalChans-1);
        sizebuff=length(A)/TotalChans;
        Data=nan(1,sizebuff,TotalChans);
        sizebuff=length(Data);
        %skipper=(TotalChans-1);
        skipper=TotalChans;
        for i=1:TotalChans
            clear channel
            channel=A(i:skipper:length(A));
            Data(1,1:sizebuff,i)=channel(1:sizebuff,1)';
        end
        
    for i = 1:8
		subplot(8,1,i)
		plot(Data(1,:,i))
        ylim([-2 10])
    end
    
    
    
    
    
    
%     clear
% 
% fileID = fopen('Amouse_Blue_Binoc_45_Day1_data.bin');
% A = fread(fileID,'double','ieee-le');
% fclose(fileID);
% 
% 
% TotalChans=8;
%         sizebuff=length(A)/(TotalChans-1);
%         
%         Data=nan(1,sizebuff,TotalChans);
%         sizebuff=length(Data);
%         for i=1:TotalChans
%             clear channel
%             channel=A(i:(TotalChans-1):length(A));
%             Data(1,1:sizebuff,i)=channel(1:sizebuff,1)';
%         end
%         
%     for i = 1:8
% 		subplot(8,1,i)
% 		plot(Data(1,:,i))
%         ylim([0 10])
% 	end