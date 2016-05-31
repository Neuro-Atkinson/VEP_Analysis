%EVENT CODES MUST START WITH AN ODD NUMBER
%Variables used in script
% used JEC 2-14-14
clear all
AmpGain=1000;
RecordingFreq = 1000; %per channel recording frequency in Hz
NormalizedAmplitudes=0; %For each window extracted, the data is normalized (each data point value in window 'n' is subtracted by the mean value of that window)

%Only run files with the same event number and degree together in batches.
%Example: Day1-4 45deg


%ONLY ONE VARIABLE, RunSrpAnalysis, RunAcuityAnalysis, RunContrastAnalysis,
%or RunConAcuAnalysis CAN EQUAL 1.  The rest MUST be 0.

%General Analysis Variables
%Current code supports up to 7 groups for srp or contra/ipsi analysis
Groups=2;
GroupNames={'Group1','Group2'}; %,'T4green','T4red'};

%SRP Variables
%Notes: Set the group and group names on line 15-16
%When the first file selection box comes up select group 1 files
%the program will run and then give you a second selection box
%to select the next group's files.
RunSrpAnalysis=0;
        BinocSRP=0;
        LeyeSRP=1; %Left eye is open
        ReyeSRP=0; %Right eye is open
    SrpDays=5;
    NovelDay1=0; %If you're running a srp where the day 1 of your familiar was previously a novel for another srp. 1=true, 0=false;
    SrpThresh=1;
    RunVidget=0;%For Vidget Analysis... if you don't need vidget set to 0
    EventNumber=2;%For Vidget Analysis, sets the event number for all files.
    
    
%Acuity Variables    
RunAcuityAnalysis=0;
    ShowMergedAcuity=1;
    ShowLHemiAcuity=0;
    ShowRHemiAcuity=0;
    AcuityThresh=140;
    DetectAcuityPeakWin=[-2,30]; %creates window around negative peak these values represent percent of extracted window (data point based window fluctuates with recording frequency)
    
%Contrast Variables
RunContrastAnalysis=0;
    ShowMergedContrast=1;
    ShowLHemiContrast=0;
    ShowRHemiContrast=0;
    ContrastThresh=140;
    DetectContrastPeakWin=[-2,30];
%Run Spectral Analysis    
 Spectral=0;
 
%CONTRA/IPSI Variables
%Notes: Set the group and group names on line 15-16
%When the first file selection box comes up select group 1 files
%the program will run and then give you a second selection box
%to select the next group's files.
%**********************************************************
%Files must be loaded into the program such that
%the group filenames are organized as follows:
%Animal_#1_LeftHemisphere_DayN
%Animal_#1_RightHemisphere_DayN
%Animal_#2_LeftHemisphere_DayN
%Animal_#2_RightHemisphere_DayN
%otherwise the code will not work... this should be the default file
%structure because of the filenames so this should not be an issue for now.
RunContraIpsi=1;

    
%Not Implimented Yet, Leave as 0    
RunConAcuAnalysis=0;

if (RunSrpAnalysis+RunAcuityAnalysis+RunContrastAnalysis+RunContraIpsi+RunConAcuAnalysis)~=1
    errormsg=sprintf('Error:You must have only 1 type of analysis selected.  Set other options to 0');
    errordlg(errormsg,'Error');
    return;
end

%SRP SETTINGS
%vep event names by default.  Order is important for analysis.
VepEventNames={'45Deg','135Deg','30Deg','60Deg'};
if BinocSRP==1
    VepEventSymbols={'s','o','d','p','h'};
elseif LeyeSRP==1
    VepEventSymbols_contra={'-s','-o','-d','-p','-h'};
    VepEventSymbols_ipsi={'--s','--o','--d','--p','--h'};
elseif ReyeSRP==1
    VepEventSymbols_contra={'-s','-o','-d','-p','-h'};
    VepEventSymbols_ipsi={'--s','--o','--d','--p','--h'};
end
grpcolors=[0 0 1; 1 0 0; 0 .5 0; 0 .75 .75; .75 0 .75; .75 .75 0];
%ACUITY SETTINGS (Default De-Coding Ruleset)
AcuityCodes={'.05','.1','.2','.3','.4','.5','.6','.7'};
%                 .05 .1  .2  .3  .4    .5    .6    .7
AcuityEventCodes=[1 2;3 4;5 6;7 8;9 10;11 12;13 14;15 16];
AcuityCon={'100%'};
MaximumAcuityEvent=1;%Based on acuity code location of expected maximum response.

%CONTRAST SETTINGS (Default De-Coding Ruleset)
ContrastCodes={'2%','4%','6%','8%','10%','30%','50%','100%'};
%                    2   4   6   8   10   30    50    100
ContrastEventCodes=[1 2;3 4;5 6;7 8;9 10;11 12;13 14;15 16];
ContrastSF={'.05'};
MaximumContrastEvent=8;%Based on contrast code location of expected maximum response.

%TWO WEEK SRP SETTINGS
TwoWeekSrpCodes={'45','135','30','60'};
TwoWeekSrpEventCodes=[1 2;3 4;5 6;7 8];

%INTERNAL STRUCTURE SETTINGS (Default)
%Analog To Digital Converted Channel Structure
TotalDigitalChans=3;
StrobeDig=1;
Event1Dig=2;
Event2Dig=3;
Event3Dig=4;
Event4Dig=5;
TotalChans=8;

%Total number of event channels
NUM_events=4;
%Raw Data Structure
VidgetChannel=2;
pre_start_size=2;
post_start_size=5;
StrobeChannel=4;
EventChan1=5;
EventChan2=6;
EventChan3=7;
EventChan4=8;

%Individual channel threshold for digital conversion 
StrobeThresh=.2;
EventChan1Thresh=0.2;
EventChan2Thresh=0.2;
EventChan3Thresh=0.2;
EventChan4Thresh=0.2;

%Correction Settings
AcuityCodes=[' ' AcuityCodes ' '];
ContrastCodes=[' ' ContrastCodes ' '];
if RunSrpAnalysis==0 && RunContraIpsi==0 && RunContrastAnalysis==0 && RunAcuityAnalysis==0
    Groups=1;
end

Week2Analysis=1;
%     if Week2Analysis ==1 && SrpDays ~= 5
%         return;
%     end

%START OF ANALYSIS CODE
% if RunConAcuAnalysis==0
if RunSrpAnalysis==1 && Week2Analysis==1
   RanWeek2Analysis=0;
   for i=1:length(GroupNames)
      Week2Names{1,i}=sprintf('%s_Week2',GroupNames{1,i}); 
   end
end
RanWeek2Analysis=0;
primaryAlpha=1;
while primaryAlpha<=Groups
     if RunSrpAnalysis==1||RunContraIpsi==1 || RunContrastAnalysis==1 || RunAcuityAnalysis==1
         if RanWeek2Analysis==1
             GroupName=sprintf('%s',Week2Names{1,primaryAlpha});
         else
            GroupName=sprintf('%s',GroupNames{1,primaryAlpha});
         end
     else
        GroupName=sprintf('Group%s',num2str(primaryAlpha));    
     end
     if RunVidget ==1 && ~exist('Window_settings2')
         ModifiedEventNumber=EventNumber*2;
         for e = 1:2:ModifiedEventNumber
             if e==1
                 ecode=1;
             else
                 ecode=e-1;
             end
             prompt{e} = strcat('Event #', num2str(ecode),' Code 1');
             predef_setting2{e} = strcat('Event#', num2str(ecode),' Code 1 Goes Here');
             prompt{e+1} = strcat('Event #', num2str(ecode),' Code 2');
             predef_setting2{e+1} = strcat('Event#', num2str(ecode),' Code 2 Goes Here');

         end
         dlg_title = sprintf('Specify Event Codes (Needs To Be The Same For All Files)  Example: [(Code1#) (Code2#)]');
         num_lines = 1;
         EventMatrix_preconstruct = inputdlg(prompt,dlg_title,[num_lines, length(dlg_title)+50],predef_setting2);
         construct_eventmatrix=length(EventMatrix_preconstruct)/2;
         for ze=1:construct_eventmatrix
             EventMatrix(ze,1)=str2num(EventMatrix_preconstruct{2*ze-1,1});
             EventMatrix(ze,2)=str2num(EventMatrix_preconstruct{2*ze,1});
         end
         clear prompt predef_settings2
         for e = 1:EventNumber
             prompt{e} = strcat('Event #', num2str(e),' [',num2str(EventMatrix(e,1)),',',num2str(EventMatrix(e,2)),' ] : ');
             predef_setting2{e} = strcat('Event#', num2str(e),' Name Goes Here');
         end
         dlg_title = sprintf('Specify Event Names');
         num_lines = 1;
         Window_settings2 = inputdlg(prompt,dlg_title,[num_lines, length(dlg_title)+50],predef_setting2);
          if isempty(Window_settings2) 
             % User clicked cancel. 
             return;
         end
     end


    files = char([]);
    [fname,pathname] = uigetfile('*.dat','Select binary data files','MultiSelect','on');
    if iscell(fname)==0
        fname={fname};
    end
    tic;
    for z=1:length(fname)
        output=sprintf('Processing File %s of %s',num2str(z),num2str(length(fname)));
        display(output);
        combofilename=sprintf('%s%s',pathname,fname{1,z});
        fileID = fopen(combofilename);
        A = fread(fileID,inf,'float');
        filelength=length(A);
        clear A;
        Data = multibandread(combofilename, [1 (filelength/TotalChans) TotalChans], 'float', 0, 'bip', 'ieee-le' );
        fclose(fileID);

        DataLength=length(Data);
        DigitalChans=zeros(TotalDigitalChans,DataLength);
        %Generate Timepoint Vector

        pre_time_converted=pre_start_size*RecordingFreq;
        post_time_converted=post_start_size*RecordingFreq;
        x_vals_time = [linspace((pre_start_size*-1),0,(pre_start_size*RecordingFreq+2)) linspace(0.01,(post_start_size-.01),(post_start_size*RecordingFreq+2))]';
        TimeStep=1/RecordingFreq;
        Timepoints=zeros(1,DataLength); %Empty vector of timepoints in seconds
        for i=1:DataLength
           if i==1
               Timepoints(1,1)=TimeStep;
           else
               Timepoints(1,i)=Timepoints(1,i-1)+TimeStep;
           end
        end


        %Convert the analog strobe channel to a digital channel for easier event
        %timepoint extraction
        for i = 1:DataLength
           if Data(1,i,StrobeChannel) < StrobeThresh
               DigitalChans(StrobeDig,i)=0;
           else
               DigitalChans(StrobeDig,i)=1;
           end
        end

        %Convert the analog event1 channel to a digital channel for easier event
        %timepoint extraction
        for i = 1:DataLength
           if Data(1,i,EventChan1) < EventChan1Thresh
               DigitalChans(Event1Dig,i)=0;
           else
               DigitalChans(Event1Dig,i)=1;
           end
        end

        %Convert the analog event2 channel to a digital channel for easier event
        %timepoint extraction
        for i = 1:DataLength
           if Data(1,i,EventChan2) < EventChan2Thresh
               DigitalChans(Event2Dig,i)=0;
           else
               DigitalChans(Event2Dig,i)=1;
           end
        end

        for i = 1:DataLength
           if Data(1,i,EventChan3) < EventChan3Thresh
               DigitalChans(Event3Dig,i)=0;
           else
               DigitalChans(Event3Dig,i)=1;
           end
        end
        if NUM_events == 4
        for i = 1:DataLength
           if Data(1,i,EventChan4) < EventChan4Thresh
               DigitalChans(Event4Dig,i)=0;
           else
               DigitalChans(Event4Dig,i)=1;
           end
        end
        end

        ActiveEventChans=zeros(1,NUM_events);
        for i=1:4
           if max(DigitalChans(i+1,:)) == 1
               ActiveEventChans(1,i)=1;
           end
        end
        %Find flip flops EventRegions
        tracervalue=1;
        for i = 2:length(Data(1,1:end,1))
            if DigitalChans(Event1Dig,i-1)==0 && DigitalChans(Event1Dig,i)==1
                FlipFlopPoints(1,tracervalue)=i;
                tracervalue=tracervalue+1;
            elseif DigitalChans(Event1Dig,i-1)==1 && DigitalChans(Event1Dig,i)==0
                FlipFlopPoints(1,tracervalue)=i;
                tracervalue=tracervalue+1;
            end
        end


        % plot(Timepoints(1,1:length(Data(1,1:50000,1))),DigitalChans(2,1:length(Data(1,1:50000,1))));
        % hold on
        % for i=1:length(FlipFlopPoints)
        %     if FlipFlopPoints(i) < 50000
        %     plot(Timepoints(1,FlipFlopPoints(i)),1,'r.','MarkerSize',20);
        %     end
        % 
        % end
        EventTracker=1;
        tracervalue=1;
        % figure(1)
        for i=2:2:length(FlipFlopPoints)
            if FlipFlopPoints(i) < length(Data(1,1:end,1))
        %     yvalues = ones(1,length(Timepoints(1,FlipFlopPoints(i-1):FlipFlopPoints(i))));
        %     plot(Timepoints(1,FlipFlopPoints(i-1):FlipFlopPoints(i)),yvalues,'r');
        %     thetitle=sprintf('%s',num2str(FlipFlopPoints(i)-FlipFlopPoints(i-1)));
        %     Title(thetitle);
        %     ylim([-0.1 1.2]);
        %     pause
        %     hold on
        %     plot(Timepoints(1,FlipFlopPoints(i-1):FlipFlopPoints(i)),DigitalChans(2,FlipFlopPoints(i-1):FlipFlopPoints(i)));
            FlipFlopDiffs(1,tracervalue)=Timepoints(1,FlipFlopPoints(i))-Timepoints(1,FlipFlopPoints(i-1));
            tracervalue=tracervalue+1;
        %     ylim([-0.1 1.2]);
        %     thetitle=sprintf('%s',num2str(FlipFlopPoints(i)-FlipFlopPoints(i-1)));
        %     Title(thetitle);
        %     pause; 
            end 
        %     close(1);
        end

        % Short square waves indicate event channel 1
        % 
        % ylim([-0.1 1.2]);

        OffsetRegionStart=find(FlipFlopDiffs < (mean(FlipFlopDiffs)-.01));
        ErrorCheckOffsetRegionStart=OffsetRegionStart;
        delcleanup=true;
        while delcleanup==true
        deltrack=1;
        clear deloffset
        for i=1:length(OffsetRegionStart)-1
           if OffsetRegionStart(i+1)-OffsetRegionStart(i) < 98
               deloffset(deltrack)=i+1;
               deltrack=deltrack+1;
           end
        end

        if ~exist('deloffset')
            delcleanup=false;
        else
            OffsetRegionStart(deloffset(1))=[];
        end

        end
        CorrectionIndex=zeros(1,length(OffsetRegionStart));
        for i=1:length(OffsetRegionStart)
            doloop=1;

           CorrectedRegionStart(1,i)=OffsetRegionStart(1,i)*2;
           startcheck=FlipFlopPoints(1,CorrectedRegionStart(1,i)-1);
        %    plotloc1=startcheck-10000;
        %    plotloc2=startcheck+10000;
        %    plot(DigitalChans(StrobeDig,plotloc1:plotloc2),'Color','b');
        %    hold on
        %    plot(DigitalChans(Event1Dig,plotloc1:plotloc2),'Color','g');

        %    line([(startcheck-plotloc1) (startcheck-plotloc1)], [0 2], 'Color','r');
           while doloop==1
               if DigitalChans(StrobeDig,(startcheck-CorrectionIndex(1,i)))==0 && i ~= 1
                    CorrectionIndex(1,i)=CorrectionIndex(1,i)+1;
               else
                    doloop=0;
                    jittercorrect=5;
                    %later on, add an average strobe-to-event jitter to better
                    %estimate the actual event start time since the event and
                    %strobe are slightly off for each flip flop.
               end

           end
           FlipFlopCorrection=startcheck-CorrectionIndex(1,i);
           CorrectedRegionStart(1,i)=CorrectedRegionStart(1,i)-1;
           FlipFlopPoints(1,CorrectedRegionStart(1,i))=FlipFlopCorrection+jittercorrect;
        %    line([10001-(startcheck-FlipFlopPoints(1,CorrectedRegionStart(1,i))) 10001-(startcheck-FlipFlopPoints(1,CorrectedRegionStart(1,i)))], [0 2], 'Color', 'c');
        %    pause;
           if i==1
           else
           StopPoints(1,i-1)=Timepoints(1,FlipFlopPoints(1,CorrectedRegionStart(1,i)-1));
           end
        end

        %Generate Waveform Structure
        WindowSize=length(Timepoints(FlipFlopPoints(1,3):FlipFlopPoints(1,4)))-5;
        %Force Odd Window Size (peak point with equal wings on either side) so we
        %can compare all waveforms equally based on peak point.
        if rem(WindowSize,2)~=1
            WindowSize=WindowSize-1; %Smaller size so we don't go outside the bounding box (FlipFlopPoints)
        end
        if WindowSize ~= 495
            WindowSize=495;
        end
        %Determine Small Window Number
        %for interval=1:15
        WindowNum=1;
            clear RegionSmallWin
            clear MergedWaveForm
        %For each reagion
        Event1Tracker=1;
        Event2Tracker=1;


        for i=1:length(CorrectedRegionStart)
        %for i=1:1
            %Determine FlipFlops In This Region
            if i < length(CorrectedRegionStart)
                Start=CorrectedRegionStart(i);
                Stop=CorrectedRegionStart(i+1)-1;
            else
                Start=CorrectedRegionStart(i);
                Stop=length(FlipFlopPoints);
            end
            WindowNum=1;
            %displayfig=figure;
            %pause;



            Tracker=struct();
            for j=Start:Stop
            %Extract Vidget Data at the start of each session.







        %          displayfig=figure;
        %             figure(1)
        %             plot(DigitalChans(2,1:200000))
        %             hold on

        %Determine event code for each window extraction to allow for the future
        %randomization of each stim per flip-flop.
            if i > 1
            OldEventSum=EventSum;
            end
            EventSum=0;
            originalJ=FlipFlopPoints(j);
            LeftTrack=0;
            RightTrack=0;
            Showerror=0;
            debugtracker=1;

            while EventSum==0
            if any(CorrectedRegionStart==j)
            EventLocation=FlipFlopPoints(j)+CorrectionIndex(1,i)+10;
            else
            EventLocation=FlipFlopPoints(j)+10;
            end
            if DigitalChans(Event1Dig,EventLocation)==1
                EventSum=EventSum+1;
            end
            if DigitalChans(Event2Dig,EventLocation)==1
                EventSum=EventSum+2;
            end
            if DigitalChans(Event3Dig,EventLocation)==1
                EventSum=EventSum+4;
            end
            if NUM_events==4
            if DigitalChans(Event4Dig,EventLocation)==1
                EventSum=EventSum+8;
            end
            end
        %         if EventSum==15
        %             if j==Start && debugtracker == 1
        %                 debugtracker=debugtracker+1;
        %             
        %             elseif j==Start && debugtracker==2
        %                         figure(1);
        %         hold off
        %         plot((DigitalChans(2,originalJ-1000:originalJ+1000)),'Color','b')
        %         hold on
        %         plot((DigitalChans(3,originalJ-1000:originalJ+1000)-.0005),'Color','r')
        %         plot((DigitalChans(4,originalJ-1000:originalJ+1000)-.0008),'Color','g')
        %         plot((DigitalChans(5,originalJ-1000:originalJ+1000)-.0011),'Color','c')
        %         plot([(FlipFlopPoints(j)-originalJ)+1000 (FlipFlopPoints(j)-originalJ)+1000],[0 2],'Color','black')
        %         plot([(EventLocation-originalJ+1000) (EventLocation-originalJ+1000)], [0 2],'Color','magenta');
        %         ylim([.998 1.0005]);
        %         pause;
        %             end
        %         end
            if EventSum==0
                if i > 1 && OldEventSum ~= 15
                if LeftTrack < 5
                FlipFlopPoints(j)=FlipFlopPoints(j)-10; %will need to change 20 to reflect a percent of the current recording frequency. 
                LeftTrack=LeftTrack+1
                else
                    if RightTrack==0
                        FlipFlopPoints(j)=originalJ;
                    end

                    FlipFlopPoints(j)=FlipFlopPoints(j)+10;
                    RightTrack=RightTrack+1
                end
                if RightTrack>5
                    errormsg=sprintf('Error:Could not find session start at location %s',num2str(originalJ));
                    errordlg(errormsg,'Error');
                    return;
                end

        %         if Showerror==0
        %         errordlg('Warning: Event Code = 0, Attempting to Correct...','Warning');
        %         Showerror=1;
        %         end
        %         figure(1);
        %         hold off
        %         plot((DigitalChans(2,originalJ-1000:originalJ+1000)),'Color','b')
        %         hold on
        %         plot((DigitalChans(3,originalJ-1000:originalJ+1000)-.0005),'Color','r')
        %         plot((DigitalChans(4,originalJ-1000:originalJ+1000)-.0008),'Color','g')
        %         plot((DigitalChans(5,originalJ-1000:originalJ+1000)-.0011),'Color','c')
        %         plot([(FlipFlopPoints(j)-originalJ)+1000 (FlipFlopPoints(j)-originalJ)+1000],[0 2],'Color','black')
        %         plot([(EventLocation-originalJ+1000) (EventLocation-originalJ+1000)], [0 2],'Color','magenta');
        %         ylim([.998 1.0005]);
        %         pause;
                else
                    EventSum=16;
                end
            end

            end
            if j==Start
                %determine baseline LFP
                if WindowSize ~= 495
                    error('windowsize must be 495, baseline lfp code must be modified to support different windowsizes.');
                end
                if i==1
                    baselinetracker=1;
                    if FlipFlopPoints(j) > 100001
                        for baseindex=(FlipFlopPoints(j)-100000):495:(FlipFlopPoints(j)-1000)
                            if NormalizedAmplitudes==0
                                baselineLH(baselinetracker,1:495)=Data(1,baseindex:baseindex+494,1);
                                baselineRH(baselinetracker,1:495)=Data(1,baseindex:baseindex+494,2);
                                baselinetracker=baselinetracker+1;
                            else
                                baselineLH(baselinetracker,1:495)=Data(1,baseindex:baseindex+494,1)-mean(Data(1,baseindex:baseindex+494,1));
                                baselineRH(baselinetracker,1:495)=Data(1,baseindex:baseindex+494,2)-mean(Data(1,baseindex:baseindex+494,2));
                                baselinetracker=baselinetracker+1;
                            end
                        end
                        for avgbaseindex=1:495
                           avgbaselineLH(1,avgbaseindex)=mean(baselineLH(:,avgbaseindex));
                           avgbaselineRH(1,avgbaseindex)=mean(baselineRH(:,avgbaseindex));
                        end
                    else
                       Remainder=1;
                       NewBlock=FlipFlopPoints(j);
                       while Remainder==1;
                            Remainder=rem(NewBlock,495);
                            if Remainder~=0
                                NewBlock=NewBlock-1;
                            end
                       end
                       for baseindex=1:495:NewBlock
                           if NormalizedAmplitudes==0
                               baselineLH(baselinetracker,1:495)=Data(1,baseindex:baseindex+494,1);
                               baselineRH(baselinetracker,1:495)=Data(1,baseindex:baseindex+494,2);
                               baselinetracker=baselinetracker+1;
                           else
                               baselineLH(baselinetracker,1:495)=Data(1,baseindex:baseindex+494,1)-mean(Data(1,baseindex:baseindex+494,1));
                               baselineRH(baselinetracker,1:495)=Data(1,baseindex:baseindex+494,2)-mean(Data(1,baseindex:baseindex+494,2));
                               baselinetracker=baselinetracker+1;
                           end
                        end
                        for avgbaseindex=1:495
                           avgbaselineLH(1,avgbaseindex)=mean(baselineLH(:,avgbaseindex));
                           avgbaselineRH(1,avgbaseindex)=mean(baselineRH(:,avgbaseindex));
                        end
                    end
                end
                ActualLocation=FlipFlopPoints(j);
                StartExtract=ActualLocation-pre_time_converted-1;
                EndExtract=ActualLocation+post_time_converted+2;
                if EventSum == 1
                DataStructure.DataName{1,3}(:,Event1Tracker)=Data(1,StartExtract:EndExtract,VidgetChannel);
                Event1Tracker=Event1Tracker+1;
                end

                if EventSum==3
                DataStructure.DataName{1,6}(:,Event2Tracker)=Data(1,StartExtract:EndExtract,VidgetChannel);
                Event2Tracker=Event2Tracker+1;
                end

            end

        WavNameL=sprintf('E%sL',num2str(EventSum));
        WavNameR=sprintf('E%sR',num2str(EventSum));
        WavNameTimes=sprintf('E%sTimes',num2str(EventSum));
        WavNameLocs=sprintf('E%sLocs',num2str(EventSum));
        if strcmp('E0L',WavNameL)
            debug=1;
        end
        if i==3
            debug=2;
        end
        if ~any(strcmp(WavNameL,fieldnames(Tracker)))
        Tracker.(WavNameL)(1,1)=1;
        end
        if ~any(strcmp(WavNameR,fieldnames(Tracker)))
        Tracker.(WavNameR)(1,1)=1;
        end

        if EventTracker==1
            EventChart(1,1)=EventSum;
            LocationChart(1,1)=1;
        %     EventMatrix(EventTracker,1)=EventSum;
        %     EventMatrix(EventTracker,2)=EventSum+1;
            EventTracker=EventTracker+1;
        else
            if mod(EventSum,2)~=0
                if any(EventChart==EventSum)
                    %DoNothing
                else
                    %Add to event chart
        %             EventMatrix(EventTracker,1)=EventSum;
        %             EventMatrix(EventTracker,2)=EventSum+1;
                    EventChart(1,EventTracker)=EventSum;
                    LocationChart(1,EventTracker)=1;
                    EventTracker=EventTracker+1;
                end
            end
        end

        if mod(EventSum,2)==0
            TempSum=EventSum-1;
            locspot=find(EventChart==TempSum);
        else
            TempSum=EventSum;
            locspot=find(EventChart==TempSum);
        end
        %             for k=1:WindowSize
        %               ActualLocation=FlipFlopPoints(j)+k;
        % %               plot(ActualLocation,1,'r')
        %               RegionSmallWinL(i,Tracker.(WavNameL)(1,1),k)=Data(1,ActualLocation,1);
        %               RegionSmallWinR(i,Tracker.(WavNameL)(1,1),k)=Data(1,ActualLocation,2);
        %               MainStructure.(fname{1,z}(1,1:end-4)).(WavNameL)(LocationChart(1,locspot),Tracker.(WavNameL)(1,1),k)=Data(1,ActualLocation,1);
        %               MainStructure.(fname{1,z}(1,1:end-4)).(WavNameR)(LocationChart(1,locspot),Tracker.(WavNameL)(1,1),k)=Data(1,ActualLocation,2);
        %               if Data(1,ActualLocation,1)==0 || Data(1,ActualLocation,2)==0
        %                   debug=1;
        %               end
        %             end
        % 
        if LocationChart(1,locspot)==6
            debug=1;
        end
                      ActualLocation=FlipFlopPoints(j);
                      EndLocation=FlipFlopPoints(j)+WindowSize-1;
                      if NormalizedAmplitudes==0
                          MainStructure.(GroupName).(fname{1,z}(1,1:end-4)).(WavNameL)(LocationChart(1,locspot),Tracker.(WavNameL)(1,1),1:WindowSize)=Data(1,ActualLocation:EndLocation,1);
                          MainStructure.(GroupName).(fname{1,z}(1,1:end-4)).(WavNameR)(LocationChart(1,locspot),Tracker.(WavNameR)(1,1),1:WindowSize)=Data(1,ActualLocation:EndLocation,2);
                      else
                          MainStructure.(GroupName).(fname{1,z}(1,1:end-4)).(WavNameL)(LocationChart(1,locspot),Tracker.(WavNameL)(1,1),1:WindowSize)=Data(1,ActualLocation:EndLocation,1)-mean(Data(1,ActualLocation:EndLocation,1));
                          MainStructure.(GroupName).(fname{1,z}(1,1:end-4)).(WavNameR)(LocationChart(1,locspot),Tracker.(WavNameR)(1,1),1:WindowSize)=Data(1,ActualLocation:EndLocation,2)-mean(Data(1,ActualLocation:EndLocation,2));
                      end

                      MainStructure.(GroupName).(fname{1,z}(1,1:end-4)).(WavNameTimes)(LocationChart(1,locspot),Tracker.(WavNameL)(1,1),1:WindowSize)=Timepoints(ActualLocation:EndLocation);
                      MainStructure.(GroupName).(fname{1,z}(1,1:end-4)).(WavNameLocs)(LocationChart(1,locspot),Tracker.(WavNameL)(1,1),1:WindowSize)=ActualLocation:EndLocation;

                      if Data(1,ActualLocation,1)==0 || Data(1,ActualLocation,2)==0
                          debug=1;
                      end


                    Tracker.(WavNameL)(1,1)=Tracker.(WavNameL)(1,1)+1;
                    Tracker.(WavNameR)(1,1)=Tracker.(WavNameR)(1,1)+1;
        %             pause;
        %             close(1);
                    %Align Peaks Code
        %             [x,y]=min(RegionSmallWin(1,i,1:1500));
        %             if x < -3.5  
        %                 offset=(600-y);
        %                 for k=1:WindowSize
        %                 ActualLocation=FlipFlopPoints(j)+k-offset;
        %                 RegionSmallWin(i,WindowNum,k)=Data(1,ActualLocation,1);
        %                 end
        %             end
        %             

        %             dispdata(1,:)=RegionSmallWin(i,WindowNum,1:end);
        %             dispfig=figure;
        %             hold on;
        %             subplot(3,1,1)
        %             
        %             interval1=1;
        %             interval2=0;
        %             hold all;plot(Data(1,(FlipFlopPoints(j)-(interval1*10)):((FlipFlopPoints(j)-(interval2*10))+WindowSize+10),1));plot(Data(1,(FlipFlopPoints(j)-(interval1*10)):((FlipFlopPoints(j)-(interval2*10))+WindowSize+10),5));plot(DigitalChans(2,(FlipFlopPoints(j)-(interval1*10)):((FlipFlopPoints(j)-(interval2*10))+WindowSize+10)));
        % 
        %             %hold all;plot(Data(1,(FlipFlopPoints(j)-(interval*10)):((FlipFlopPoints(j)-(interval*10))+WindowSize+10),1));plot(Data(1,(FlipFlopPoints(j)-(interval*10)):((FlipFlopPoints(j)-(interval*10))+WindowSize+10),5));plot(DigitalChans(2,(FlipFlopPoints(j)-(interval*10)):((FlipFlopPoints(j)-(interval*10))+WindowSize+10)));
        %            % xlim([0 (WindowSize+10)])
        %             thetitle=sprintf('Raw Data for Window: %s',num2str(j));
        %             title(thetitle);
        %             subplot(3,1,2)
        %             thetitle=sprintf('Extracted Data for Window: %s',num2str(j));
        %             title(thetitle);
        %             plot(dispdata);
        %             clear MergedWaveForm
        %             [x,~]=size(RegionSmallWin);
        %                 for h=1:x
        %                     for l=1:WindowSize
        %                         MergedWaveForm(1,l)=mean(RegionSmallWin(1,1:end,l ));
        %                     end
        %                     subplot(3,1,3)
        %                      plot(MergedWaveForm(1,1:end));
        %                      thetitle=sprintf('Running Average of VEP at Interval: %s ms',num2str(interval*10));
        %                      title(thetitle);
        %                 end
        %             pause; 
        % %             filename = sprintf('Interval%s_Block%s_Image%s',num2str(interval),num2str(i),num2str(j));
        % %             print(h, '-djpeg', filename);
        %             close(dispfig);
        %            
        %            subplot(2,1,1)
        %            hold on
        %            plot(Data(1,(FlipFlopPoints(j)-100):(FlipFlopPoints(j)+WindowSize+100),2));
        %            plot([101 101], [-.2 .2], 'r');
        %            plot([WindowSize WindowSize], [-.2 .2], 'r');
        %            plot([101 WindowSize],[0 0],'r');
        %            xlim([1 WindowSize+100]);
        %            subplot(2,1,2)
        %            hold on
        %             plot(DigitalChans(2,(FlipFlopPoints(Start)-3000):(FlipFlopPoints(Stop)+3000)));
        %             xlim([FlipFlopPoints(Start)-10000-FlipFlopPoints(Start) FlipFlopPoints(Stop)-FlipFlopPoints(Start)+13000])
        %             ylim([-.1 1.1])
        %            plot(((FlipFlopPoints(j)-FlipFlopPoints(Start)+3000)),1,'r.','MarkerSize',10);
        %            plot(((FlipFlopPoints(j)-FlipFlopPoints(Start)+3000)+WindowSize),1,'r.','MarkerSize',10);
        %            hold off
        %            set(displayfig,'Units', 'Normalized', 'OuterPosition', [0 0 1 1]); 
        %            pause;
        %            close(displayfig);
                   WindowNum=WindowNum+1;

            end
            LocationChart(1,locspot)=LocationChart(1,locspot)+1;
        end
         %end


        hrtz=RecordingFreq;
        if RunVidget==1
        if sum(regexpi(fname{1,z},'day5')) > 0 || sum(regexpi(fname{1,z},'day_5')) > 0 || sum(regexpi(fname{1,z},'novel')) > 0
        save([fname{1,z} '_Vidget.mat'],'DataStructure','pre_start_size','post_start_size','Window_settings2','x_vals_time','hrtz');
        else
            temp_windowsettings=Window_settings2;
            clear Window_settings2;
            Window_settings2{1,1}=temp_windowsettings{1,1};
            save([fname{1,z} '_Vidget.mat'],'DataStructure','pre_start_size','post_start_size','Window_settings2','x_vals_time','hrtz');
            clear Window_settings2
            Window_settings2=temp_windowsettings;
            clear temp_windowsettings;
        end
        end

        % figure;
        % [x,y,~]=size(RegionSmallWin);
        %     for i=1:1%x
        %         %subplot(1,x,i)
        %         hold all;
        %         for j=1:y
        %             plotter(1,:)=RegionSmallWin(i,j,1:end);
        %             %plot(Timepoints(1,1:WindowSize),plotter);
        %             plot(plotter);
        %         end
        %     end
        %         smoothdata1=smoothwa(MergedWaveForm(1,:),75,'gauss');
        %         smoothdata2=smoothwa(MergedWaveForm(2,:),75,'gauss');
        %         smoothdata3=smoothwa(MergedWaveForm(3,:),75,'gauss');
        %         figure;
        %         hold on;
        %         subplot(1,3,1)
        %         hold on;
        %         [minval minloc]=min(smoothdata1(1,1:800));
        %         [maxval maxloc]=max(smoothdata1(1,1:800));
        %         midpoint=(maxloc+minloc)/2;
        %         plot(smoothdata1)
        %         plot([midpoint midpoint],[minval maxval],'r');
        %         plot([(midpoint-50) (midpoint+50)],[minval minval],'r');
        %         plot([(midpoint-50) (midpoint+50)],[maxval maxval],'r');
        %         thetitle=sprintf('Peak to Peak Amplitude: %s uV',num2str((maxval-minval)*1000));
        %         title(thetitle);
        %         subplot(1,3,2)
        %         hold on;
        %         [minval minloc]=min(smoothdata2(1,1:800));
        %         [maxval maxloc]=max(smoothdata2(1,1:800));
        %         midpoint=(maxloc+minloc)/2;
        %         plot(smoothdata2)
        %         plot([midpoint midpoint],[minval maxval],'r');
        %         plot([(midpoint-50) (midpoint+50)],[minval minval],'r');
        %         plot([(midpoint-50) (midpoint+50)],[maxval maxval],'r');
        %         thetitle=sprintf('Peak to Peak Amplitude: %s uV',num2str((maxval-minval)*1000));
        %         title(thetitle);
        %         subplot(1,3,3)
        %                 hold on;
        %         [minval minloc]=min(smoothdata3(1,1:800));
        %         [maxval maxloc]=max(smoothdata3(1,1:800));
        %         midpoint=(maxloc+minloc)/2;
        %         plot(smoothdata3)
        %         plot([midpoint midpoint],[minval maxval],'r');
        %         plot([(midpoint-50) (midpoint+50)],[minval minval],'r');
        %         plot([(midpoint-50) (midpoint+50)],[maxval maxval],'r');
        %         thetitle=sprintf('Peak to Peak Amplitude: %s uV',num2str((maxval-minval)*1000));
        %         title(thetitle);

        % %Channel_0
        % LeftHemiWaveforms
        % tracervalue=1;
        % for i=1:length(FlipFlopPoints)
        %     if Timepoints(1,i) < StopPoints(1,tracervalue)
        %     
        %     end
        % end
        % 
        % 
        % %Channel_1
        % RightHemiWaveforms
        % %end
clear CorrectedRegionStart CorrectionIndex TimeStep ActualLocation ActiveEventChans OldEventSum TempSum StopPoints Stop Start StartExtract Timepoints jittercorrect startcheck Data tracervalue FlipFlopPoints OffsetRegionStart FlipFlopDiffs deloffset Tracker EventChart LocationChart locspot
    end
clear CorrectedRegionStart CorrectionIndex ActiveEventChans ActualLocation TimeStep OldEventSum TempSum StopPoints Stop Start StartExtract Timepoints jittercorrect Data tracervalue startcheck FlipFlopPoints OffsetRegionStart FlipFlopDiffs deloffset Tracker EventChart LocationChart locspot
    totalplots=0;

    output=sprintf('Data Processed, Performing Analysis Now...');
    display(output);

    [alphamax ~]=size(fieldnames(MainStructure.(GroupName)));
    for alpha=1:alphamax

        EventNames=fieldnames(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)));
        [remnamesize ~]=size(EventNames);
        for alphaA=1:(remnamesize/4)
           delname1=sprintf('E%sTimes',num2str(alphaA));
           delname2=sprintf('E%sLocs',num2str(alphaA));
           EventNames(strcmp((delname1),EventNames)) = [];
           EventNames(strcmp((delname2),EventNames)) = [];
        end
        [betamax ~]=size(EventNames);
        clear EventNames
        resorttrack=1;
        %AcuityEventCodes=[1 2;3 4;5 6;7 8;9 10;11 12;13 14;15 16];
        if RunAcuityAnalysis==1
            for betaA=1:(betamax/4)
               EventNames{resorttrack,1}=sprintf('E%sL',num2str(AcuityEventCodes(betaA,1)));
               resorttrack=resorttrack+1;
               EventNames{resorttrack,1}=sprintf('E%sR',num2str(AcuityEventCodes(betaA,1)));
               resorttrack=resorttrack+1;
               EventNames{resorttrack,1}=sprintf('E%sL',num2str(AcuityEventCodes(betaA,2)));
               resorttrack=resorttrack+1;
               EventNames{resorttrack,1}=sprintf('E%sR',num2str(AcuityEventCodes(betaA,2)));
               resorttrack=resorttrack+1;
            end
        elseif RunContrastAnalysis ==1
            for betaA=1:(betamax/4)
               EventNames{resorttrack,1}=sprintf('E%sL',num2str(ContrastEventCodes(betaA,1)));
               resorttrack=resorttrack+1;
               EventNames{resorttrack,1}=sprintf('E%sR',num2str(ContrastEventCodes(betaA,1)));
               resorttrack=resorttrack+1;
               EventNames{resorttrack,1}=sprintf('E%sL',num2str(ContrastEventCodes(betaA,2)));
               resorttrack=resorttrack+1;
               EventNames{resorttrack,1}=sprintf('E%sR',num2str(ContrastEventCodes(betaA,2)));
               resorttrack=resorttrack+1;
            end
        else
            for betaA=1:(betamax/2)
               EventNames{resorttrack,1}=sprintf('E%sL',num2str(betaA));
               resorttrack=resorttrack+1;
               EventNames{resorttrack,1}=sprintf('E%sR',num2str(betaA));
               resorttrack=resorttrack+1;
            end
        end
        [sessions trials WindowSize]=size(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).(EventNames{1,1}));
        EventNum=0;
        totalplots=betamax/2+totalplots;
        for betaA=1:4:betamax

            EventNum=EventNum+1;
            MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).EventNum=EventNum;
                        trialtrackerL=1;
                        trialtrackerR=1;
                    for BetaC=1:sessions
                        for BetaD=1:trials
                            MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).MergedWaveFormsL(EventNum,trialtrackerL,1:WindowSize)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).(EventNames{betaA,1})(BetaC,BetaD,1:WindowSize);
                            %All EventNameChecker's are for debugging.
                            %MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).EventNameCheckerL{EventNum,trialtrackerL}=EventNames{betaA,1};
                            MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).MergedWaveFormsR(EventNum,trialtrackerR,1:WindowSize)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).(EventNames{(betaA+1),1})(BetaC,BetaD,1:WindowSize);
                            %MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).EventNameCheckerR{EventNum,trialtrackerR}=EventNames{(betaA+1),1};
                            trialtrackerL=trialtrackerL+1;
                            trialtrackerR=trialtrackerR+1;
                            MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).MergedWaveFormsL(EventNum,trialtrackerL,1:WindowSize)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).(EventNames{(betaA+2),1})(BetaC,BetaD,1:WindowSize);
                            %MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).EventNameCheckerL{EventNum,trialtrackerL}=EventNames{(betaA+2),1};
                            MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).MergedWaveFormsR(EventNum,trialtrackerR,1:WindowSize)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).(EventNames{(betaA+3),1})(BetaC,BetaD,1:WindowSize);
                            %MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).EventNameCheckerR{EventNum,trialtrackerR}=EventNames{(betaA+3),1};
                            trialtrackerL=trialtrackerL+1;
                            trialtrackerR=trialtrackerR+1;
                        end
                    end
            for betaB=1:WindowSize
                MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormL(EventNum,betaB)=mean(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).MergedWaveFormsL(EventNum,1:trialtrackerL-1,betaB));
                MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormR(EventNum,betaB)=mean(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).MergedWaveFormsR(EventNum,1:trialtrackerR-1,betaB));
            end
            if RunAcuityAnalysis==1
                if EventNum==1
                    %Determine Window Size (using best acuity average waveform)
                    clear TemplatePeakL TemplatePeakR
                    TemplatePeakL=min(min(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormL(MaximumAcuityEvent,1:WindowSize)));
                    TemplatePeakR=min(min(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormR(MaximumAcuityEvent,1:WindowSize)));
                    AcuityReferencePeakL=find(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormL(MaximumAcuityEvent,1:WindowSize)==TemplatePeakL);
                    AcuityReferencePeakR=find(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormR(MaximumAcuityEvent,1:WindowSize)==TemplatePeakR);
                    
                    Acuity_LH_Min=(AcuityReferencePeakL+(round((DetectAcuityPeakWin(1,1)/100)*WindowSize)));
                    Acuity_LH_Max=(AcuityReferencePeakL+(round((DetectAcuityPeakWin(1,2)/100)*WindowSize)));
                    Acuity_RH_Min=(AcuityReferencePeakR+(round((DetectAcuityPeakWin(1,1)/100)*WindowSize)));
                    Acuity_RH_Max=(AcuityReferencePeakR+(round((DetectAcuityPeakWin(1,2)/100)*WindowSize)));
                   
                    AcuityWindowL=[Acuity_LH_Min Acuity_LH_Max];
                    AcuityWindowR=[Acuity_LH_Min Acuity_LH_Max];
                    %End of Window Size Code
                    MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,1)=min(min(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormL(EventNum,AcuityWindowL(1,1):AcuityWindowL(1,2))));
                    MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,1)=min(min(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormR(EventNum,AcuityWindowR(1,1):AcuityWindowR(1,2))));
                    MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,2)=max(max(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormR(EventNum,AcuityWindowR(1,1):AcuityWindowR(1,2))));
                    MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,2)=max(max(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormL(EventNum,AcuityWindowL(1,1):AcuityWindowL(1,2))));
                    MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).Amplitudes(EventNum,1)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,2)-MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,1);
                    MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).Amplitudes(EventNum,2)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,2)-MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,1);  
                else
                    MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,1)=min(min(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormL(EventNum,AcuityWindowL(1,1):AcuityWindowL(1,2))));
                    MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,1)=min(min(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormR(EventNum,AcuityWindowR(1,1):AcuityWindowR(1,2))));
                    MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,2)=max(max(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormR(EventNum,AcuityWindowR(1,1):AcuityWindowR(1,2))));
                    MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,2)=max(max(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormL(EventNum,AcuityWindowL(1,1):AcuityWindowL(1,2))));
                    MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).Amplitudes(EventNum,1)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,2)-MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,1);
                    MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).Amplitudes(EventNum,2)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,2)-MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,1); 
                end
            elseif RunContrastAnalysis==1
                if EventNum==1
                    %Determine Window Size
                    clear TemplatePeakL TemplatePeakR
                    %TemplatePeakL=min(min(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormL(1,1:WindowSize)));
                    %TemplatePeakR=min(min(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormR(1,1:WindowSize)));

                    %ContrastReferencePeakL=find(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormL(MaximumContrastEvent,1:WindowSize)==TemplatePeakL);
                    %ContrastReferencePeakR=find(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormR(MaximumContrastEvent,1:WindowSize)==TemplatePeakR);
                    
                    %Contrast_LH_Min=(ContrastReferencePeakL+(round((DetectContrastPeakWin(1,1)/100)*WindowSize)));
                    %Contrast_LH_Max=(ContrastReferencePeakL+(round((DetectContrastPeakWin(1,2)/100)*WindowSize)));
                    %Contrast_RH_Min=(ContrastReferencePeakR+(round((DetectContrastPeakWin(1,1)/100)*WindowSize)));
                    %Contrast_RH_Max=(ContrastReferencePeakR+(round((DetectContrastPeakWin(1,2)/100)*WindowSize)));
                   
                    ContrastWindowL=[30 300];
                    ContrastWindowR=[30 300];
                    %End WindowSize Code
                    
                 

                    MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,1)=min(min(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormL(EventNum,ContrastWindowL(1,1):ContrastWindowL(1,2))));
                    MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,1)=min(min(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormR(EventNum,ContrastWindowR(1,1):ContrastWindowR(1,2))));
                    MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,2)=max(max(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormR(EventNum,ContrastWindowR(1,1):ContrastWindowR(1,2))));
                    MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,2)=max(max(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormL(EventNum,ContrastWindowL(1,1):ContrastWindowL(1,2))));
                    MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).Amplitudes(EventNum,1)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,2)-MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,1);
                    MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).Amplitudes(EventNum,2)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,2)-MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,1); 

                
                else
                    MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,1)=min(min(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormL(EventNum,ContrastWindowL(1,1):ContrastWindowL(1,2))));
                    MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,1)=min(min(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormR(EventNum,ContrastWindowR(1,1):ContrastWindowR(1,2))));
                    MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,2)=max(max(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormR(EventNum,ContrastWindowR(1,1):ContrastWindowR(1,2))));
                    MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,2)=max(max(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormL(EventNum,ContrastWindowL(1,1):ContrastWindowL(1,2))));
                    MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).Amplitudes(EventNum,1)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,2)-MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,1);
                    MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).Amplitudes(EventNum,2)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,2)-MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,1); 
                end
            else
                MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,1)=min(min(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormL(EventNum,1:WindowSize)));
                MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,1)=min(min(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormR(EventNum,1:WindowSize)));
                MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,2)=max(max(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormR(EventNum,1:WindowSize)));
                MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,2)=max(max(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormL(EventNum,1:WindowSize)));
                MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).Amplitudes(EventNum,1)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,2)-MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,1);
                MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).Amplitudes(EventNum,2)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,2)-MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,1);
            end
            if Spectral==1 && betaA==1
                win=100;
                over=75;
                shortwin=100;
                shortover=25;
                baselineLH=avgbaselineLH;
                baselineRH=avgbaselineRH;
                newdataLH=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormL(1,:);%Currently we are only looking at the familiar wavefrom.
                newdataRH=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormR(1,:);
figure;
                clear F y f t pbaseLH
                F=0:.1:150;
                [y,f,t,pbaseLH] = spectrogram(baselineLH,win,over,F,1000);
                subplot(2,3,1)
                surf(t,f,10*log10(abs(pbaseLH)),'EdgeColor','none');
                axis xy; axis tight; colormap(jet); view(0,90);
                xlabel('Time');
                ylabel('Frequency (Hz)');
                title('Baseline LFP LH');
MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).pbaseLH=pbaseLH;
                clear y f t pnewLH
                [y,f,t,pnewLH] = spectrogram(newdataLH,win,over,F,1000);
                subplot(2,3,2)
                surf(t,f,10*log10(abs(pnewLH)),'EdgeColor','none');
                axis xy; axis tight; colormap(jet); view(0,90);
                xlabel('Time');
                ylabel('Frequency (Hz)');
                title('New LFP LH');
MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).pnewLH=pnewLH;
                clear pdiffLH
                pdiffLH=(10*log10(abs(pnewLH)))-(10*log10(abs(pbaseLH)));
                subplot(2,3,3)
                surf(t,f,pdiffLH,'EdgeColor','none');
                axis xy; axis tight; colormap(jet); view(0,90);
                xlabel('Time');
                ylabel('Frequency (Hz)');
                title('Difference LFP (New-Baseline) LH');
MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).pdiffLH=pdiffLH;
MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).t=t;
MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).f=f;
                subplot(2,3,4)
                pwelch(baselineLH,win,over,F,1000);
                [pwbaseLH,FwbLH]=pwelch(baselineLH,win,over,F,1000);
MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).pwbaseLH=pwbaseLH;

                subplot(2,3,5)
                pwelch(newdataLH,win,over,F,1000);
                [pwnewLH,FwnLH]=pwelch(newdataLH,win,over,F,1000);
MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).pwnewLH=pwnewLH;
MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).FwnLH=FwnLH;

                subplot(2,3,6)
                pwdiffLH=(10*log10(pwnewLH))-(10*log10(pwbaseLH));
                plot(F,pwdiffLH);
                title('Welch Power Spectral Density Difference Estimate');
                ylabel('Power/frequency (dB/Hz)');
                xlabel('Frequency (Hz)');
                xlim([0 max(F)]);
MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).pwdiffLH=pwdiffLH;



                clear F y f t pbaseRH
                F=0:.1:150;
                [y,f,t,pbaseRH] = spectrogram(baselineRH,win,over,F,1000);
                subplot(2,3,1)
                surf(t,f,10*log10(abs(pbaseRH)),'EdgeColor','none');
                axis xy; axis tight; colormap(jet); view(0,90);
                xlabel('Time');
                ylabel('Frequency (Hz)');
                title('Baseline LFP RH');
MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).pbaseRH=pbaseRH;
                clear y f t pnewRH
                [y,f,t,pnewRH] = spectrogram(newdataRH,win,over,F,1000);
                subplot(2,3,2)
                surf(t,f,10*log10(abs(pnewRH)),'EdgeColor','none');
                axis xy; axis tight; colormap(jet); view(0,90);
                xlabel('Time');
                ylabel('Frequency (Hz)');
                title('New LFP RH');
MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).pnewRH=pnewRH;
                clear pdiffRH
                pdiffRH=(10*log10(abs(pnewRH)))-(10*log10(abs(pbaseRH)));
                subplot(2,3,3)
                surf(t,f,pdiffRH,'EdgeColor','none');
                axis xy; axis tight; colormap(jet); view(0,90);
                xlabel('Time');
                ylabel('Frequency (Hz)');
                title('Difference LFP (New-Baseline) RH');
MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).pdiffRH=pdiffRH;
MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).t=t;
MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).f=f;
                subplot(2,3,4)
                pwelch(baselineRH,win,over,F,1000);
                [pwbaseRH,FwbRH]=pwelch(baselineRH,win,over,F,1000);
MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).pwbaseRH=pwbaseRH;

                subplot(2,3,5)
                pwelch(newdataRH,win,over,F,1000);
                [pwnewRH,FwnRH]=pwelch(newdataRH,win,over,F,1000);
MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).pwnewRH=pwnewRH;
MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).FwnRH=FwnRH;

                subplot(2,3,6)
                pwdiffRH=(10*log10(pwnewRH))-(10*log10(pwbaseRH));
                plot(F,pwdiffRH);
                title('Welch Power Spectral Density Difference Estimate');
                ylabel('Power/frequency (dB/Hz)');
                xlabel('Frequency (Hz)');
                xlim([0 max(F)]);
MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).pwdiffRH=pwdiffRH;
            end
        end
    end


    if RunSrpAnalysis==1
        if exist('EndPlotData')==1
            clear EndPlotData
        end
        figLH=figure;
        figRH=figure;
        EndPlotData{1,1}='File Name';
        maxminL=0;
        maxmaxL=0;
        maxminR=0;
        maxmaxR=0;
        for alpha=1:alphamax
            EndPlotData{alpha+1,1}=fname{1,alpha};
            EventNum=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).EventNum;
            colorvector=lines(EventNum);
            for betaA=1:EventNum
                if betaA ==1
                    figure(figLH);
                    subplot(1,alphamax,alpha);
                    if maxminL > MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(betaA,1)
                        maxminL = MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(betaA,1);
                    end
                    if maxmaxL < MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(betaA,2)
                        maxmaxL = MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(betaA,2);
                    end
                    if maxminR > MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(betaA,1)
                        maxminR = MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(betaA,1);
                    end
                    if maxmaxR < MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(betaA,2)
                        maxmaxR = MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(betaA,2);
                    end
                    plot(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormL(betaA,1:end),'Color',colorvector(betaA,1:end));
                    thetitle=sprintf('LH: %s',fname{1,alpha}(1,1:end-4));
                    legendinfo{betaA}=sprintf('%s',VepEventNames{betaA});
                    title(thetitle,'interpreter','none');
                    figure(figRH);
                    subplot(1,alphamax,alpha);
                    plot(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormR(betaA,1:end),'Color',colorvector(betaA,1:end));
                    thetitle=sprintf('RH: %s',fname{1,alpha}(1,1:end-4));
                    title(thetitle,'interpreter','none');
                    

                    
                else
                    legendinfo{betaA}=sprintf('%s',VepEventNames{betaA});
                    thetitle=sprintf('LH: %s',fname{1,alpha}(1,1:end-4));
                    if maxminL > MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(betaA,1)
                        maxminL = MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(betaA,1);
                    end
                    if maxmaxL < MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(betaA,2)
                        maxmaxL = MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(betaA,2);
                    end
                    if maxminR > MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(betaA,1)
                        maxminR = MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(betaA,1);
                    end
                    if maxmaxR < MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(betaA,2)
                        maxmaxR = MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(betaA,2);
                    end
                    figure(figLH);
                    subplot(1,alphamax,alpha);
                    hold on
                    plot(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormL(betaA,1:end),'Color',colorvector(betaA,1:end));
                    hold off
                    figure(figRH);
                    subplot(1,alphamax,alpha);
                    hold on
                    plot(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AveragedWaveFormR(betaA,1:end),'Color',colorvector(betaA,1:end));
                    hold off
                end
                EndPlotData{1,(betaA*2)}=sprintf('LH %s',VepEventNames{betaA});
                EndPlotData{1,(betaA*2+1)}=sprintf('RH %s',VepEventNames{betaA});
                EndPlotData{alpha+1,(betaA*2)}=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).Amplitudes(betaA,1);%LeftHemisphere
                EndPlotData{alpha+1,(betaA*2+1)}=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).Amplitudes(betaA,2);%RightHemisphere
            end
            
            figure(figLH);
            subplot(1,alphamax,alpha);
            legend(legendinfo);
            figure(figRH);
            subplot(1,alphamax,alpha);
            legend(legendinfo);
            clearvars legendinfo
        end
            MainStructure.(GroupName).EndPlotData=EndPlotData;
            MainStructure.(GroupName).fname=fname;
        for alpha=1:alphamax
            figure(figLH);
            ylim([maxminL-.01 maxmaxL+.01]);
            figure(figRH);
            subplot(1,alphamax,alpha);
            ylim([maxminR-.01 maxmaxR+.01]);
        end
        %clearvars -except figLH figRH DayWaveformStructure EndPlotData MainStructure.(GroupName) fname time

        filename = inputdlg('Input Filename','Saving Data',[1 50]);
        save(filename{1,1}, 'MainStructure');
        filenameLH=sprintf('%s_LeftHemispherePlotData',filename{1,1});
        filenameRH=sprintf('%s_RightHemispherePlotData',filename{1,1});
        saveas(figLH,filenameLH,'epsc');
        saveas(figRH,filenameRH,'epsc');
        %clearvars figLH figRH filename
        MainStructure.GroupNames=GroupNames;
        MainStructure.SrpThresh=SrpThresh;
        if RanWeek2Analysis == 0
        %PERFORM SRP CALCULATIONS
        [preAnimalNum ~]=size(EndPlotData);
        AnimalNum=(preAnimalNum-1)/SrpDays;
        if SrpDays==5
            grouptracker=ones(1,6);
        else
            grouptracker=ones(1,SrpDays);
        end
        for animalloop=2:SrpDays:preAnimalNum
            DayHolder=0;
            if SrpDays < 5
                    while DayHolder<SrpDays
                        groupdata(primaryAlpha,grouptracker(1,DayHolder+1),DayHolder+1)=EndPlotData{animalloop+DayHolder,2}; %LH Familiar Always
                        grouptracker(1,DayHolder+1)=grouptracker(1,DayHolder+1)+1;
                        groupdata(primaryAlpha,grouptracker(1,DayHolder+1),DayHolder+1)=EndPlotData{animalloop+DayHolder,3}; %RH Familiar Always
                        grouptracker(1,DayHolder+1)=grouptracker(1,DayHolder+1)+1;
                        DayHolder=DayHolder+1;
                    end
            end
            if SrpDays == 5
                    while DayHolder<SrpDays
                       if DayHolder==0
                            groupdata(primaryAlpha,grouptracker(1,6),SrpDays+1)=EndPlotData{animalloop+DayHolder,4}; %LH Novel Always
                            grouptracker(1,6)=grouptracker(1,6)+1;
                            groupdata(primaryAlpha,grouptracker(1,6),SrpDays+1)=EndPlotData{animalloop+DayHolder,5}; %RH Novel Always
                            grouptracker(1,6)=grouptracker(1,6)+1;

                            groupdata(primaryAlpha,grouptracker(1,5),SrpDays)=EndPlotData{animalloop+DayHolder,2}; %LH Familiar Always
                            grouptracker(1,5)=grouptracker(1,5)+1;
                            groupdata(primaryAlpha,grouptracker(1,5),SrpDays)=EndPlotData{animalloop+DayHolder,3}; %RH Familiar Always
                            grouptracker(1,5)=grouptracker(1,5)+1;
                            DayHolder=DayHolder+1;
                       else
                            groupdata(primaryAlpha,grouptracker(1,DayHolder),DayHolder)=EndPlotData{animalloop+DayHolder,2}; %LH Familiar Always
                            grouptracker(1,DayHolder)=grouptracker(1,DayHolder)+1;
                            groupdata(primaryAlpha,grouptracker(1,DayHolder),DayHolder)=EndPlotData{animalloop+DayHolder,3}; %RH Familiar Always
                            grouptracker(1,DayHolder)=grouptracker(1,DayHolder)+1;
                            DayHolder=DayHolder+1;
                       end
                    end
            end
        end
        
        threshgroupdata=groupdata;
        [grpanimal grpdata grpdays]=size(groupdata);
        if grpdays==6
            threshdays=5;
        else
            threshdays=grpdays;
        end
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
        
                 if LeyeSRP==1
                    ipsi_index=1:2:length(threshgroupdata(1,:,1));
                    contra_index=2:2:length(threshgroupdata(1,:,1));
                    threshgroupdata_contra=threshgroupdata(:,contra_index,:);
                    threshgroupdata_ipsi=threshgroupdata(:,ipsi_index,:);
                 elseif ReyeSRP==1
                   ipsi_index=2:2:length(threshgroupdata(1,:,1));
                   contra_index=1:2:length(threshgroupdata(1,:,1));
                   threshgroupdata_contra=threshgroupdata(:,contra_index,:);
                   threshgroupdata_ipsi=threshgroupdata(:,ipsi_index,:);
                 end
           grpnumsanimal(1,primaryAlpha)=AnimalNum;
           for i=1:grpanimal
             for j=1:grpdays
                 if BinocSRP==1
                      grpplot(i,j)=nanmean(threshgroupdata(i,:,j)*AmpGain);
                      grperror(i,j)=nanstd(threshgroupdata(i,:,j)*AmpGain)/sqrt(length(find(~isnan(threshgroupdata(i,:,j)))));
                 elseif LeyeSRP==1
                        grpplot_contra(i,j)=nanmean(threshgroupdata_contra(i,:,j)*AmpGain);
                        grpplot_ipsi(i,j)=nanmean(threshgroupdata_ipsi(i,:,j)*AmpGain);
                        grpplot_contra_error(i,j)=nanstd(threshgroupdata_contra(i,:,j)*AmpGain)/sqrt(length(find(~isnan(threshgroupdata_contra(i,:,j)))));
                        grpplot_ipsi_error(i,j)=nanstd(threshgroupdata_ipsi(i,:,j)*AmpGain)/sqrt(length(find(~isnan(threshgroupdata_ipsi(i,:,j)))));
                 elseif ReyeSRP==1
                        grpplot_contra(i,j)=nanmean(threshgroupdata_contra(i,:,j)*AmpGain);
                        grpplot_ipsi(i,j)=nanmean(threshgroupdata_ipsi(i,:,j)*AmpGain);
                        grpplot_contra_error(i,j)=nanstd(threshgroupdata_contra(i,:,j)*AmpGain)/sqrt(length(find(~isnan(threshgroupdata_contra(i,:,j)))));
                        grpplot_ipsi_error(i,j)=nanstd(threshgroupdata_ipsi(i,:,j)*AmpGain)/sqrt(length(find(~isnan(threshgroupdata_ipsi(i,:,j)))));
                 end
             end
             if primaryAlpha==i
                 if exist('grphemis')==1 %Calculates number of group hemispheres
                     if length(grphemis) < primaryAlpha
                         grphemis(1,primaryAlpha)=length(find(~isnan(threshgroupdata(i,:,1))));
                     else
                         grphemis(1,primaryAlpha)=grphemis(1,primaryAlpha)+length(find(~isnan(threshgroupdata(i,:,1))));
                     end
                 else
                     grphemis(1,primaryAlpha)=length(find(~isnan(threshgroupdata(i,:,1))));
                 end
             end
           end
           if primaryAlpha==Groups
               finalsrpfig=figure;
           else
           grpfigure=figure;
           end
           hold on;

           for i=1:grpanimal
               if grpdays==6
                  if BinocSRP==1
                      errorbar(grpplot(i,1:5),grperror(i,1:5),VepEventSymbols{1,grpanimal},'MarkerSize',14,'Color',grpcolors(i,:));
                      novel=nan(1,5);
                      novelerr=nan(1,5);
                      novel(1,5)=grpplot(i,6);
                      novelerr(1,5)=grperror(i,6);
                      errorbar(novel,novelerr,VepEventSymbols{1,grpanimal},'MarkerSize',14,'MarkerFaceColor',grpcolors(i,:),'MarkerEdgeColor',grpcolors(i,:),'Color',grpcolors(i,:));
                  elseif LeyeSRP==1
                      errorbar(grpplot_contra(i,1:5),grpplot_contra_error(i,1:5),VepEventSymbols_contra{1,grpanimal},'MarkerSize',14,'Color',grpcolors(i,:));
                      errorbar(grpplot_ipsi(i,1:5),grpplot_ipsi_error(i,1:5),VepEventSymbols_ipsi{1,grpanimal},'MarkerSize',14,'Color',grpcolors(i,:));
                      novel_contra=nan(1,5);
                      novelerr_contra=nan(1,5);
                      novel_contra(1,5)=grpplot_contra(i,6);
                      novelerr_contra(1,5)=grpplot_contra_error(i,6);
                      novel_ipsi=nan(1,5);
                      novelerr_ipsi=nan(1,5);
                      novel_ipsi(1,5)=grpplot_ipsi(i,6);
                      novelerr_ipsi(1,5)=grpplot_ipsi_error(i,6);
                      errorbar(novel_ipsi,novelerr_ipsi,VepEventSymbols_ipsi{1,grpanimal},'MarkerSize',14,'MarkerFaceColor',grpcolors(i,:),'MarkerEdgeColor',grpcolors(i,:),'Color',grpcolors(i,:));
                      errorbar(novel_contra,novelerr_contra,VepEventSymbols_contra{1,grpanimal},'MarkerSize',14,'MarkerFaceColor',grpcolors(i,:),'MarkerEdgeColor',grpcolors(i,:),'Color',grpcolors(i,:));
                  elseif ReyeSRP==1
                      errorbar(grpplot_contra(i,1:5),grpplot_contra_error(i,1:5),VepEventSymbols_contra{1,grpanimal},'MarkerSize',14,'Color',grpcolors(i,:));
                      errorbar(grpplot_ipsi(i,1:5),grpplot_ipsi_error(i,1:5),VepEventSymbols_ipsi{1,grpanimal},'MarkerSize',14,'Color',grpcolors(i,:));
                      novel_contra=nan(1,5);
                      novelerr_contra=nan(1,5);
                      novel_contra(1,5)=grpplot_contra(i,6);
                      novelerr_contra(1,5)=grpplot_contra_error(i,6);
                      novel_ipsi=nan(1,5);
                      novelerr_ipsi=nan(1,5);
                      novel_ipsi(1,5)=grpplot_ipsi(i,6);
                      novelerr_ipsi(1,5)=grpplot_ipsi_error(i,6);
                      errorbar(novel_ipsi,novelerr_ipsi,VepEventSymbols_ipsi{1,grpanimal},'MarkerSize',14,'MarkerFaceColor',grpcolors(i,:),'MarkerEdgeColor',grpcolors(i,:),'Color',grpcolors(i,:));
                      errorbar(novel_contra,novelerr_contra,VepEventSymbols_contra{1,grpanimal},'MarkerSize',14,'MarkerFaceColor',grpcolors(i,:),'MarkerEdgeColor',grpcolors(i,:),'Color',grpcolors(i,:));
                  end
               else
                  if BinocSRP==1
%                     errorbar(grpplot(i,:),grperror(i,:))
                      errorbar(grpplot(i,:),grperror(i,:),VepEventSymbols{1,grpanimal},'MarkerSize',14,'Color',grpcolors(i,:));
                  elseif LeyeSRP==1
                      errorbar(grpplot_contra(i,:),grpplot_contra_error(i,:),VepEventSymbols_contra{1,grpanimal},'MarkerSize',14,'Color',grpcolors(i,:));
                      errorbar(grpplot_ipsi(i,:),grpplot_ipsi_error(i,:),VepEventSymbols_ipsi{1,grpanimal},'MarkerSize',14,'Color',grpcolors(i,:));
                  elseif ReyeSRP==1
                      errorbar(grpplot_contra(i,:),grpplot_contra_error(i,:),VepEventSymbols_contra{1,grpanimal},'MarkerSize',14,'Color',grpcolors(i,:));
                      errorbar(grpplot_ipsi(i,:),grpplot_ipsi_error(i,:),VepEventSymbols_ipsi{1,grpanimal},'MarkerSize',14,'Color',grpcolors(i,:));
                  end
               end
           end
           clear legendInfo
           if BinocSRP==1
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
           end
           ylabel('Vep Amplitude (microVolts)');
           if grpdays==6
           xticks=linspace(1,grpdays-1,grpdays-1);
           else
           xticks=linspace(1,grpdays,grpdays);
           end
           set(gca,'XTick',xticks)
           xtitle=sprintf('Recording Days\nVep Threshold: %s microVolts',num2str(SrpThresh));
           xlabel(xtitle);
           for i=1:primaryAlpha
           	titletxt{1,i}=sprintf('%s Animals: %s    %s Hemispheres: %s',GroupNames{1,i},num2str(grpnumsanimal(1,i)),GroupNames{1,i},num2str(grphemis(1,primaryAlpha)));
           end
           title(titletxt);
           if Week2Analysis==0
               if primaryAlpha==Groups
                filename = inputdlg('Input Filename for Srp Analysis','Saving Data',[1 50]);
                save(filename{1,1}, 'MainStructure');
                saveas(grpfigure,filename{1,1},'epsc');
                clearvars -except MainStructure RunContraIpsi    
               end
           end
           if Week2Analysis==1 && primaryAlpha==Groups 
                RanWeek2Analysis=1;
                %primaryAlpha=0;%%%%LOOPING BUG HERE
            end
           
        else
            figure(finalsrpfig);
            [filenum EventNum]=size(MainStructure.(GroupName).EndPlotData);
            for i=1:EventNum-1
                for j=1:filenum-1
                    week2plot(j,i)=MainStructure.(GroupName).EndPlotData{j+1,i+1};
                end
            end
            EventNum=(EventNum-1)/2;
            for i=1:EventNum
               week2avg(1,i)=mean([week2plot(:,(2*i-1));week2plot(:,(2*i))]*AmpGain);
               week2err(1,i)=std([week2plot(:,(2*i-1));week2plot(:,(2*i))]*AmpGain)/sqrt((filenum-1)*2);
               day6plot=nan(1,6);
               day6ploterr=nan(1,6);
               day6plot(1,6)=week2avg(1,i);
               day6ploterr(1,6)=week2err(1,i);
               hold on;
               errorbar(day6plot,day6ploterr,VepEventSymbols{1,primaryAlpha},'MarkerSize',12,'Color',grpcolors(i,:));
               legendInfo{1,end+1}=sprintf('%s %s',(GroupName),VepEventNames{1,i});
               
            end
            legend(legendInfo,'interpreter','none');
            xticks=linspace(1,5,5);
            xticks(1,end+1)=14+((EventNum-2)*4)+1;
            set(gca,'XTick',xticks)
            debug=1;
            
        end
	elseif RunAcuityAnalysis==1
        amplitudetrack=1;
        amplitudeloc=ones(1,EventNum);
        %EventNames<events,1>
        clear AnimalAveragesL AnimalAveragesR
        for alpha=1:alphamax
            EventNum=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).EventNum;
            clear EventNameList
            for eventindex=1:2:(EventNum*2)
               FlipL=sprintf('E%sL',num2str(eventindex));
               FlipR=sprintf('E%sR',num2str(eventindex));
               FlopL=sprintf('E%sL',num2str(eventindex+1));
               FlopR=sprintf('E%sR',num2str(eventindex+1));
               [Sessions,Trials,Window]=size(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).(FlipL));
               FlipL_mean=nan(1,Window);
               FlipR_mean=nan(1,Window);
               FlopL_mean=nan(1,Window);
               FlopR_mean=nan(1,Window);
               clear FlipL_Combined FlipR_Combined FlopL_Combined FlopR_Combined
               for SessionIndex=1:Sessions
                  FlipL_Combined((1+(Trials*(SessionIndex-1))):(Trials*SessionIndex),:)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).(FlipL)(SessionIndex,:,:);
                  FlipR_Combined((1+(Trials*(SessionIndex-1))):(Trials*SessionIndex),:)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).(FlipR)(SessionIndex,:,:);
                  FlopL_Combined((1+(Trials*(SessionIndex-1))):(Trials*SessionIndex),:)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).(FlopL)(SessionIndex,:,:);
                  FlopR_Combined((1+(Trials*(SessionIndex-1))):(Trials*SessionIndex),:)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).(FlopR)(SessionIndex,:,:);
               end
               clear FlipL_mean FlipR_mean FlopL_mean FlopR_mean
               for flipflopindex=1:Window
                   FlipL_mean(1,flipflopindex)=mean(FlipL_Combined(:,flipflopindex));
                   FlipR_mean(1,flipflopindex)=mean(FlipR_Combined(:,flipflopindex));
                   FlopL_mean(1,flipflopindex)=mean(FlopL_Combined(:,flipflopindex));
                   FlopR_mean(1,flipflopindex)=mean(FlopR_Combined(:,flipflopindex));
               end
               NormValFlipL=mean(FlipL_mean);
               NormValFlipR=mean(FlipR_mean);
               NormValFlopL=mean(FlopL_mean);
               NormValFlopR=mean(FlopR_mean);
               clear FlipL_norm FlipR_norm FlopL_norm FlopR_norm
               FlipL_norm=FlipL_mean-NormValFlipL;
               FlipR_norm=FlipR_mean-NormValFlipR;
               FlopL_norm=FlopL_mean-NormValFlopL;
               FlopR_norm=FlopR_mean-NormValFlopR;
               clear FlipFlopCombinedNorm
               FlipFlopCombinedNorm(1,:)=FlipL_norm;
               FlipFlopCombinedNorm(2,:)=FlipR_norm;
               FlipFlopCombinedNorm(3,:)=FlopL_norm;
               FlipFlopCombinedNorm(4,:)=FlopR_norm;
               
               for flipflopindex=1:Window
                  AnimalAveragesL(alpha,(eventindex+1)/2,flipflopindex)=mean(FlipFlopCombinedNorm(1:2,flipflopindex));
                  AnimalAveragesR(alpha,(eventindex+1)/2,flipflopindex)=mean(FlipFlopCombinedNorm(2:4,flipflopindex));
               end
            end
            
            
            
            MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AcuityCon=AcuityCon;
            MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AcuityEventCodes=AcuityEventCodes;
            MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AcuityCodes=AcuityCodes;

            for betaA=1:EventNum
                TotalAmplitudes(betaA,amplitudetrack,1)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).Amplitudes(betaA,1);
                TotalAmplitudes(betaA,amplitudetrack,2)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).Amplitudes(betaA,2);
                MergedTotalAmps(betaA,amplitudeloc(1,betaA))=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).Amplitudes(betaA,1);
                amplitudeloc(1,betaA)=amplitudeloc(1,betaA)+1;
                MergedTotalAmps(betaA,amplitudeloc(1,betaA))=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).Amplitudes(betaA,2);
                amplitudeloc(1,betaA)=amplitudeloc(1,betaA)+1;
            end
            
            amplitudetrack=amplitudetrack+1;
        end
        %Threshold Code
        workingthresh=AcuityThresh/1000;
        for alpha=1:alphamax
            if TotalAmplitudes(1,alpha,1)<workingthresh
               TotalAmplitudes(:,alpha,1)=NaN;
               AnimalAveragesL(alpha,:,:)=NaN;
            end
            if TotalAmplitudes(1,alpha,2)<workingthresh
                TotalAmplitudes(:,alpha,2)=NaN;
                AnimalAveragesR(alpha,:,:)=NaN;
            end
        end
        delarray=find(MergedTotalAmps(1,:)<workingthresh);
        for alpha=1:length(delarray)
           MergedTotalAmps(:,delarray(1,alpha))=NaN; 
        end
        
        clear EventWaveforms
        EventWaveforms=[AnimalAveragesL;AnimalAveragesR];
        for alpha=1:EventNum
            for betaA=1:Window
                EventWaveform_mean(alpha,betaA)=nanmean(EventWaveforms(:,alpha,betaA));
            end
        end
        
        MainStructure.(GroupName).EventWaveform_mean(:,:)=EventWaveform_mean;
        for betaA=1:EventNum
            MeanTotalAmp(primaryAlpha,1,betaA)=nanmean(TotalAmplitudes(betaA,:,1)*AmpGain);
            MeanTotalAmpErr(primaryAlpha,1,betaA)=nanstd(TotalAmplitudes(betaA,:,1)*AmpGain)/sqrt(length(find(~isnan(TotalAmplitudes(betaA,:,1)))));
            MeanTotalAmp(primaryAlpha,2,betaA)=nanmean(TotalAmplitudes(betaA,:,2)*AmpGain);
            MeanTotalAmpErr(primaryAlpha,2,betaA)=nanstd(TotalAmplitudes(betaA,:,1)*AmpGain)/sqrt(length(find(~isnan(TotalAmplitudes(betaA,:,1)))));
            MeanMergedAmp(primaryAlpha,1,betaA)=nanmean(MergedTotalAmps(betaA,:)*AmpGain);
            MeanMergedAmpErr(primaryAlpha,1,betaA)=nanstd(MergedTotalAmps(betaA,:)*AmpGain)/sqrt(length(find(~isnan(MergedTotalAmps(betaA,:)))));
        end
        if primaryAlpha==Groups
        %red = left hemisphere, blue = right hemisphere, black = merged
        acuityWaves=figure;
        acuityfig=figure;
        
        hold on;

        for grpplotter=1:Groups
        if ShowMergedAcuity==1
            errorbar(MeanMergedAmp(grpplotter,1,:),MeanMergedAmpErr(grpplotter,1,:),'-+','Color',grpcolors(grpplotter,:));
            if exist('legendInfo')==1
                legendtxt=sprintf('%s Combined Hemisphere',GroupNames{1,grpplotter});
                legendInfo=[legendInfo legendtxt];                
            else
                legendtxt=sprintf('%s Combined Hemisphere',GroupNames{1,grpplotter});
                legendInfo={legendtxt};
            end
        end
        if ShowLHemiAcuity==1
            errorbar(MeanTotalAmp(grpplotter,1,:),MeanTotalAmpErr(grpplotter,1,:),'--o','Color',grpcolors(grpplotter,:));
            if exist('legendInfo')==1
                legendtxt=sprintf('%s Left Hemisphere',GroupNames{1,grpplotter});
                legendInfo=[legendInfo legendtxt];
            else
                legendtxt{1,1}=sprintf('%s Left Hemisphere',GroupNames{1,grpplotter});
                legendInfo={legendtxt};
            end
        end
        if ShowRHemiAcuity==1
            errorbar(MeanTotalAmp(grpplotter,2,:),MeanTotalAmpErr(grpplotter,2,:),'--x','Color',grpcolors(grpplotter,:));
            if exist('legendInfo')==1
                legendtxt=sprintf('%s Right Hemisphere',GroupNames{1,grpplotter});
                legendInfo=[legendInfo legendtxt];
            else
                legendtxt=sprintf('%s Right Hemisphere',GroupNames{1,grpplotter});
                legendInfo={legendtxt};
            end
        end
        end
        legend(legendInfo);
        set(gca,'xtickLabel',AcuityCodes)
        xaxistitle=sprintf('Spatial Frequency (cycles/degree)\nContrast: %s',AcuityCon{1,1});
        xlabel(xaxistitle);ylabel('VEP Amplitude (microVolts)');
        
        figure(acuityWaves)
        maxchecker=0;
        minchecker=0;
        for grpplotter=1:Groups
            GroupName=GroupNames{1,grpplotter};
            for betaA=1:EventNum
                subplot(Groups,EventNum,(betaA+((grpplotter-1)*EventNum)))
                testmax=max(max(MainStructure.(GroupName).EventWaveform_mean(betaA,:)));
                testmin=min(min(MainStructure.(GroupName).EventWaveform_mean(betaA,:)));
                if minchecker > testmin
                    minchecker=testmin;
                end
                if maxchecker < testmax
                    maxchecker=testmax;
                end
                plot(MainStructure.(GroupName).EventWaveform_mean(betaA,:))
                if grpplotter==1
                   thetitle=sprintf('%s (cyc/deg)',AcuityCodes{1,betaA});
                   title(thetitle);
                end
                if betaA==1
                    ytitle=sprintf('Group %s',num2str(grpplotter));
                    ylabel(ytitle);
                end
                if grpplotter==Groups
                    xtitle=sprintf('Time (ms)');
                    xlabel(xtitle);
                end
                
            end
        end
        for grpplotter=1:Groups
           for betaA=1:EventNum
               subplot(Groups,EventNum,(betaA+((grpplotter-1)*EventNum)))
               ylim([minchecker maxchecker]);
           end
        end
        filename = inputdlg('Input Filename for Acuity Analysis','Saving Data',[1 50]);
        save(filename{1,1}, 'MainStructure', 'fname');
        saveas(acuityfig,filename{1,1},'epsc');
        end
    elseif RunContrastAnalysis==1
        amplitudetrack=1;
        amplitudeloc=ones(1,EventNum);
        %EventNames<events,1>
        clear AnimalAveragesL AnimalAveragesR
        for alpha=1:alphamax
            EventNum=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).EventNum;
            clear EventNameList
            for eventindex=1:2:(EventNum*2)
               FlipL=sprintf('E%sL',num2str(eventindex));
               FlipR=sprintf('E%sR',num2str(eventindex));
               FlopL=sprintf('E%sL',num2str(eventindex+1));
               FlopR=sprintf('E%sR',num2str(eventindex+1));
               [Sessions,Trials,Window]=size(MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).(FlipL));
               FlipL_mean=nan(1,Window);
               FlipR_mean=nan(1,Window);
               FlopL_mean=nan(1,Window);
               FlopR_mean=nan(1,Window);
               clear FlipL_Combined FlipR_Combined FlopL_Combined FlopR_Combined
               for SessionIndex=1:Sessions
                  FlipL_Combined((1+(Trials*(SessionIndex-1))):(Trials*SessionIndex),:)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).(FlipL)(SessionIndex,:,:);
                  FlipR_Combined((1+(Trials*(SessionIndex-1))):(Trials*SessionIndex),:)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).(FlipR)(SessionIndex,:,:);
                  FlopL_Combined((1+(Trials*(SessionIndex-1))):(Trials*SessionIndex),:)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).(FlopL)(SessionIndex,:,:);
                  FlopR_Combined((1+(Trials*(SessionIndex-1))):(Trials*SessionIndex),:)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).(FlopR)(SessionIndex,:,:);
               end
               clear FlipL_mean FlipR_mean FlopL_mean FlopR_mean
               for flipflopindex=1:Window
                   FlipL_mean(1,flipflopindex)=mean(FlipL_Combined(:,flipflopindex));
                   FlipR_mean(1,flipflopindex)=mean(FlipR_Combined(:,flipflopindex));
                   FlopL_mean(1,flipflopindex)=mean(FlopL_Combined(:,flipflopindex));
                   FlopR_mean(1,flipflopindex)=mean(FlopR_Combined(:,flipflopindex));
               end
               NormValFlipL=mean(FlipL_mean);
               NormValFlipR=mean(FlipR_mean);
               NormValFlopL=mean(FlopL_mean);
               NormValFlopR=mean(FlopR_mean);
               clear FlipL_norm FlipR_norm FlopL_norm FlopR_norm
               FlipL_norm=FlipL_mean-NormValFlipL;
               FlipR_norm=FlipR_mean-NormValFlipR;
               FlopL_norm=FlopL_mean-NormValFlopL;
               FlopR_norm=FlopR_mean-NormValFlopR;
               clear FlipFlopCombinedNorm
               FlipFlopCombinedNorm(1,:)=FlipL_norm;
               FlipFlopCombinedNorm(2,:)=FlipR_norm;
               FlipFlopCombinedNorm(3,:)=FlopL_norm;
               FlipFlopCombinedNorm(4,:)=FlopR_norm;
               
               for flipflopindex=1:Window
                  AnimalAveragesL(alpha,(eventindex+1)/2,flipflopindex)=mean(FlipFlopCombinedNorm(1:2,flipflopindex));
                  AnimalAveragesR(alpha,(eventindex+1)/2,flipflopindex)=mean(FlipFlopCombinedNorm(2:4,flipflopindex));
               end
            end
            
            MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).ContrastSF=ContrastSF;
            MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).ContrastEventCodes=ContrastEventCodes;
            MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).ContrastCodes=ContrastCodes;
        
               for betaA=1:EventNum
                TotalAmplitudes(betaA,amplitudetrack,1)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).Amplitudes(betaA,1);
                TotalAmplitudes(betaA,amplitudetrack,2)=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).Amplitudes(betaA,2);
                MergedTotalAmps(betaA,amplitudeloc(1,betaA))=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).Amplitudes(betaA,1);
                amplitudeloc(1,betaA)=amplitudeloc(1,betaA)+1;
                MergedTotalAmps(betaA,amplitudeloc(1,betaA))=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).Amplitudes(betaA,2);
                amplitudeloc(1,betaA)=amplitudeloc(1,betaA)+1;
               end
            
            amplitudetrack=amplitudetrack+1;
        end     
        
        %Threshold Code
        workingthresh=ContrastThresh/1000;
        for alpha=1:alphamax
            if TotalAmplitudes(1,alpha,1)<workingthresh
               TotalAmplitudes(:,alpha,1)=NaN;
               AnimalAveragesL(alpha,:,:)=NaN;
            end
            if TotalAmplitudes(1,alpha,2)<workingthresh
                TotalAmplitudes(:,alpha,2)=NaN;
                AnimalAveragesR(alpha,:,:)=NaN;
            end
        end        
        delarray=find(MergedTotalAmps(1,:)<workingthresh);
        for alpha=1:length(delarray)
           MergedTotalAmps(:,delarray(1,alpha))=NaN; 
        end        
        clear EventWaveforms
        EventWaveforms=[AnimalAveragesL;AnimalAveragesR];
        for alpha=1:EventNum
            for betaA=1:Window
                EventWaveform_mean(alpha,betaA)=nanmean(EventWaveforms(:,alpha,betaA));
            end
        end
        
        MainStructure.(GroupName).EventWaveform_mean(:,:)=EventWaveform_mean;
        for betaA=1:EventNum
            MeanTotalAmp(primaryAlpha,1,betaA)=nanmean(TotalAmplitudes(betaA,:,1)*AmpGain);
            MeanTotalAmpErr(primaryAlpha,1,betaA)=nanstd(TotalAmplitudes(betaA,:,1)*AmpGain)/sqrt(length(find(~isnan(TotalAmplitudes(betaA,:,1)))));
            MeanTotalAmp(primaryAlpha,2,betaA)=nanmean(TotalAmplitudes(betaA,:,2)*AmpGain);
            MeanTotalAmpErr(primaryAlpha,2,betaA)=nanstd(TotalAmplitudes(betaA,:,1)*AmpGain)/sqrt(length(find(~isnan(TotalAmplitudes(betaA,:,1)))));
            MeanMergedAmp(primaryAlpha,1,betaA)=nanmean(MergedTotalAmps(betaA,:)*AmpGain);
            MeanMergedAmpErr(primaryAlpha,1,betaA)=nanstd(MergedTotalAmps(betaA,:)*AmpGain)/sqrt(length(find(~isnan(MergedTotalAmps(betaA,:)))));
        end
        
        if primaryAlpha == Groups
        %red = left hemisphere, blue = right hemisphere, black = merged
        contrastfig=figure;
        hold on;

       for grpplotter=1:Groups
        if ShowMergedContrast==1
            errorbar(MeanMergedAmp(grpplotter,1,:),MeanMergedAmpErr(grpplotter,1,:),'-+','Color',grpcolors(grpplotter,:));
            if exist('legendInfo')
                legendtxt=sprintf('%s Combined Hemisphere',GroupNames{1,grpplotter});
                legendinfo=[legendinfo legendtxt];                
            else
                legendtxt=sprintf('%s Combined Hemisphere',GroupNames{1,grpplotter});
                legendinfo={legendtxt};
            end
        end
        if ShowLHemiContrast==1
            errorbar(MeanTotalAmp(grpplotter,1,:),MeanTotalAmpErr(grpplotter,1,:),'--o','Color',grpcolors(grpplotter,:));
            if exist('legendInfo')
                legendtxt=sprintf('%s Left Hemisphere',GroupNames{1,grpplotter});
                legendinfo=[legendinfo legendtxt];
            else
                legendtxt{1,1}=sprintf('%s Left Hemisphere',GroupNames{1,grpplotter});
                legendinfo={legendtxt};
            end
        end
        if ShowRHemiContrast==1
            errorbar(MeanTotalAmp(grpplotter,2,:),MeanTotalAmpErr(grpplotter,2,:),'--x','Color',grpcolors(grpplotter,:));
            if exist('legendInfo')
                legendtxt=sprintf('%s Right Hemisphere',GroupNames{1,grpplotter});
                legendinfo=[legendinfo legendtxt];
            else
                legendtxt=sprintf('%s Right Hemisphere',GroupNames{1,grpplotter});
                legendinfo={legendtxt};
            end
        end
        end
        legend(legendinfo,'Location','NorthWest');

        set(gca,'xtickLabel',ContrastCodes)
        xaxistitle=sprintf('Percent Contrast\nSpatial Frequency: %s cycles/degree',ContrastSF{1,1});
        xlabel(xaxistitle);ylabel('VEP Amplitude (microVolts)');
       
    
        filename = inputdlg('Input Filename for Contrast Analysis','Saving Data',[1 50]);
        save(filename{1,1}, 'MainStructure', 'fname');
        saveas(contrastfig,filename{1,1},'epsc');
        return;
        end
    elseif RunContraIpsi==1
        EndPlotData{1,1}='File Name';
        maxminL=0;
        maxmaxL=0;
        maxminR=0;
        maxmaxR=0;
        for alpha=1:alphamax
            EndPlotData{alpha+1,1}=fname{1,alpha};
            EventNum=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).EventNum;
            colorvector=lines(EventNum);
            for betaA=1:EventNum
                if betaA ==1
                    if maxminL > MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(betaA,1)
                        maxminL = MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(betaA,1);
                    end
                    if maxmaxL < MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(betaA,2)
                        maxmaxL = MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(betaA,2);
                    end
                    if maxminR > MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(betaA,1)
                        maxminR = MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(betaA,1);
                    end
                    if maxmaxR < MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(betaA,2)
                        maxmaxR = MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(betaA,2);
                    end
                else
                    if maxminL > MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(betaA,1)
                        maxminL = MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(betaA,1);
                    end
                    if maxmaxL < MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(betaA,2)
                        maxmaxL = MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesL(betaA,2);
                    end
                    if maxminR > MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(betaA,1)
                        maxminR = MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(betaA,1);
                    end
                    if maxmaxR < MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(betaA,2)
                        maxmaxR = MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).AmplitudesR(betaA,2);
                    end
                end
                EndPlotData{1,(betaA*2)}=sprintf('LH %s',VepEventNames{betaA});
                EndPlotData{1,(betaA*2+1)}=sprintf('RH %s',VepEventNames{betaA});
                EndPlotData{alpha+1,(betaA*2)}=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).Amplitudes(betaA,1);%LeftHemisphere
                EndPlotData{alpha+1,(betaA*2+1)}=MainStructure.(GroupName).(fname{1,alpha}(1,1:end-4)).Amplitudes(betaA,2);%RightHemisphere
            end
        end

            MainStructure.(GroupName).EndPlotData=EndPlotData;
            MainStructure.(GroupName).fname=fname;
        %PERFORM Contra/Ipsi CALCULATIONS
        %Data must be loaded into the program such that
        %the filenames are organized as follows:
        %Animal_#1_LeftHemisphere_DayN
        %Animal_#1_RightHemisphere_DayN
        %Animal_#2_LeftHemisphere_DayN
        %Animal_#2_RightHemisphere_DayN
        %otherwise the code will not work
        
        [preAnimalNum ~]=size(EndPlotData);
        AnimalNum=(preAnimalNum-1)/2;
        clear workingdata
        if primaryAlpha==1
        groupdata{primaryAlpha,1,1}={'Animal'};
        groupdata{primaryAlpha,1,2}={'IpsiLH'};
        groupdata{primaryAlpha,1,3}={'ContraLH'};
        groupdata{primaryAlpha,1,4}={'ContraIpsiLH'};
        groupdata{primaryAlpha,1,5}={'IpsiRH'};
        groupdata{primaryAlpha,1,6}={'ContraRH'};
        groupdata{primaryAlpha,1,7}={'ContraIpsiRH'};
        end
        workingdata{1,1}={'Animal'};
        workingdata{1,2}={'IpsiLH'};
        workingdata{1,3}={'ContraLH'};
        workingdata{1,4}={'ContraIpsiLH'};
        workingdata{1,5}={'IpsiRH'};
        workingdata{1,6}={'ContraRH'};
        workingdata{1,7}={'ContraIpsiRH'};
        grptracker=0;%helps keep track of animal based on the loop
        %Pattern:
        %grptracker=0,1,2,3,4
        %animalloop=2,4,6,8,10
        %animalloop-grptracker=2,3,4,5,6
        %groupdata is for long-term storage while workingdata is easy to
        %debug and perform the analysis on
        for animalloop=2:2:preAnimalNum
            groupdata{primaryAlpha,animalloop-grptracker,1}=EndPlotData{animalloop,1};
            groupdata{primaryAlpha,animalloop-grptracker,2}=EndPlotData{animalloop,2};
            groupdata{primaryAlpha,animalloop-grptracker,3}=EndPlotData{animalloop,3};
            groupdata{primaryAlpha,animalloop-grptracker,5}=EndPlotData{animalloop+1,3};
            groupdata{primaryAlpha,animalloop-grptracker,6}=EndPlotData{animalloop+1,2};
            
            groupdata{primaryAlpha,animalloop-grptracker,4}=EndPlotData{animalloop,3}/EndPlotData{animalloop,2};
            groupdata{primaryAlpha,animalloop-grptracker,7}=EndPlotData{animalloop+1,2}/EndPlotData{animalloop+1,3};
            
            workingdata{animalloop-grptracker,1}=EndPlotData{animalloop,1};
            workingdata{animalloop-grptracker,2}=EndPlotData{animalloop,2};
            workingdata{animalloop-grptracker,3}=EndPlotData{animalloop,3};
            workingdata{animalloop-grptracker,5}=EndPlotData{animalloop+1,3};
            workingdata{animalloop-grptracker,6}=EndPlotData{animalloop+1,2};
            
            workingdata{animalloop-grptracker,4}=EndPlotData{animalloop,3}/EndPlotData{animalloop,2};
            workingdata{animalloop-grptracker,7}=EndPlotData{animalloop+1,2}/EndPlotData{animalloop+1,3};
            
            grptracker=grptracker+1;
        end
        contipstracker=1;
        for i=2:AnimalNum+1
        ContIpsiTotal(1,contipstracker)=workingdata{i,4}; 
        contipstracker=contipstracker+1;
        ContIpsiTotal(1,contipstracker)=workingdata{i,7};
        contipstracker=contipstracker+1;
        end
        MeanContIpsi=mean(ContIpsiTotal);
        MeanContIpsiErr=std(ContIpsiTotal)/sqrt(length(ContIpsiTotal));
        contraipsigroupdata(1,primaryAlpha)=MeanContIpsi;
        contraipsigroupdataerr(1,primaryAlpha)=MeanContIpsiErr;
        
    end
    primaryAlpha=primaryAlpha+1;
    MainStructure.(GroupName).SrpDays=SrpDays;
    MainStructure.(GroupName).RecFreq=RecordingFreq;
    MainStructure.(GroupName).AmpGain=AmpGain;
 end
if RunContraIpsi==1
   ContraIpsiFig=figure;
   hold on;

   
   for i=1:Groups
      bar([i],[contraipsigroupdata(1,i)],'FaceColor',grpcolors(i,:))
      line([i i],[contraipsigroupdata(1,i) contraipsigroupdata(1,i)+contraipsigroupdataerr(1,i)],'Color',grpcolors(i,:));
      line([i-.2 i+.2],[contraipsigroupdata(1,i)+contraipsigroupdataerr(1,i) contraipsigroupdata(1,i)+contraipsigroupdataerr(1,i)],'Color',grpcolors(i,:));
      yvalues=get(gca,'ylim');
      if contraipsigroupdata(1,i)+contraipsigroupdataerr(1,i) > yvalues(1,2)
          ylim([0 contraipsigroupdata(1,i)+3*contraipsigroupdataerr(1,i)])
      end
   end
   
   xlim([0 Groups+1]);
   xticks=linspace(1, Groups,Groups);
   set(gca,'XTick',xticks)
   set(gca,'xtickLabel',GroupNames)
   ytitle=sprintf('Contra / Ipsi Ratio',num2str(SrpThresh));
   ylabel(ytitle);
    filename = inputdlg('Input Filename for ContraIpsi Analysis','Saving Data',[1 50]);
    save(filename{1,1}, 'MainStructure', 'fname');
    saveas(ContraIpsiFig,filename{1,1},'epsc');
end
clear RunContraIpsi
% else RunConAcuAnalysis == 1
%             %Basic framework for more complex analysis. [Example: Page 82 of
%             %Muhammad's Thesis]
%             [fileNameAcu, pathNameAcu, filterIndexAcu] = uigetfile('*.mat', 'Ctrl+Click To Select Acuity Files','MultiSelect', 'off');
%             [fileNameCon, pathNameCon, filterIndexCon] = uigetfile('*.mat', 'Ctrl+Click To Select Contrast Files','MultiSelect', 'off');
%             filelocation = sprintf('%s%s',pathNameAcu,fileNameAcu);
%             load(filelocation,'MainStructure.(GroupName)');
%             AcuityData=MainStructure.(GroupName);
%             clear MainStructure.(GroupName)
% 
%             filelocation = sprintf('%s%s',pathNameCon,fileNameCon);
%             load(filelocation,'MainStructure.(GroupName)');
%             ContrastData=MainStructure.(GroupName);
%             clear MainStructure.(GroupName)
% 
%             clearvars -except AcuityData ContrastData
% end
