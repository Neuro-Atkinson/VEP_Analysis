function varargout = SRPAnalysis_Master(varargin)
% SRPANALYSIS_MASTER MATLAB code for SRPAnalysis_Master.fig
%      SRPANALYSIS_MASTER, by itself, creates a new SRPANALYSIS_MASTER or raises the existing
%      singleton*.
%
%      H = SRPANALYSIS_MASTER returns the handle to a new SRPANALYSIS_MASTER or the handle to
%      the existing singleton*.
%
%      SRPANALYSIS_MASTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SRPANALYSIS_MASTER.M with the given input arguments.
%
%      SRPANALYSIS_MASTER('Property','Value',...) creates a new SRPANALYSIS_MASTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SRPAnalysis_Master_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SRPAnalysis_Master_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SRPAnalysis_Master

% Last Modified by GUIDE v2.5 04-Aug-2014 11:10:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SRPAnalysis_Master_OpeningFcn, ...
                   'gui_OutputFcn',  @SRPAnalysis_Master_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before SRPAnalysis_Master is made visible.
function SRPAnalysis_Master_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SRPAnalysis_Master (see VARARGIN)

% Choose default command line output for SRPAnalysis_Master
handles.output = hObject;
handles.forceclose=0;
outputstr=get(handles.SRP_display_output_folder,'String');
if strcmp(outputstr,'Current Matlab Folder')==1
    setappdata(0,'Output_Folder',[]);
end
% Update handles structure
guidata(hObject, handles);
set(gcf,'CloseRequestFcn',@modified_closefcn)
% UIWAIT makes SRPAnalysis_Master wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SRPAnalysis_Master_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function modified_closefcn(hObject, eventdata, handles)
CloseCheck = guidata(hObject);
if CloseCheck.forceclose==1
    delete(hObject);
else
    AnalysisHandles = guidata(AnalysisProgram);
    currentprogs=getappdata(0,'RunningPrograms');
    indicatornames=getappdata(0,'ProgramNames');
    currentprogs(1,1)=0;
    setappdata(0,'RunningPrograms',currentprogs);
    set(AnalysisHandles.(indicatornames{1,1}),'Backgroundcolor','r');
    delete(hObject); 
end


% --- Executes on button press in SRPOptionsButton.
function SRPOptionsButton_Callback(hObject, eventdata, handles)
% hObject    handle to SRPOptionsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SrpOptions_General
setappdata(0,'SRP_options_confirmed',1);
set(handles.SRPSettingsIndicator,'Backgroundcolor',[1 .6 0]);


% --- Executes on button press in GroupOptionsButton.
function GroupOptionsButton_Callback(hObject, eventdata, handles)
% hObject    handle to GroupOptionsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GroupOptions_SRP
setappdata(0,'Group_options_confirmed',1);
set(handles.GroupSettingsIndicator,'Backgroundcolor',[1 .6 0]);





% --- Executes on button press in SRP_clear_processed.
function SRP_clear_processed_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_clear_processed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 handles=rmfield(handles,'MainStructure'); 
 set(handles.SRP_cleandata,'Enable','off');
 set(handles.SRP_clear_processed,'Enable','off');
 set(handles.SRP_run_analysis,'Enable','on');
 set(handles.SRPCleanDataIndicator,'Backgroundcolor',[1 0 0]);
    checkprocessed=get(handles.plot_loaded,'Visible');
    if strcmp(checkprocessed,'off')
        set(handles.SRP_plotoptions_text,'BackgroundColor',[1 0 0]);
        set(handles.SRP_plotoptions_text,'String','No Data Available');
        handles.processed_loaded=0;
    end
 set(handles.plot_processed,'Visible','off');
 guidata(hObject, handles);
 



% --------------------------------------------------------------------
function guioptions_Callback(hObject, eventdata, handles)
% hObject    handle to guioptions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function forceclose_Callback(hObject, eventdata, handles)
% hObject    handle to forceclose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.forceclose=1;
set(hObject,'Checked','on');
guidata(hObject, handles);


% --- Executes on button press in SRP_export_data.
function SRP_export_data_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_export_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in SRP_run_analysis.
function SRP_run_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_run_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.SRP_workload,'Backgroundcolor',[0 1 0]);


handles=buttons_off(hObject,handles);
drawnow;
%Load SRP Related Options
SRP_Options_working=getappdata(0,'SRP_options');
%1-3 (binoc,leye,reye)
%4 vidget
%5 extract all waveform amplitudes
%6 SRP threshold
%7 SRP days
%8 num flips (not currently used... for future functionality)
%9 num flops (not currently used... for future functionality)
%10 num trials
%11 maximum number of events encountered through the data processing
%12 week 2 srp check
%13 Vidget pre start time
%14 Vidget post start time
%15 Gray Extract
SRP_GroupOptions_working=getappdata(0,'SRP_group_options');
%1 total group number
%2-6 group names for groups 1 - 5
%7-11 group colors for groups 1 - 5
%12 group 1 file names
%13 group 1 pathname
%14 group 2 filenames
%15 group 2 pathnames
%17 group 3 filenames
%18 group 3 pathnames
%19 group 4 filenames
%20 group 4 pathnames
%21 group 5 filenames
%22 group 5 pathnames
General_Options_working=getappdata(0,'GS_options');
%1 recording frequency
%2 gain setting used for recording
%3 total channels in data files
%4 left hemisphere channel #
%5 right hemisphere channel #
%6 vidget channel #
%7 strobe channel #
%8 event 1 channel #
%9 event 2 channel #
%10 event 3 channel #
%11 event 4 channel #
%12 event 1 binary conversion threshold
%13 event 2 binary conversion threshold
%14 event 3 binary conversion threshold
%15 event 4 binary conversion threshold
%16 binary converted strobe channel (in the newly created binary structure)
%17 binary converted event 1 channel (in the newly created binary structure)
%18 binary converted event 2 channel (in the newly created binary structure)
%19 binary converted event 3 channel (in the newly created binary structure)
%20 binary converted event 4 channel (in the newly created binary structure)
%21 normalize extracted waveforms
%22 confirm threshold
%23 strobe binary conversion threshold
%24 total digital channels (in the newly created binary structure)

%Load Options
AmpGain = str2num(General_Options_working{2,2});
SrpThresh = str2num(SRP_Options_working{6,2});
NUM_events = 4; %There are always going to be 4 event channels for now
StrobeThresh = str2num(General_Options_working{23,2});
StrobeDig = str2num(General_Options_working{16,2});
StrobeChannel = str2num(General_Options_working{7,2});
VidgetChannel = str2num(General_Options_working{6,2});

EventChan1Thresh = str2num(General_Options_working{12,2});
Event1Dig = str2num(General_Options_working{17,2});
EventChan1 = str2num(General_Options_working{8,2});

EventChan2Thresh = str2num(General_Options_working{13,2});
Event2Dig = str2num(General_Options_working{18,2});
EventChan2 = str2num(General_Options_working{9,2});

EventChan3Thresh = str2num(General_Options_working{14,2});
Event3Dig = str2num(General_Options_working{19,2});
EventChan3 = str2num(General_Options_working{10,2});

EventChan4Thresh = str2num(General_Options_working{15,2});
Event4Dig = str2num(General_Options_working{20,2});
EventChan4 = str2num(General_Options_working{11,2});

totalgroups = str2num(SRP_GroupOptions_working{1,2});
srpdays = str2num(SRP_Options_working{7,2});
TotalChans = str2num(General_Options_working{3,2});
TotalDigitalChans = str2num(General_Options_working{24,2});
RecordingFreq = str2num(General_Options_working{1,2});
NormalizedAmplitudes = General_Options_working{21,2};

%Vidget Options
pre_start_size = str2num(SRP_Options_working{13,2});
post_start_size = str2num(SRP_Options_working{14,2});
EventNumber = str2num(SRP_Options_working{11,2});
RunVidget = SRP_Options_working{4,2};
session_number= str2num(SRP_Options_working{10,2});
GrayExtract=str2num(SRP_Options_working{15,2});

%Extract Waveform Amplitude Options
IndividualWaveformAmplitudes = SRP_Options_working{5,2};

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

GroupNames{1,1}=SRP_GroupOptions_working{2,2};
GroupNames{1,2}=SRP_GroupOptions_working{3,2};
GroupNames{1,3}=SRP_GroupOptions_working{4,2};
GroupNames{1,4}=SRP_GroupOptions_working{5,2};
GroupNames{1,5}=SRP_GroupOptions_working{6,2};

for groupnum=1:totalgroups
    grpcolors(groupnum,:)=SRP_GroupOptions_working{groupnum+6,2};
    %7-11 group colors for groups 1 - 5
    clear totalfiles groupfiles pathname
    GroupName=GroupNames{1,groupnum};
    %Determine total animals in each group as we loop through the groups
    
    groupfiles=SRP_GroupOptions_working{10+2*groupnum,2}; %10+2*groupnum offsets for how data is stored in structure.
    totalfiles=length(groupfiles);
    animalnum(1,groupnum)=totalfiles/srpdays;
    
    pathname=SRP_GroupOptions_working{11+2*groupnum,2};
    
    for filenum=1:totalfiles
        output=sprintf('Processing Group (%s/%s) File (%s/%s)',num2str(groupnum),num2str(totalgroups),num2str(filenum),num2str(totalfiles));
        set(handles.SRP_workload,'String',output);
        drawnow;
        combofilename=sprintf('%s%s',pathname,groupfiles{1,filenum});
        
        if strcmp(groupfiles{1,filenum}(1,(end-3):end),'.dat')
            fileID = fopen(combofilename);
            A = fread(fileID,inf,'float');
            filelength=length(A);
            clear A;
            Data = multibandread(combofilename, [1 (filelength/TotalChans) TotalChans], 'float', 0, 'bip', 'ieee-le' );
            fclose(fileID);
        elseif strcmp(groupfiles{1,filenum}(1,(end-3):end),'.bin')
            fileID = fopen(combofilename);

            A = fread(fileID,'double','ieee-le');
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
            fclose(fileID);
            clear A;
        else
            error('Data files should be in *.dat (old files) or *.bin (new files)');
        end
        DataLength=length(Data);
        DigitalChans=zeros(TotalDigitalChans,DataLength);
    
        %Generate Timepoint Vector
        if RunVidget == 1
            for Vidlist=1:length(Window_settings2)
                EventVidgetTracker(1,Vidlist)=1; 
            end
        end
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
        EventTracker=1;
        tracervalue=1;        
        for i=2:2:length(FlipFlopPoints)
            if FlipFlopPoints(i) < length(Data(1,1:end,1))
                FlipFlopDiffs(1,tracervalue)=Timepoints(1,FlipFlopPoints(i))-Timepoints(1,FlipFlopPoints(i-1));
                tracervalue=tracervalue+1;
            end 
        end
        
        OffsetRegionStart=find(FlipFlopDiffs < (mean(FlipFlopDiffs)-.01));
        if isempty(OffsetRegionStart)
            msgbox('Error','All flip flops are same size... need short first window');
            break;
        end
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
            while doloop==1
               if DigitalChans(StrobeDig,(startcheck-CorrectionIndex(1,i)))==0 && i ~= 1
                    CorrectionIndex(1,i)=CorrectionIndex(1,i)+1;
               else
                    doloop=0;
                    jittercorrect=5;
               end
           end
           FlipFlopCorrection=startcheck-CorrectionIndex(1,i);
           CorrectedRegionStart(1,i)=CorrectedRegionStart(1,i)-1;
           FlipFlopPoints(1,CorrectedRegionStart(1,i))=FlipFlopCorrection+jittercorrect;
           if i==1
               %DoNothing
           else
                StopPoints(1,i-1)=Timepoints(1,FlipFlopPoints(1,CorrectedRegionStart(1,i)-1));
           end
        end
        WindowSize=length(Timepoints(FlipFlopPoints(1,3):FlipFlopPoints(1,4)))-5;
        if rem(WindowSize,2)~=1
            WindowSize=WindowSize-1; %Smaller size so we don't go outside the bounding box (FlipFlopPoints)
        end
        if WindowSize ~= 495
            WindowSize=495;
        end
        WindowNum=1;
        clear RegionSmallWin
        clear MergedWaveForm
        for i=1:length(CorrectedRegionStart)
            if i < length(CorrectedRegionStart)
                Start=CorrectedRegionStart(i);
                Stop=CorrectedRegionStart(i+1)-1;
            else
                Start=CorrectedRegionStart(i);
                Stop=length(FlipFlopPoints);
            end
            WindowNum=1;
            Tracker=struct();
            for j=Start:Stop
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
                    
                    
%                     waveview=figure;
%                     subplot(2,1,1)
%                     plot(DigitalChans(2,(EventLocation-500:EventLocation+500)),'Color','r');
%                     hold on;
%                     plot(Data(1,(EventLocation-500:EventLocation+500),1),'Color','b');
%                     plot(Data(1,(EventLocation-500:EventLocation+500),2),'Color','g');
%                     line([500 500],[0 2],'LineWidth',2,'Color','m');
%                     subplot(2,1,2)
%                     plot(DigitalChans(3,(EventLocation-500:EventLocation+500)),'Color','r');
%                     line([500 500],[0 2],'LineWidth',2,'Color','m');
%                     title(EventSum);
%                     pause;
%                     close(waveview);
                    
                    
                    if EventSum==0
                        if i > 1 && OldEventSum ~= 15
                            if LeftTrack < 5
                                FlipFlopPoints(j)=FlipFlopPoints(j)-10; %will need to change 20 to reflect a percent of the current recording frequency. 
                                LeftTrack=LeftTrack+1;
                            else
                                if RightTrack==0
                                    FlipFlopPoints(j)=originalJ;
                                end
                                FlipFlopPoints(j)=FlipFlopPoints(j)+10;
                                RightTrack=RightTrack+1;
                            end
                            if RightTrack>5
                                errormsg=sprintf('Error:Could not find session start at location %s',num2str(originalJ));
                                errordlg(errormsg,'Error');
                                return;
                            end
                        else
                        	EventSum=16;
                        end
                    end
                end
                if j==Start
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
                                    baselineLH(baselinetracker,1:495)=Data(1,baseindex:baseindex+494,1)-mean(Data(1,baseindex:baseindex+30,1));
                                    baselineRH(baselinetracker,1:495)=Data(1,baseindex:baseindex+494,2)-mean(Data(1,baseindex:baseindex+30,2));
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

                    if RunVidget==1
                        vidgetsum=0;
                        for vidgetextract=1:length(EventMatrix(:,1))
                            if EventSum==EventMatrix(vidgetextract,1)
                                vidgetsum=vidgetsum+1;
                            end
                        end
                        if vidgetsum ~= 0
                            for vidgetextract=1:length(EventMatrix(:,1))
                                VidgetList(1,vidgetextract)=EventMatrix(vidgetextract,1);
                            end
                            vidgetlocation=find(VidgetList==EventSum);
                            DataStructure.DataName{1,(3*vidgetlocation)}(:,EventVidgetTracker(1,vidgetlocation))=Data(1,StartExtract:EndExtract,VidgetChannel);
                            DataStructure.LFP_LH{1,(3*vidgetlocation)}(:,EventVidgetTracker(1,vidgetlocation))=Data(1,StartExtract:EndExtract,1);
                            DataStructure.LFP_RH{1,(3*vidgetlocation)}(:,EventVidgetTracker(1,vidgetlocation))=Data(1,StartExtract:EndExtract,2);
                            DataStructure.Event1{1,(3*vidgetlocation)}(:,EventVidgetTracker(1,vidgetlocation))=Data(1,StartExtract:EndExtract,EventChan1);
                            DataStructure.Event2{1,(3*vidgetlocation)}(:,EventVidgetTracker(1,vidgetlocation))=Data(1,StartExtract:EndExtract,EventChan2);
                            DataStructure.Event3{1,(3*vidgetlocation)}(:,EventVidgetTracker(1,vidgetlocation))=Data(1,StartExtract:EndExtract,EventChan3);
                            DataStructure.Event4{1,(3*vidgetlocation)}(:,EventVidgetTracker(1,vidgetlocation))=Data(1,StartExtract:EndExtract,EventChan4);
                            EventVidgetTracker(1,vidgetlocation)=EventVidgetTracker(1,vidgetlocation)+1;
                        end
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
                    EventTracker=EventTracker+1;
                else
                    if mod(EventSum,2)~=0
                        if any(EventChart==EventSum)
                            %DoNothing
                        else
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

                if LocationChart(1,locspot)==6
                    debug=1;
                end
                ActualLocation=FlipFlopPoints(j);
                EndLocation=FlipFlopPoints(j)+WindowSize-1;
                if NormalizedAmplitudes==0
                    handles.MainStructure.(GroupName).(groupfiles{1,filenum}(1,1:end-4)).(WavNameL)(LocationChart(1,locspot),Tracker.(WavNameL)(1,1),1:WindowSize)=Data(1,ActualLocation:EndLocation,1);
                    handles.MainStructure.(GroupName).(groupfiles{1,filenum}(1,1:end-4)).(WavNameR)(LocationChart(1,locspot),Tracker.(WavNameR)(1,1),1:WindowSize)=Data(1,ActualLocation:EndLocation,2);
                else
                    handles.MainStructure.(GroupName).(groupfiles{1,filenum}(1,1:end-4)).(WavNameL)(LocationChart(1,locspot),Tracker.(WavNameL)(1,1),1:WindowSize)=Data(1,ActualLocation:EndLocation,1)-mean(Data(1,ActualLocation:EndLocation,1));
                    handles.MainStructure.(GroupName).(groupfiles{1,filenum}(1,1:end-4)).(WavNameR)(LocationChart(1,locspot),Tracker.(WavNameR)(1,1),1:WindowSize)=Data(1,ActualLocation:EndLocation,2)-mean(Data(1,ActualLocation:EndLocation,2));
                end

                handles.MainStructure.(GroupName).(groupfiles{1,filenum}(1,1:end-4)).(WavNameTimes)(LocationChart(1,locspot),Tracker.(WavNameL)(1,1),1:WindowSize)=Timepoints(ActualLocation:EndLocation);
                handles.MainStructure.(GroupName).(groupfiles{1,filenum}(1,1:end-4)).(WavNameLocs)(LocationChart(1,locspot),Tracker.(WavNameL)(1,1),1:WindowSize)=ActualLocation:EndLocation;

                if Data(1,ActualLocation,1)==0 || Data(1,ActualLocation,2)==0
                    debug=1;
                end


                Tracker.(WavNameL)(1,1)=Tracker.(WavNameL)(1,1)+1;
                Tracker.(WavNameR)(1,1)=Tracker.(WavNameR)(1,1)+1;

                WindowNum=WindowNum+1;

            end
            
            %Add code to extract gray windows from before the first session
            %only.
            if LocationChart(1,locspot)==1
                GrayStart=GrayExtract*RecordingFreq;
                windownum=1;
                ActualLocation=FlipFlopPoints(1)-(RecordingFreq*2);
                for j = (ActualLocation-GrayStart):500:ActualLocation
                    if windownum < 201
                        GrayLH(windownum,1:495)=Data(1,j:j+494,1)-mean(Data(1,j:j+494,1));
                        GrayRH(windownum,1:495)=Data(1,j:j+494,2)-mean(Data(1,j:j+494,2));
                        windownum=windownum+1;
                        
%                         testfig=figure;
%                         for sp=1:8
%                             subplot(8,1,sp)
%                             plot(Data(1,:,sp))
%                         end
%                         subplot(8,1,4)
%                         hold on
%                         plot([j j],[-10 10],'Color','g');
%                         plot([j+495 j+495],[-10 10],'Color','r');
%                         pause;
%                         close(testfig);
                        
                    end
                end
                handles.MainStructure.(GroupName).(groupfiles{1,filenum}(1,1:end-4)).GrayLH=GrayLH;
                handles.MainStructure.(GroupName).(groupfiles{1,filenum}(1,1:end-4)).GrayRH=GrayRH;
            end
            %End
            
            
            
            LocationChart(1,locspot)=LocationChart(1,locspot)+1;
        end

        hrtz=RecordingFreq;
        if RunVidget==1
            if sum(regexpi(groupfiles{1,filenum},'day5')) > 0 || sum(regexpi(groupfiles{1,filenum},'day_5')) > 0 || sum(regexpi(groupfiles{1,filenum},'novel')) > 0
                save_pathname=getappdata(0,'Output_Folder');
                if isempty(save_pathname)==1
                    save([groupfiles{1,filenum} '_Vidget.mat'],'DataStructure','pre_start_size','post_start_size','Window_settings2','x_vals_time','hrtz');
                else
                    save([save_pathname '\' groupfiles{1,filenum} '_Vidget.mat'],'DataStructure','pre_start_size','post_start_size','Window_settings2','x_vals_time','hrtz');
                end
            else
                save_pathname=getappdata(0,'Output_Folder');
                temp_windowsettings=Window_settings2;
                clear Window_settings2;
                Window_settings2{1,1}=temp_windowsettings{1,1};
                if isempty(save_pathname)==1
                    save([groupfiles{1,filenum} '_Vidget.mat'],'DataStructure','pre_start_size','post_start_size','Window_settings2','x_vals_time','hrtz');
                else
                    save([save_pathname '\' groupfiles{1,filenum} '_Vidget.mat'],'DataStructure','pre_start_size','post_start_size','Window_settings2','x_vals_time','hrtz');
                end
                clear Window_settings2
                Window_settings2=temp_windowsettings;
                clear temp_windowsettings;
            end
            clear DataStructure x_vals_time 
        end
clear CorrectedRegionStart CorrectionIndex TimeStep ActualLocation ActiveEventChans OldEventSum TempSum StopPoints Stop Start StartExtract Timepoints jittercorrect startcheck Data tracervalue FlipFlopPoints OffsetRegionStart FlipFlopDiffs deloffset Tracker EventChart LocationChart locspot
    end
clear CorrectedRegionStart CorrectionIndex ActiveEventChans ActualLocation TimeStep OldEventSum TempSum StopPoints Stop Start StartExtract Timepoints jittercorrect Data tracervalue startcheck FlipFlopPoints OffsetRegionStart FlipFlopDiffs deloffset Tracker EventChart LocationChart locspot   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

output=sprintf('Group %s Processed, Generating Variables...',num2str(groupnum));
set(handles.SRP_workload,'String',output);
drawnow;

[alphamax ~]=size(fieldnames(handles.MainStructure.(GroupName)));

for alpha=1:alphamax
    EventNames=fieldnames(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)));
    [remnamesize ~]=size(EventNames);
    for alphaA=1:(remnamesize/4)
        delname1=sprintf('E%sTimes',num2str(alphaA));
        delname2=sprintf('E%sLocs',num2str(alphaA));
        delname3='GrayLH';
        delname4='GrayRH';
        EventNames(strcmp((delname1),EventNames)) = [];
        EventNames(strcmp((delname2),EventNames)) = [];
        EventNames(strcmp((delname3),EventNames)) = [];
        EventNames(strcmp((delname4),EventNames)) = [];
    end
    EventNames=sort(EventNames);
    handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).EventNames=EventNames;
    [betamax ~]=size(EventNames);
    resorttrack=1;
    [sessions trials WindowSize]=size(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(EventNames{1,1}));
    EventNum=0;
    for betaA=1:4:betamax
        EventNum=EventNum+1;
        handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).EventNum=EventNum;
        trialtrackerL=1;
        trialtrackerR=1;
        for BetaC=1:sessions
            sessionsname1=sprintf('Sessions%s%s',EventNames{(betaA)},EventNames{(betaA+2),1});
            sessionsname2=sprintf('Sessions%s%s',EventNames{(betaA+1)},EventNames{(betaA+3),1});
            sessiontracker1=1;
            sessiontracker2=1;
            for BetaD=1:trials
                handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(sessionsname1)(BetaC,sessiontracker1,1:WindowSize)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(EventNames{betaA,1})(BetaC,BetaD,1:WindowSize);
                sessiontracker1=sessiontracker1+1;
                handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(sessionsname1)(BetaC,sessiontracker1,1:WindowSize)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(EventNames{betaA+2,1})(BetaC,BetaD,1:WindowSize);
                sessiontracker1=sessiontracker1+1;
                handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(sessionsname2)(BetaC,sessiontracker2,1:WindowSize)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(EventNames{betaA+1,1})(BetaC,BetaD,1:WindowSize);
                sessiontracker2=sessiontracker2+1;
                handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(sessionsname2)(BetaC,sessiontracker2,1:WindowSize)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(EventNames{betaA+3,1})(BetaC,BetaD,1:WindowSize);
                sessiontracker2=sessiontracker2+1;            
                handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).MergedWaveFormsL(EventNum,trialtrackerL,1:WindowSize)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(EventNames{betaA,1})(BetaC,BetaD,1:WindowSize);
                %All EventNameChecker's are for debugging.
                handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).MergedWaveFormsR(EventNum,trialtrackerR,1:WindowSize)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(EventNames{(betaA+1),1})(BetaC,BetaD,1:WindowSize);
                trialtrackerL=trialtrackerL+1;
                trialtrackerR=trialtrackerR+1;
                handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).MergedWaveFormsL(EventNum,trialtrackerL,1:WindowSize)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(EventNames{(betaA+2),1})(BetaC,BetaD,1:WindowSize);
                handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).MergedWaveFormsR(EventNum,trialtrackerR,1:WindowSize)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(EventNames{(betaA+3),1})(BetaC,BetaD,1:WindowSize);
                trialtrackerL=trialtrackerL+1;
                trialtrackerR=trialtrackerR+1;
            end
            
                %Code to calculate session waveforms for individual session amplitude detection
            savename1=sprintf('%s_Amps',sessionsname1);
            savename2=sprintf('%s_Amps',sessionsname2);
            for DataPoint=1:WindowSize
                handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(savename1)(BetaC,1,DataPoint)=mean(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(sessionsname1)(BetaC,:,DataPoint));
                handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(savename2)(BetaC,1,DataPoint)=mean(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(sessionsname2)(BetaC,:,DataPoint));
            end
                %End

        end
        for betaB=1:WindowSize
            handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormL(EventNum,betaB)=mean(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).MergedWaveFormsL(EventNum,1:trialtrackerL-1,betaB));
            handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormR(EventNum,betaB)=mean(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).MergedWaveFormsR(EventNum,1:trialtrackerR-1,betaB));
        end
        handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,1)=min(min(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormL(EventNum,1:WindowSize)));
        handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,1)=min(min(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormR(EventNum,1:WindowSize)));
        handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,2)=max(max(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormR(EventNum,1:WindowSize)));
        handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,2)=max(max(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormL(EventNum,1:WindowSize)));
        handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).Amplitudes(EventNum,1)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,2)-handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,1);
        handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).Amplitudes(EventNum,2)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,2)-handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,1);
        if IndividualWaveformAmplitudes==1
            ExtractPeakNameL_Flip=(EventNames{(betaA),1});
            ExtractPeakNameR_Flip=(EventNames{(betaA+1),1});
            ExtractPeakNameL_Flop=(EventNames{(betaA+2),1});
            ExtractPeakNameR_Flop=(EventNames{(betaA+3),1});
            NameRPeaks_Flip=sprintf('%s_AmplitudePeaks',(EventNames{(betaA),1}));
            NameLPeaks_Flip=sprintf('%s_AmplitudePeaks',(EventNames{(betaA+1),1}));
            NameRPeaks_Flop=sprintf('%s_AmplitudePeaks',(EventNames{(betaA+2),1}));
            NameLPeaks_Flop=sprintf('%s_AmplitudePeaks',(EventNames{(betaA+3),1}));
            NameR_Flip=sprintf('%s_Amplitudes',(EventNames{(betaA),1}));
            NameL_Flip=sprintf('%s_Amplitudes',(EventNames{(betaA+1),1}));
            NameR_Flop=sprintf('%s_Amplitudes',(EventNames{(betaA+2),1}));
            NameL_Flop=sprintf('%s_Amplitudes',(EventNames{(betaA+3),1}));
            for sessionNum=1:sessions
                for individualamploop=1:trials
                    %Flips
                    handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(NameLPeaks_Flip)(sessionNum,individualamploop,1)=min(min(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(ExtractPeakNameL_Flip)(sessionNum,individualamploop,:)));
                    handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(NameRPeaks_Flip)(sessionNum,individualamploop,1)=min(min(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(ExtractPeakNameR_Flip)(sessionNum,individualamploop,:)));
                    handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(NameLPeaks_Flip)(sessionNum,individualamploop,2)=max(max(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(ExtractPeakNameL_Flip)(sessionNum,individualamploop,:)));
                    handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(NameRPeaks_Flip)(sessionNum,individualamploop,2)=max(max(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(ExtractPeakNameR_Flip)(sessionNum,individualamploop,:)));
                    handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(NameL_Flip)(sessionNum,individualamploop,1)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(NameLPeaks_Flip)(sessionNum,individualamploop,2)-handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(NameLPeaks_Flip)(sessionNum,individualamploop,1);
                    handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(NameR_Flip)(sessionNum,individualamploop,1)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(NameRPeaks_Flip)(sessionNum,individualamploop,2)-handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(NameRPeaks_Flip)(sessionNum,individualamploop,1); 
                    %Flops
                    handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(NameLPeaks_Flop)(sessionNum,individualamploop,1)=min(min(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(ExtractPeakNameL_Flop)(sessionNum,individualamploop,:)));
                    handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(NameRPeaks_Flop)(sessionNum,individualamploop,1)=min(min(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(ExtractPeakNameR_Flop)(sessionNum,individualamploop,:)));
                    handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(NameLPeaks_Flop)(sessionNum,individualamploop,2)=max(max(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(ExtractPeakNameL_Flop)(sessionNum,individualamploop,:)));
                    handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(NameRPeaks_Flop)(sessionNum,individualamploop,2)=max(max(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(ExtractPeakNameR_Flop)(sessionNum,individualamploop,:)));
                    handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(NameL_Flop)(sessionNum,individualamploop,1)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(NameLPeaks_Flop)(sessionNum,individualamploop,2)-handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(NameLPeaks_Flop)(sessionNum,individualamploop,1);
                    handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(NameR_Flop)(sessionNum,individualamploop,1)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(NameRPeaks_Flop)(sessionNum,individualamploop,2)-handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(NameRPeaks_Flop)(sessionNum,individualamploop,1); 
                end
            end
        end
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if exist('EndPlotData')==1
    clear EndPlotData
end
EndPlotData{1,1}='File Name';
maxminL=0;
maxmaxL=0;
maxminR=0;
maxmaxR=0;
for alpha=1:alphamax
    EndPlotData{alpha+1,1}=groupfiles{1,alpha};
    EventNum=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).EventNum;
    colorvector=lines(EventNum);
    for betaA=1:EventNum
        if betaA < 2
            EndPlotData{1,(betaA*2)}=sprintf('LH Familiar');
            EndPlotData{1,(betaA*2+1)}=sprintf('RH Familiar');
            EndPlotData{alpha+1,(betaA*2)}=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).Amplitudes(betaA,1);%LeftHemisphere
            EndPlotData{alpha+1,(betaA*2+1)}=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).Amplitudes(betaA,2);%RightHemisphere
        else
            EndPlotData{1,(betaA*2)}=sprintf('LH Novel');
            EndPlotData{1,(betaA*2+1)}=sprintf('RH Novel');
            EndPlotData{alpha+1,(betaA*2)}=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).Amplitudes(betaA,1);%LeftHemisphere
            EndPlotData{alpha+1,(betaA*2+1)}=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).Amplitudes(betaA,2);%RightHemisphere
        end
    end
end
handles.MainStructure.(GroupName).EndPlotData=EndPlotData;
handles.MainStructure.(GroupName).EventNames=EventNames;
handles.MainStructure.(GroupName).groupfiles=groupfiles;
handles.MainStructure.GroupNames=GroupNames;
handles.MainStructure.SrpThresh=SrpThresh;
handles.MainStructure.srpdays=srpdays;
handles.MainStructure.AmpGain=AmpGain;
handles.MainStructure.grpcolors=grpcolors;


%Calculate amplitudes for sessions 1/13/2016
EndPlotData_SessionAmps{1,1}='File Name';
maxminL=0;
maxmaxL=0;
maxminR=0;
maxmaxR=0;

for file_number=1:alphamax
    EventNames=handles.MainStructure.(GroupName).(groupfiles{1,file_number}(1,1:end-4)).EventNames;
    EndPlotData_SessionAmps{file_number+1,1}=groupfiles{1,file_number};
    EventNum=handles.MainStructure.(GroupName).(groupfiles{1,file_number}(1,1:end-4)).EventNum;
    colorvector=lines(EventNum);
    EventName_Total=(EventNum*4)-1; 
%I'm going to rewrite the label of EndPlotData_SessionAmps a lot, so i'll
%have to optimize that later.
    
    for EventName_LoopLoc=1:4:EventName_Total
        
            LH_Code=sprintf('Sessions%s%s_Amps',EventNames{(EventName_LoopLoc)},EventNames{(EventName_LoopLoc+2),1});
            RH_Code=sprintf('Sessions%s%s_Amps',EventNames{(EventName_LoopLoc+1)},EventNames{(EventName_LoopLoc+3),1});
        
        if EventName_LoopLoc == 1
        %session_number*2 since we are storing LH and RH in one pass.    
            for Session_Num=1:2:(session_number*2)

               true_session_num=(Session_Num+1)/2;

               EndPlotData_SessionAmps{1,Session_Num+1}=sprintf('LH_Ses_%s_Amp',num2str(true_session_num));
               EndPlotData_SessionAmps{1,Session_Num+2}=sprintf('RH_Ses_%s_Amp',num2str(true_session_num));

               SessionDataLH(:,:)=handles.MainStructure.(GroupName).(groupfiles{1,file_number}(1,1:end-4)).(LH_Code)(true_session_num,:,:);
               SessionDataRH(:,:)=handles.MainStructure.(GroupName).(groupfiles{1,file_number}(1,1:end-4)).(RH_Code)(true_session_num,:,:);

                [meansessionminLH,minlocLH]=(min(SessionDataLH(20:100,1)));
                minlocLH = minlocLH + 19;
                [meansessionmaxLH,maxlocLH]=(max(SessionDataLH(minlocLH:250,1)));
                meanampLH=meansessionmaxLH-meansessionminLH;

                [meansessionminRH,minlocRH]=(min(SessionDataRH(20:100,1)));
                minlocRH = minlocRH + 19;
                [meansessionmaxRH,maxlocRH]=(max(SessionDataRH(minlocRH:250,1)));
                meanampRH=meansessionmaxRH-meansessionminRH;

                EndPlotData_SessionAmps{file_number+1,Session_Num+1}=meanampLH;
                EndPlotData_SessionAmps{file_number+1,Session_Num+2}=meanampRH;

                clear SessionDataLH SessionDataRH

            end
        else
           
                    %session_number*2 since we are storing LH and RH in one pass.    
            for Session_Num=11:2:(session_number*4)

               true_session_num=((Session_Num+1)/2)-5;

               EndPlotData_SessionAmps{1,Session_Num+1}=sprintf('LH_Ses_%s_Amp_NOVEL',num2str(true_session_num));
               EndPlotData_SessionAmps{1,Session_Num+2}=sprintf('RH_Ses_%s_Amp_NOVEL',num2str(true_session_num));

               SessionDataLH(:,:)=handles.MainStructure.(GroupName).(groupfiles{1,file_number}(1,1:end-4)).(LH_Code)(true_session_num,:,:);
               SessionDataRH(:,:)=handles.MainStructure.(GroupName).(groupfiles{1,file_number}(1,1:end-4)).(RH_Code)(true_session_num,:,:);

                [meansessionminLH,minlocLH]=(min(SessionDataLH(20:100,1)));
                minlocLH = minlocLH + 19;
                [meansessionmaxLH,maxlocLH]=(max(SessionDataLH(minlocLH:250,1)));
                meanampLH=meansessionmaxLH-meansessionminLH;

                [meansessionminRH,minlocRH]=(min(SessionDataRH(20:100,1)));
                minlocRH = minlocRH + 19;
                [meansessionmaxRH,maxlocRH]=(max(SessionDataRH(minlocRH:250,1)));
                meanampRH=meansessionmaxRH-meansessionminRH;

                EndPlotData_SessionAmps{file_number+1,Session_Num+1}=meanampLH;
                EndPlotData_SessionAmps{file_number+1,Session_Num+2}=meanampRH;

                clear SessionDataLH SessionDataRH

            end
            
        end
        
        
        
        
        
    end  
end
handles.MainStructure.(GroupName).EndPlotData_SessionAmps=EndPlotData_SessionAmps;

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



%Calculate gray amplitudes
debug=1;
for alpha=1:alphamax
    [gray_x_LH,gray_y_LH]=size(handles.MainStructure.(GroupName).(groupfiles{1,filenum}(1,1:end-4)).GrayLH);

    for gray_datapoint=1:gray_y_LH
        GrayLH_Avg(1,gray_datapoint) =  mean(handles.MainStructure.(GroupName).(groupfiles{1,filenum}(1,1:end-4)).GrayLH(:,gray_datapoint));
        GrayRH_Avg(1,gray_datapoint) =  mean(handles.MainStructure.(GroupName).(groupfiles{1,filenum}(1,1:end-4)).GrayRH(:,gray_datapoint));
    end
    handles.MainStructure.(GroupName).(groupfiles{1,filenum}(1,1:end-4)).GrayLH_Avg=GrayLH_Avg;
    handles.MainStructure.(GroupName).(groupfiles{1,filenum}(1,1:end-4)).GrayLH_Avg=GrayLH_Avg;
end

debug=1;
%End

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end



set(handles.SRP_workload,'Backgroundcolor',[1 0 0]);
set(handles.SRP_workload,'String','Not Processing Data');
set(handles.SRP_plotoptions_text,'BackgroundColor',[0 1 0]);
set(handles.SRP_plotoptions_text,'String','Data Loaded');
set(handles.plot_processed,'Visible','on');

handles=buttons_on(hObject,handles);
set(handles.SRP_run_analysis,'Enable','on');
set(handles.SRP_clear_processed,'Enable','on');
set(handles.SRP_cleandata,'Enable','on');
set(handles.SRP_run_analysis,'Enable','off');
handles.processed_loaded=1;
guidata(hObject, handles);

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SRP_output_folder.
function SRP_output_folder_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_output_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output_folder_name = uigetdir;
set(handles.SRP_display_output_folder,'String',handles.output_folder_name);
setappdata(0,'Output_Folder',handles.output_folder_name);
guidata(hObject, handles);


% --- Executes on button press in SRP_cleandata.
function SRP_cleandata_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_cleandata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SRP_DataCleanup
set(handles.SRPCleanDataIndicator,'Backgroundcolor',[1 .6 0]);


% --- Executes on button press in usevetted.
function usevetted_Callback(hObject, eventdata, handles)
% hObject    handle to usevetted (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of usevetted


% --- Executes on button press in SRP_load_vetted_data.
function SRP_load_vetted_data_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_load_vetted_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=buttons_off(hObject,handles);
set(handles.VettedDataIndicator,'BackgroundColor',[1 .6 0]);
set(handles.SRP_load_vetted_data,'Enable','off');
set(handles.vetted_txt,'String','Loading, Large variables may take a few minutes.');
set(handles.vetted_txt,'BackgroundColor',[1 .6 0]);
drawnow;
[FileName,PathName,~] = uigetfile('*.mat','Select processed data');
if isequal(FileName,0)
   handles=buttons_on(hObject,handles);
   set(handles.unvetted_txt,'String','No Files Loaded');
   return;
end
combinedname=sprintf('%s%s',PathName,FileName);
handles.Cleaned_SRPData_Loaded=load(combinedname,'-mat');

handles=buttons_on(hObject,handles);
set(handles.SRP_load_vetted_data,'Enable','off');
checkunvettedloaded=isfield(handles,'Master_SRPData_Loaded');
if checkunvettedloaded==0
    set(handles.SRP_load_unvetted_data,'Enable','on');
else
    set(handles.SRP_clear_vetted_data,'Enable','on');
end
checkguioptions=isfield(handles,'GUI_Options_Loaded');
if checkguioptions==0
    set(handles.loadguioptions,'Enable','on');
else
    set(handles.clearguioptions,'Enable','on');
end

if checkunvettedloaded==1&&checkguioptions==1
    set(handles.SRP_cleandata,'Enable','on');
    set(handles.SRP_dataclean_txt,'String','Data Available');
    set(handles.SRP_dataclean_txt,'BackgroundColor',[0 1 0]);
    set(handles.plot_loaded,'Visible','on');
    set(handles.SRP_plotoptions_text,'BackgroundColor',[0 1 0]);
    set(handles.SRP_plotoptions_text,'String','Data Loaded');
end
set(handles.SRP_clear_vetted_data,'Enable','on');
handles.vetted_loaded=1;
set(handles.usevetted,'Visible','on');
set(handles.usevetted,'Enable','on');
set(handles.vetted_txt,'String',FileName);
set(handles.vetted_txt,'BackgroundColor',[0 1 0]);
set(handles.VettedDataIndicator,'BackgroundColor',[0 1 0]);
guidata(hObject, handles);

% --- Executes on button press in SRP_load_unvetted_data.
function SRP_load_unvetted_data_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_load_unvetted_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=buttons_off(hObject,handles);
set(handles.OldDataIndicator,'BackgroundColor',[1 .6 0]);
set(handles.SRP_load_unvetted_data,'Enable','off');
set(handles.unvetted_txt,'String','Loading, Large variables may take a few minutes.');
set(handles.unvetted_txt,'BackgroundColor',[1 .6 0]);
drawnow;
[FileName,PathName,~] = uigetfile('*.mat','Select processed data');
if isequal(FileName,0)
   handles=buttons_on(hObject,handles);
   set(handles.unvetted_txt,'String','No Files Loaded');
   return;
end
combinedname=sprintf('%s%s',PathName,FileName);
handles.Master_SRPData_Loaded=load(combinedname,'-mat');
handles=buttons_on(hObject,handles);
set(handles.SRP_load_unvetted_data,'Enable','off');
checkvettedloaded=isfield(handles,'Cleaned_SRPData_Loaded');
if checkvettedloaded==0
    set(handles.SRP_load_vetted_data,'Enable','on');
else
    set(handles.SRP_clear_vetted_data,'Enable','on');
end
checkguioptions=isfield(handles,'GUI_Options_Loaded');
if checkguioptions==0
    set(handles.loadguioptions,'Enable','on');
else
    set(handles.clearguioptions,'Enable','on');
end

if checkvettedloaded==1&&checkguioptions==1
    set(handles.SRP_cleandata,'Enable','on');
    set(handles.SRP_dataclean_txt,'String','Data Available');
    set(handles.SRP_dataclean_txt,'BackgroundColor',[0 1 0]);
    set(handles.plot_loaded,'Visible','on');
    set(handles.SRP_plotoptions_text,'BackgroundColor',[0 1 0]);
    set(handles.SRP_plotoptions_text,'String','Data Loaded');
end
set(handles.SRP_clear_unvetted_data,'Enable','on');
handles.unvetted_loaded=1;
set(handles.unvetted_txt,'String',FileName);
set(handles.unvetted_txt,'BackgroundColor',[0 1 0]);
set(handles.OldDataIndicator,'BackgroundColor',[0 1 0]);
guidata(hObject, handles);


% --- Executes on button press in SRP_clear_vetted_data.
function SRP_clear_vetted_data_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_clear_vetted_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.vetted_loaded=0;
set(handles.SRP_load_vetted_data,'Enable','on');
if handles.unvetted_loaded == 0
    set(handles.plot_loaded,'Visible','off');
    set(handles.SRP_plot_data,'Enable','off');
    set(handles.plot_loaded,'Value',0);
    checkprocessed=get(handles.plot_processed,'Visible');
    if strcmp(checkprocessed,'off')
        set(handles.SRP_plotoptions_text,'BackgroundColor',[1 0 0]);
        set(handles.SRP_plotoptions_text,'String','No Data Available');
    end
    checkprocessed=isfield(handles,'processed_loaded');
    if checkprocessed==1
        if handles.processed_loaded==0
           set(handles.SRP_cleandata,'Enable','off'); 
           set(handles.SRP_dataclean_txt,'String','Missing Data');
           set(handles.SRP_dataclean_txt,'BackgroundColor',[1 0 0]);
        end
    else
       set(handles.SRP_cleandata,'Enable','off'); 
       set(handles.SRP_dataclean_txt,'String','Missing Data');
       set(handles.SRP_dataclean_txt,'BackgroundColor',[1 0 0]);
    end
end
handles=rmfield(handles,'Cleaned_SRPData_Loaded');
set(handles.vetted_txt,'String','No File Loaded');
set(handles.SRP_clear_vetted_data,'Enable','off');
set(handles.usevetted,'Visible','off');
set(handles.usevetted,'Enable','off');
set(handles.usevetted,'Value',0);
set(handles.vetted_txt,'BackgroundColor',[1 0 0]);
set(handles.VettedDataIndicator,'BackgroundColor',[1 0 0]);
guidata(hObject, handles);

% --- Executes on button press in SRP_clear_unvetted_data.
function SRP_clear_unvetted_data_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_clear_unvetted_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.unvetted_loaded=0;
set(handles.SRP_load_unvetted_data,'Enable','on');
set(handles.SRP_clear_unvetted_data,'Enable','off');
if handles.vetted_loaded == 0
    set(handles.plot_loaded,'Visible','off');
    set(handles.SRP_plot_data,'Enable','off');
    set(handles.plot_loaded,'Value',0);
    checkprocessed=get(handles.plot_processed,'Visible');
    if strcmp(checkprocessed,'off')
        set(handles.SRP_plotoptions_text,'BackgroundColor',[1 0 0]);
        set(handles.SRP_plotoptions_text,'String','No Data Available');
    end
    checkprocessed=isfield(handles,'processed_loaded');
    if checkprocessed==1
        if handles.processed_loaded==0
           set(handles.SRP_cleandata,'Enable','off');
           set(handles.SRP_dataclean_txt,'String','Missing Data');
           set(handles.SRP_dataclean_txt,'BackgroundColor',[1 0 0]);
        end
    else
       set(handles.SRP_cleandata,'Enable','off'); 
       set(handles.SRP_dataclean_txt,'String','Missing Data');
       set(handles.SRP_dataclean_txt,'BackgroundColor',[1 0 0]);
    end
end
handles=rmfield(handles,'Master_SRPData_Loaded');
set(handles.unvetted_txt,'String','No File Loaded');
set(handles.unvetted_txt,'BackgroundColor',[1 0 0]);
set(handles.OldDataIndicator,'BackgroundColor',[1 0 0]);
guidata(hObject, handles);


% --- Executes when selected object is changed in plot_selection.
function plot_selection_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in plot_selection 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
set(handles.SRP_plot_data,'Enable','on');




% --- Executes on button press in SRP_plot_data.
function SRP_plot_data_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_plot_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SaveVar=handles.MainStructure;
save('ReprocessedMainStructure.mat','SaveVar');
SRP_Options_working=getappdata(0,'SRP_options');
General_Options_working=getappdata(0,'GS_options');
SRP_GroupOptions_working=getappdata(0,'SRP_group_options');

WeekTwo = SRP_Options_working{12,2};
if WeekTwo==1
    chkkey = isappdata(0,'week1key');
    if chkkey == 1
        week1key=getappdata(0,'week1key');
        %Custom key must be changed based on how different your wee2srp file order
        %is from the week1srp file order.
        customkey_normoxic=[1,2,3,4,5,9,13,14];
        customkey_hypoxic=[2,3,5,6,7,8,9,10,12];
    else
        h = msgbox('No Week 1 SRP Key File Loaded', 'Error','error');
        return;
    end
end
AmpGain = str2num(General_Options_working{2,2});
SrpThresh = str2num(SRP_Options_working{6,2});
grpcolors = [ SRP_GroupOptions_working{7,2};SRP_GroupOptions_working{8,2};SRP_GroupOptions_working{9,2};SRP_GroupOptions_working{10,2};SRP_GroupOptions_working{11,2} ];

checkdata=get(handles.plot_loaded,'Value');
if checkdata==1
    checkvetted=get(handles.usevetted,'Value');
    if checkvetted==1
        Data=handles.Cleaned_SRPData_Loaded.Cleaned_SRPData;
    else
        Data=handles.Master_SRPData_Loaded.MasterSRPData;
    end
else
    Data=handles.MainStructure;
end
grpnamelen=length(Data.GroupNames);
groupnum=0;


groups_fields=fieldnames(Data);

%There are some fields that are not group names (and will thus
%give us an innacurate group number) so we delete them
%here.
delname1='GroupNames';
delname2='SrpThresh';
delname3='srpdays';
delname4='AmpGain';
delname5='grpcolors';
groups_fields(strcmp((delname1),groups_fields)) = [];
groups_fields(strcmp((delname2),groups_fields)) = [];
groups_fields(strcmp((delname3),groups_fields)) = [];
groups_fields(strcmp((delname4),groups_fields)) = [];
groups_fields(strcmp((delname5),groups_fields)) = [];
groups_fields_num=length(groups_fields);
for namecheck=1:groups_fields_num
    for grpcheck=1:grpnamelen
        if strcmp(groups_fields{namecheck,1},Data.GroupNames{1,grpcheck})==1
            groupnum=groupnum+1;
        end
    end
end

srpdays = str2num(SRP_Options_working{7,2});

for group=1:groupnum
    
    
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
    
    
    end
    
    
    
    
end
SRP_Options_working=getappdata(0,'SRP_options');
trials = str2num(SRP_Options_working{8,2});
sessions = str2num(SRP_Options_working{10,2});
waveformfig=figure;
for group=1:groupnum
    tracker=0;
    %trackL=ones(1,srpdays);
    %trackR=ones(1,srpdays);
    if srpdays==5
        trackerHemi=ones(1,srpdays+1);
        sessionHemi=ones(1,srpdays+1);
    else
        trackerHemi=ones(1,srpdays);
        sessionHemi=ones(1,srpdays);
    end
    
    groupname=Data.GroupNames{1,group};
    for hemi=1:2:totalhemis
        if ~isnan(threshgroupdata(group,hemi,1))==1
           for day=1:srpdays
               %left hemi
               
               if day==1 && srpdays > 1
                   day=5;
                   filenum=tracker*5+1;
               else 
                   if srpdays==1
                       day=1;
                       filenum=tracker*5+day;
                   else
                   day=day-1;
                   filenum=tracker*5+day+1;
                   end
                   
               end
               
          
               [~,groupfiles]=size(Data.(groupname).groupfiles);
               if filenum <= groupfiles
               filename=Data.(groupname).groupfiles{1,filenum}(1:end-4);
               fileevents=Data.(groupname).(filename).EventNum;
               eventtrack=1;
               for event=1:2:(fileevents*2)
                   EventNames{eventtrack,1}=sprintf('E%sL',num2str(event));
                   eventtrack=eventtrack+1;
                   EventNames{eventtrack,1}=sprintf('E%sL',num2str(event+1));
                   eventtrack=eventtrack+1;
               if event >=3
                   day=6;
               end
                   ExtractPeakNameL_Flip=(EventNames{event,1});
                   ExtractPeakNameL_Flop=(EventNames{event+1,1});
                   NameLPeaks_Flip=sprintf('%s_AmplitudePeaks',(EventNames{event,1}));
                   NameLPeaks_Flop=sprintf('%s_AmplitudePeaks',(EventNames{event+1,1}));
                   NameL_Flip=sprintf('%s_Amplitudes',(EventNames{event,1}));
                   NameL_Flop=sprintf('%s_Amplitudes',(EventNames{event+1,1}));
                subplot(groupnum,srpdays,day+((group-1)*srpdays))
                hold on
                plot(Data.(groupname).(filename).AveragedWaveFormL,'Color','b');
                plot(Data.(groupname).(filename).AveragedWaveFormR,'Color','r');
                ylabel(groupname)
                if group == groupnum
                    xlabel('Blue = LH, Red = RH');
                end
                for sessionNum=1:sessions
                    meansessionwaveform_merged(1:100,:)=Data.(groupname).(filename).(ExtractPeakNameL_Flip)(sessionNum,:,:);
                    meansessionwaveform_merged(101:200,:)=Data.(groupname).(filename).(ExtractPeakNameL_Flop)(sessionNum,:,:);
                    for datapoint=1:495
                        meansessionwaveform(1,datapoint)=mean(meansessionwaveform_merged(:,datapoint));
                    end
                    [meansessionmin,minloc]=(min(meansessionwaveform(1,20:100)));
                    minloc = minloc + 19;
                    [meansessionmax,maxloc]=(max(meansessionwaveform(1,minloc:250)));
                    meanamp=meansessionmax-meansessionmin;
                    sessionsum_finalstructure(group,day,sessionHemi(1,day))=meanamp;
                    if minloc < 20
                        debug = 1;
                    end
                    sessionsum_minlocs(group,day,sessionHemi(1,day))=minloc;
                    sessionHemi(1,day)=sessionHemi(1,day)+1;
                    
                    for individualamploop=1:trials
                        %Flips
                        [Data.(groupname).(filename).(NameLPeaks_Flip)(sessionNum,individualamploop,1),minloc]=(min(Data.(groupname).(filename).(ExtractPeakNameL_Flip)(sessionNum,individualamploop,20:100)));
                        [Data.(groupname).(filename).(NameLPeaks_Flip)(sessionNum,individualamploop,2),maxloc]=(max(Data.(groupname).(filename).(ExtractPeakNameL_Flip)(sessionNum,individualamploop,minloc:250)));
                        Data.(groupname).(filename).(NameL_Flip)(sessionNum,individualamploop,1)=Data.(groupname).(filename).(NameLPeaks_Flip)(sessionNum,individualamploop,2)-Data.(groupname).(filename).(NameLPeaks_Flip)(sessionNum,individualamploop,1);
                        cumsum_finalstructure(group,day,trackerHemi(1,day))=Data.(groupname).(filename).(NameL_Flip)(sessionNum,individualamploop,1);
                        cumsum_minlocs(group,day,trackerHemi(1,day))=minloc+19;
                        trackerHemi(1,day)=trackerHemi(1,day)+1;
                        %Flops
                        [Data.(groupname).(filename).(NameLPeaks_Flop)(sessionNum,individualamploop,1),minloc]=(min(Data.(groupname).(filename).(ExtractPeakNameL_Flop)(sessionNum,individualamploop,20:100)));
                        [Data.(groupname).(filename).(NameLPeaks_Flop)(sessionNum,individualamploop,2),maxloc]=(max(Data.(groupname).(filename).(ExtractPeakNameL_Flop)(sessionNum,individualamploop,minloc:250)));
                        Data.(groupname).(filename).(NameL_Flop)(sessionNum,individualamploop,1)=Data.(groupname).(filename).(NameLPeaks_Flop)(sessionNum,individualamploop,2)-Data.(groupname).(filename).(NameLPeaks_Flop)(sessionNum,individualamploop,1);
                        cumsum_finalstructure(group,day,trackerHemi(1,day))=Data.(groupname).(filename).(NameL_Flip)(sessionNum,individualamploop,1);
                        cumsum_minlocs(group,day,trackerHemi(1,day))=minloc+19;
                        trackerHemi(1,day)=trackerHemi(1,day)+1;
                    end
                end
                end
               end
           end
        end
        if ~isnan(threshgroupdata(group,hemi+1,1))==1
           for day=1:srpdays
               if day==1 && srpdays == 5
                   day=5;
                   filenum=tracker*5+1;
               else 
                   if srpdays < 5 && day == 1
                       day =1;
                   else
                       day=day-1;
                   end
                   filenum=tracker*5+day+1;
               end
               %right hemi
               filenum=tracker*5+day;
               [~,groupfiles]=size(Data.(groupname).groupfiles);
               if filenum <= groupfiles
               filename=Data.(groupname).groupfiles{1,filenum}(1:end-4);
               fileevents=Data.(groupname).(filename).EventNum;
               eventtrack=1;
               for event=1:2:(fileevents*2)
                   EventNames{eventtrack,1}=sprintf('E%sR',num2str(event));
                   eventtrack=eventtrack+1;
                   EventNames{eventtrack,1}=sprintf('E%sR',num2str(event+1));
                   eventtrack=eventtrack+1;
               if event >= 3
                   day = 6;
               end
                   ExtractPeakNameR_Flip=(EventNames{event,1});
                   ExtractPeakNameR_Flop=(EventNames{event+1,1});
                   NameRPeaks_Flip=sprintf('%s_AmplitudePeaks',(EventNames{event,1}));
                   NameRPeaks_Flop=sprintf('%s_AmplitudePeaks',(EventNames{event+1,1}));
                   NameR_Flip=sprintf('%s_Amplitudes',(EventNames{event,1}));
                   NameR_Flop=sprintf('%s_Amplitudes',(EventNames{event+1,1}));
                for sessionNum=1:sessions
                    meansessionwaveform_merged(1:100,:)=Data.(groupname).(filename).(ExtractPeakNameR_Flip)(sessionNum,:,:);
                    meansessionwaveform_merged(101:200,:)=Data.(groupname).(filename).(ExtractPeakNameR_Flop)(sessionNum,:,:);
                    for datapoint=1:495
                        meansessionwaveform(1,datapoint)=mean(meansessionwaveform_merged(:,datapoint));
                    end
                    [meansessionmin,minloc]=min(meansessionwaveform(1,20:100));
                    minloc = minloc + 19;
                    [meansessionmax,maxloc]=max(meansessionwaveform(1,minloc:250));
                    meanamp=meansessionmax-meansessionmin;
                    sessionsum_finalstructure(group,day,sessionHemi(1,day))=meanamp;
                    if minloc < 20
                        debug = 1;
                    end
                    sessionsum_minlocs(group,day,sessionHemi(1,day))=minloc;
                    sessionHemi(1,day)=sessionHemi(1,day)+1;
                    for individualamploop=1:trials
                        %Flips
                        
                        [Data.(groupname).(filename).(NameRPeaks_Flip)(sessionNum,individualamploop,1),minloc]=(min(Data.(groupname).(filename).(ExtractPeakNameR_Flip)(sessionNum,individualamploop,20:100)));
                        [Data.(groupname).(filename).(NameRPeaks_Flip)(sessionNum,individualamploop,2),maxloc]=(max(Data.(groupname).(filename).(ExtractPeakNameR_Flip)(sessionNum,individualamploop,minloc:250)));
                        Data.(groupname).(filename).(NameR_Flip)(sessionNum,individualamploop,1)=Data.(groupname).(filename).(NameRPeaks_Flip)(sessionNum,individualamploop,2)-Data.(groupname).(filename).(NameRPeaks_Flip)(sessionNum,individualamploop,1);
                        cumsum_finalstructure(group,day,trackerHemi(1,day))=Data.(groupname).(filename).(NameR_Flip)(sessionNum,individualamploop,1);
                        cumsum_minlocs(group,day,trackerHemi(1,day))=minloc+19;
                        trackerHemi(1,day)=trackerHemi(1,day)+1;
                        %Flops
                        [Data.(groupname).(filename).(NameRPeaks_Flop)(sessionNum,individualamploop,1),minloc]=(min(Data.(groupname).(filename).(ExtractPeakNameR_Flop)(sessionNum,individualamploop,20:100)));
                        [Data.(groupname).(filename).(NameRPeaks_Flop)(sessionNum,individualamploop,2),maxloc]=(max(Data.(groupname).(filename).(ExtractPeakNameR_Flop)(sessionNum,individualamploop,minloc:250)));
                        Data.(groupname).(filename).(NameR_Flop)(sessionNum,individualamploop,1)=Data.(groupname).(filename).(NameRPeaks_Flop)(sessionNum,individualamploop,2)-Data.(groupname).(filename).(NameRPeaks_Flop)(sessionNum,individualamploop,1);
                        cumsum_finalstructure(group,day,trackerHemi(1,day))=Data.(groupname).(filename).(NameR_Flip)(sessionNum,individualamploop,1);
                        cumsum_minlocs(group,day,trackerHemi(1,day))=minloc+19;
                        trackerHemi(1,day)=trackerHemi(1,day)+1;
                    end
                end
                end
               end
           end
        end
        tracker=tracker+1;
    end
end


[groupnum,days,maxtrials]=size(sessionsum_finalstructure);
for group=1:groupnum
    for day=1:days
        for trial=1:maxtrials
            if sessionsum_finalstructure(group,day,trial)==0
                sessionsum_finalstructure(group,day,trial)=nan;
            end
            if sessionsum_finalstructure(group,day,trial)>3
                sessionsum_finalstructure(group,day,trial)=nan;
            end
        end
    end
end

[groupnum,days,maxtrials]=size(cumsum_finalstructure);
for group=1:groupnum
    for day=1:days
        for trial=1:maxtrials
            if cumsum_finalstructure(group,day,trial)==0
                cumsum_finalstructure(group,day,trial)=nan;
            end
            if cumsum_finalstructure(group,day,trial)>3
                cumsum_finalstructure(group,day,trial)=nan;
            end
        end
    end
end

grp1(:,:)=cumsum_finalstructure(1,:,:);
grp2(:,:)=cumsum_finalstructure(2,:,:);

if days == 5
figure
hold on
    cumplot(grp1(5,:),'b-','MarkerFaceColor','b');
    cumplot(grp1(6,:),'b--');
    cumplot(grp2(5,:),'r-','MarkerFaceColor','r');
    cumplot(grp2(6,:),'r--');
    title('All Extracted Windows');
    clear grp1 grp2
    grp1(:,:)=sessionsum_finalstructure(1,:,:);
    grp2(:,:)=sessionsum_finalstructure(2,:,:);
    figure
    hold on
    cumplot(grp1(5,:),'bo','MarkerFaceColor','b')
    cumplot(grp1(6,:),'bo')
    cumplot(grp2(5,:),'ro','MarkerFaceColor','r')
    cumplot(grp2(6,:),'ro')
    title('Session Averages');
    clear grp1 grp2
    grp1(:,:)=sessionsum_finalstructure(1,:,:);
    grp2(:,:)=sessionsum_finalstructure(2,:,:);
    figure
    hold on
    cumplot(grp1(5,:),'-b')
    cumplot(grp1(6,:),'--b')
    cumplot(grp2(5,:),'-r')
    cumplot(grp2(6,:),'--r')
    title('Session Averages');
    clear grp1 grp2
    grp1(:,:)=sessionsum_minlocs(1,:,:);
    grp1( :, ~any(grp1,1) ) = [];  %columns
    grp2(:,:)=sessionsum_minlocs(2,:,:);
    grp2( :, ~any(grp2,1) ) = [];  %columns
    figure
    hold on
    cumplot(grp1(5,:),'bo-','MarkerFaceColor','b')
    cumplot(grp1(6,:),'bo--')
    cumplot(grp2(5,:),'ro-','MarkerFaceColor','r')
    cumplot(grp2(6,:),'ro--')
    title('Session MinPeak Location');
    clear grp1 grp2
    grp1(:,:)=cumsum_minlocs(1,:,:);
    grp1( :, ~any(grp1,1) ) = [];  %columns
    grp2(:,:)=cumsum_minlocs(2,:,:);
    grp2( :, ~any(grp2,1) ) = [];  %columns
    figure
    hold on
    cumplot(grp1(5,:),'bo-','MarkerFaceColor','b')
    cumplot(grp1(6,:),'bo--')
    cumplot(grp2(5,:),'ro-','MarkerFaceColor','r')
    cumplot(grp2(6,:),'ro--')
    title('Session MinPeak Location');
else
        %Add code here to examine cumplots for individual days.
        %Are the peaks shifting to a more precise negative peak?
       
end
debug=1;




function [handles]=buttons_off(hObject,handles)
handles.previous_state{1,1}=get(handles.SRP_output_folder,'Enable');
set(handles.SRP_output_folder,'Enable','off');

handles.previous_state{1,2}=get(handles.SRPOptionsButton,'Enable');
set(handles.SRPOptionsButton,'Enable','off');

handles.previous_state{1,3}=get(handles.GroupOptionsButton,'Enable');
set(handles.GroupOptionsButton,'Enable','off');

handles.previous_state{1,4}=get(handles.SRP_run_analysis,'Enable');
set(handles.SRP_run_analysis,'Enable','off');

handles.previous_state{1,5}=get(handles.SRP_clear_processed,'Enable');
set(handles.SRP_clear_processed,'Enable','off');

handles.previous_state{1,6}=get(handles.SRP_load_unvetted_data,'Enable');
set(handles.SRP_load_unvetted_data,'Enable','off');

handles.previous_state{1,7}=get(handles.SRP_clear_unvetted_data,'Enable');
set(handles.SRP_clear_unvetted_data,'Enable','off');

handles.previous_state{1,8}=get(handles.SRP_load_vetted_data,'Enable');
set(handles.SRP_load_vetted_data,'Enable','off');

handles.previous_state{1,9}=get(handles.SRP_clear_vetted_data,'Enable');
set(handles.SRP_clear_vetted_data,'Enable','off');

handles.previous_state{1,10}=get(handles.SRP_cleandata,'Enable');
set(handles.SRP_cleandata,'Enable','off');

handles.previous_state{1,11}=get(handles.plot_processed,'Enable');
set(handles.plot_processed,'Enable','off');

handles.previous_state{1,12}=get(handles.plot_loaded,'Enable');
set(handles.plot_loaded,'Enable','off');

handles.previous_state{1,13}=get(handles.usevetted,'Enable');
set(handles.usevetted,'Enable','off');

handles.previous_state{1,14}=get(handles.SRP_export_data,'Enable');
set(handles.SRP_export_data,'Enable','off');

handles.previous_state{1,15}=get(handles.SRP_plot_data,'Enable');
set(handles.SRP_plot_data,'Enable','off');

handles.previous_state{1,16}=get(handles.loadguioptions,'Enable');
set(handles.loadguioptions,'Enable','off');

handles.previous_state{1,17}=get(handles.clearguioptions,'Enable');
set(handles.clearguioptions,'Enable','off');
guidata(hObject,handles);

function [handles]=buttons_on(hObject,handles)
set(handles.SRP_output_folder,'Enable',handles.previous_state{1,1});

set(handles.SRPOptionsButton,'Enable',handles.previous_state{1,2});

set(handles.GroupOptionsButton,'Enable',handles.previous_state{1,3});

set(handles.SRP_run_analysis,'Enable',handles.previous_state{1,4});

set(handles.SRP_clear_processed,'Enable',handles.previous_state{1,5});

set(handles.SRP_load_unvetted_data,'Enable',handles.previous_state{1,6});

set(handles.SRP_clear_unvetted_data,'Enable',handles.previous_state{1,7});

set(handles.SRP_load_vetted_data,'Enable',handles.previous_state{1,8});

set(handles.SRP_clear_vetted_data,'Enable',handles.previous_state{1,9});

set(handles.SRP_cleandata,'Enable',handles.previous_state{1,10});

set(handles.plot_processed,'Enable',handles.previous_state{1,11});

set(handles.plot_loaded,'Enable',handles.previous_state{1,12});

set(handles.usevetted,'Enable',handles.previous_state{1,13});

set(handles.SRP_export_data,'Enable',handles.previous_state{1,14});

set(handles.SRP_plot_data,'Enable',handles.previous_state{1,15});

set(handles.loadguioptions,'Enable',handles.previous_state{1,16});

set(handles.clearguioptions,'Enable',handles.previous_state{1,17});

guidata(hObject,handles);


% --- Executes on button press in loadguioptions.
function loadguioptions_Callback(hObject, eventdata, handles)
% hObject    handle to loadguioptions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=buttons_off(hObject,handles);
set(handles.GUIOptionsIndicator,'BackgroundColor',[1 .6 0]);
set(handles.loadguioptions,'Enable','off');
set(handles.guioptions_txt,'String','Loading GUI Options');
set(handles.guioptions_txt,'BackgroundColor',[1 .6 0]);
drawnow;
[FileName,PathName,~] = uigetfile('*.mat','Select GUI Options File');
if isequal(FileName,0)
   handles=buttons_on(hObject,handles);
   set(handles.unvetted_txt,'String','No File Loaded');
   return;
end
combinedname=sprintf('%s%s',PathName,FileName);
handles.GUI_Options_Loaded=load(combinedname,'-mat');
handles=buttons_on(hObject,handles);
set(handles.loadguioptions,'Enable','off');
checkvettedloaded=isfield(handles,'Cleaned_SRPData_Loaded');
checkunvettedloaded=isfield(handles,'Master_SRPData_Loaded');
if checkvettedloaded==0
    set(handles.SRP_load_vetted_data,'Enable','on');
else
    set(handles.SRP_clear_vetted_data,'Enable','on');
end
if checkunvettedloaded==0
    set(handles.SRP_load_unvetted_data,'Enable','on');
else
    set(handles.SRP_clear_vetted_data,'Enable','on');
end
if checkunvettedloaded==1&&checkvettedloaded==1
    set(handles.SRP_cleandata,'Enable','on');
    set(handles.SRP_dataclean_txt,'String','Data Available');
    set(handles.SRP_dataclean_txt,'BackgroundColor',[0 1 0]);
    set(handles.plot_loaded,'Visible','on');
    set(handles.SRP_plotoptions_text,'BackgroundColor',[0 1 0]);
    set(handles.SRP_plotoptions_text,'String','Data Loaded');
end
set(handles.clearguioptions,'Enable','on');
handles.guioptions_loaded=1;
set(handles.guioptions_txt,'String',FileName);
set(handles.guioptions_txt,'BackgroundColor',[0 1 0]);
set(handles.GUIOptionsIndicator,'BackgroundColor',[0 1 0]);
guidata(hObject, handles);


% --- Executes on button press in clearguioptions.
function clearguioptions_Callback(hObject, eventdata, handles)
% hObject    handle to clearguioptions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.guioptions_loaded=0;
set(handles.loadguioptions,'Enable','on');
if handles.unvetted_loaded == 0 || handles.vetted_loaded == 0
    set(handles.plot_loaded,'Visible','off');
    set(handles.SRP_plot_data,'Enable','off');
    set(handles.plot_loaded,'Value',0);
    checkprocessed=get(handles.plot_processed,'Visible');
    if strcmp(checkprocessed,'off')
        set(handles.SRP_plotoptions_text,'BackgroundColor',[1 0 0]);
        set(handles.SRP_plotoptions_text,'String','No Data Available');
    end

    
end

    checkprocessed=isfield(handles,'processed_loaded');
    if checkprocessed==1
        if handles.processed_loaded==0
           set(handles.SRP_cleandata,'Enable','off'); 
           set(handles.SRP_dataclean_txt,'String','Missing Data');
           set(handles.SRP_dataclean_txt,'BackgroundColor',[1 0 0]);
        end
    else
       set(handles.SRP_cleandata,'Enable','off'); 
       set(handles.SRP_dataclean_txt,'String','Missing Data');
       set(handles.SRP_dataclean_txt,'BackgroundColor',[1 0 0]);
    end
handles=rmfield(handles,'GUI_Options_Loaded');
set(handles.guioptions_txt,'String','No File Loaded');
set(handles.guioptions_txt,'BackgroundColor',[1 0 0]);
set(handles.clearguioptions,'Enable','off');
set(handles.GUIOptionsIndicator,'BackgroundColor',[1 0 0]);
guidata(hObject, handles);


function [LH,RH] = check_hemi(animal,chkgrp)
%1=nx
%2=hx
  


%1=RH
%2=LH
%3=LH and RH

week1key=getappdata(0,'week1key');

    
    
if chkgrp==1
    animal_index=find(manual_delete_normoxic(1,:)==animal);
    if isempty(animal_index)
       LH=0;
       RH=0;
    else
       hemi_info=manual_delete_normoxic(2,animal_index);
       if hemi_info==1
           LH=0;
           RH=1;
       elseif hemi_info == 2
           LH = 1;
           RH = 0;
       elseif hemi_info == 3
           LH = 1;
           RH = 1;
       end
    end
else
    animal_index=find(manual_delete_hypoxic(1,:)==animal);
    if isempty(animal_index)
       LH=0;
       RH=0;
    else
       hemi_info=manual_delete_hypoxic(2,animal_index);
       if hemi_info==1
           LH=0;
           RH=1;
       elseif hemi_info == 2
           LH = 1;
           RH = 0;
       elseif hemi_info == 3
           LH = 1;
           RH = 1;
       end
    end
end





%groupdata_contra, grouptracker_contra,groupdata_ipsi,grouptracker_ipsi,srpdays,group,DayHolder
function [groupdata_contra,grouptracker_contra,groupdata_ipsi,grouptracker_ipsi]=hemi_loop(groupdata_contra,groupdata_ipsi,AnimalNum,grouptracker_ipsi,grouptracker_contra,SRP_groupname,SRP_Thresh,AMPGain,animalloop,SRP_Data,group,Data,groupname,srpdays,trueanimal)
DayHolder=0;
           while DayHolder<srpdays
               if DayHolder==0
                    RemoveLeft=0;
                    RemoveRight=0;
                    %CHECK SRP ENDPLOT DAY 1 VALUE
                    clear clearhemi
                    [clear_LH,clear_RH]=check_hemi(trueanimal,group);
                    check_value=SRP_Data.(SRP_groupname).EndPlotData{animalloop+1,2}; %LH Day 1 Binoc SRP Value
                    if check_value < SRP_Thresh/AMPGain || clear_LH == 1
                        RemoveLeft=1;
                    end
                    check_value=SRP_Data.(SRP_groupname).EndPlotData{animalloop+1,3}; %LH Day 1 Binoc SRP Value
                    if check_value < SRP_Thresh/AMPGain || clear_RH == 1
                        RemoveRight=1;
                    end
                    %LEFT EYE OPEN
                    if RemoveLeft==1
                        %(Novel) LH w/ LEYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,6),srpdays+1)=NaN; %LH Novel Always
                        [~,windowsize]=size(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormL(2,:));
                        groupdata_ipsi_waveforms(group,grouptracker_ipsi(1,6),1:windowsize)=Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormL(2,:)
                        grouptracker_ipsi(1,6)=grouptracker_ipsi(1,6)+1;
                    else
                        %(Novel) LH w/ LEYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,6),srpdays+1)=Data.(groupname).EndPlotData{animalloop+DayHolder,4}; %LH Novel Always
                        grouptracker_ipsi(1,6)=grouptracker_ipsi(1,6)+1;
                    end
                    
                    if RemoveRight==1
                        %(Novel) RH w/ LEYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,6),srpdays+1)=NaN; %RH Novel Always
                        grouptracker_contra(1,6)=grouptracker_contra(1,6)+1;
                    else
                        %(Novel) RH w/ LEYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,6),srpdays+1)=Data.(groupname).EndPlotData{animalloop+DayHolder,5}; %RH Novel Always
                        grouptracker_contra(1,6)=grouptracker_contra(1,6)+1;
                    end
                    
                    
                    if RemoveLeft == 1
                        %LH w/ LEYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,5),srpdays)=NaN; %LH Familiar Always
                        grouptracker_ipsi(1,5)=grouptracker_ipsi(1,5)+1;
                    else
                        %LH w/ LEYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,5),srpdays)=Data.(groupname).EndPlotData{animalloop+DayHolder,2}; %LH Familiar Always
                        grouptracker_ipsi(1,5)=grouptracker_ipsi(1,5)+1;
                    end
                       
                    if RemoveRight == 1
                        %RH w/ LEYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,5),srpdays)=NaN; %RH Familiar Always
                        grouptracker_contra(1,5)=grouptracker_contra(1,5)+1;
                    else
                        %RH w/ LEYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,5),srpdays)=Data.(groupname).EndPlotData{animalloop+DayHolder,3}; %RH Familiar Always
                        grouptracker_contra(1,5)=grouptracker_contra(1,5)+1;
                    end
                        
                    %RIGHT EYE OPEN
                    if RemoveLeft == 1
                        %(Novel) LH w/ REYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,6),srpdays+1)=NaN; %LH Novel Always
                        grouptracker_contra(1,6)=grouptracker_contra(1,6)+1;
                    else
                        %(Novel) LH w/ REYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,6),srpdays+1)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,4}; %LH Novel Always
                        grouptracker_contra(1,6)=grouptracker_contra(1,6)+1;
                    end

                    if RemoveRight == 1
                        %(Novel) RH w/ REYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,6),srpdays+1)=NaN; %RH Novel Always
                        grouptracker_ipsi(1,6)=grouptracker_ipsi(1,6)+1;
                    else    
                        %(Novel) RH w/ REYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,6),srpdays+1)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,5}; %RH Novel Always
                        grouptracker_ipsi(1,6)=grouptracker_ipsi(1,6)+1;
                    end
                    
                    if RemoveLeft == 1
                        %LH w/ REYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,5),srpdays)=NaN; %LH Familiar Always
                        grouptracker_contra(1,5)=grouptracker_contra(1,5)+1;
                    else
                        %LH w/ REYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,5),srpdays)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,2}; %LH Familiar Always
                        grouptracker_contra(1,5)=grouptracker_contra(1,5)+1;
                    end

                    if RemoveRight == 1
                        %RH w/ REYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,5),srpdays)=NaN; %RH Familiar Always
                        grouptracker_ipsi(1,5)=grouptracker_ipsi(1,5)+1;
                    else
                        %RH w/ REYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,5),srpdays)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,3}; %RH Familiar Always
                        grouptracker_ipsi(1,5)=grouptracker_ipsi(1,5)+1;
                    end


                        DayHolder=DayHolder+1;
                else
                    %LEYE OPEN
                    if RemoveLeft == 1
                        %LH w/ LEYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,DayHolder),DayHolder)=NaN; %LH Familiar Always
                        grouptracker_ipsi(1,DayHolder)=grouptracker_ipsi(1,DayHolder)+1;
                    else
                        %LH w/ LEYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,DayHolder),DayHolder)=Data.(groupname).EndPlotData{animalloop+DayHolder,2}; %LH Familiar Always
                        grouptracker_ipsi(1,DayHolder)=grouptracker_ipsi(1,DayHolder)+1;
                    end

                    if RemoveRight == 1
                        %RH w/ LEYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,DayHolder),DayHolder)=NaN; %RH Familiar Always
                        grouptracker_contra(1,DayHolder)=grouptracker_contra(1,DayHolder)+1;
                    else
                        %RH w/ LEYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,DayHolder),DayHolder)=Data.(groupname).EndPlotData{animalloop+DayHolder,3}; %RH Familiar Always
                        grouptracker_contra(1,DayHolder)=grouptracker_contra(1,DayHolder)+1;
                    end

                        
                    %REYE OPEN
                    if RemoveLeft == 1
                        %LH w/ REYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,DayHolder),DayHolder)=NaN; %LH Familiar Always
                        grouptracker_contra(1,DayHolder)=grouptracker_contra(1,DayHolder)+1;
                    else
                        %LH w/ REYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,DayHolder),DayHolder)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,2}; %LH Familiar Always
                        grouptracker_contra(1,DayHolder)=grouptracker_contra(1,DayHolder)+1;
                    end

                    if RemoveRight == 1
                        %RH w/ REYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,DayHolder),DayHolder)=NaN; %RH Familiar Always
                        grouptracker_ipsi(1,DayHolder)=grouptracker_ipsi(1,DayHolder)+1;
                    else
                        %RH w/ REYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,DayHolder),DayHolder)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,3}; %RH Familiar Always
                        grouptracker_ipsi(1,DayHolder)=grouptracker_ipsi(1,DayHolder)+1;
                    end
                    %Sanity Check
                    %if groupdata_contragroupdata_ipsi(group,grouptracker_ipsi(1,DayHolder),DayHolder)
                    DayHolder=DayHolder+1;
               end
           end