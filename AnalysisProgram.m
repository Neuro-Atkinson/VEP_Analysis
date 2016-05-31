 function varargout = AnalysisProgram(varargin)
% ANALYSISPROGRAM MATLAB code for AnalysisProgram.fig
%      ANALYSISPROGRAM, by itself, creates a new ANALYSISPROGRAM or raises the existing
%      singleton*.
%
%      H = ANALYSISPROGRAM returns the handle to a new ANALYSISPROGRAM or the handle to
%      the existing singleton*.
%
%      ANALYSISPROGRAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALYSISPROGRAM.M with the given input arguments.
%
%      ANALYSISPROGRAM('Property','Value',...) creates a new ANALYSISPROGRAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AnalysisProgram_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AnalysisProgram_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AnalysisProgram

% Last Modified by GUIDE v2.5 17-Apr-2014 17:13:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AnalysisProgram_OpeningFcn, ...
                   'gui_OutputFcn',  @AnalysisProgram_OutputFcn, ...
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


% --- Executes just before AnalysisProgram is made visible.
function AnalysisProgram_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AnalysisProgram (see VARARGIN)

% Choose default command line output for AnalysisProgram
handles.output = hObject;
runningprogs=[0 0 0 0];
indicatornames={'SrpIndicator','AcuityIndicator','ContrastIndicator','ContraIpsiIndicator'};
setappdata(0    , 'RunningPrograms' , runningprogs);
setappdata(0    , 'ProgramNames'    , indicatornames);
set(gcf,'CloseRequestFcn',@modified_closefcn)
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AnalysisProgram wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AnalysisProgram_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in SrpAnalysisButton.
function SrpAnalysisButton_Callback(hObject, eventdata, handles)
% hObject    handle to SrpAnalysisButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
checkoptions=get(handles.GlobalSettingsIndicator,'Backgroundcolor');
if checkoptions(1,1)==0 && checkoptions(1,2)==1 && checkoptions(1,3)==0
SRPAnalysis_Master;
currentprogs=getappdata(0,'RunningPrograms');
currentprogs(1,1)=1;
setappdata(0,'RunningPrograms',currentprogs);
updateindicators(handles,currentprogs);
else
    msgbox('You must confirm global settings before running an analysis.','Error');
end

% --- Executes on button press in AcuityAnalysisButton.
function AcuityAnalysisButton_Callback(hObject, eventdata, handles)
% hObject    handle to AcuityAnalysisButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
checkoptions=get(handles.GlobalSettingsIndicator,'Backgroundcolor');
if checkoptions(1,1)==0 && checkoptions(1,2)==1 && checkoptions(1,3)==0
AcuityAnalysis_Master;
currentprogs=getappdata(0,'RunningPrograms');
currentprogs(1,2)=1;
setappdata(0,'RunningPrograms',currentprogs);
updateindicators(handles,currentprogs);
else
    msgbox('You must confirm global settings before running an analysis.','Error');
end

% --- Executes on button press in ContrastAnalyaisButton.
function ContrastAnalyaisButton_Callback(hObject, eventdata, handles)
% hObject    handle to ContrastAnalyaisButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
checkoptions=get(handles.GlobalSettingsIndicator,'Backgroundcolor');
if checkoptions(1,1)==0 && checkoptions(1,2)==1 && checkoptions(1,3)==0
ContrastAnalysis_Master;
currentprogs=getappdata(0,'RunningPrograms');
currentprogs(1,3)=1;
setappdata(0,'RunningPrograms',currentprogs);
updateindicators(handles,currentprogs);
else
    msgbox('You must confirm global settings before running an analysis.','Error');
end
% --- Executes on button press in ContraIpsiAnalysisButton.
function ContraIpsiAnalysisButton_Callback(hObject, eventdata, handles)
% hObject    handle to ContraIpsiAnalysisButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
checkoptions=get(handles.GlobalSettingsIndicator,'Backgroundcolor');
if checkoptions(1,1)==0 && checkoptions(1,2)==1 && checkoptions(1,3)==0
ContraIpsiAnalysis_Master;
currentprogs=getappdata(0,'RunningPrograms');
currentprogs(1,4)=1;
setappdata(0,'RunningPrograms',currentprogs);
updateindicators(handles,currentprogs);
else
    msgbox('You must confirm global settings before running an analysis.','Error');
end

function updateindicators(handles,currentprogs)
num_programs=length(currentprogs);
indicatornames=getappdata(0,'ProgramNames');

for i=1:num_programs
    if currentprogs(1,i)==1
        set(handles.(indicatornames{1,i}),'Backgroundcolor',[1 .6 0]);
    end
end
    
    
function modified_closefcn(hObject, eventdata, handles)
currentprogs=getappdata(0,'RunningPrograms');
openoptionswindow=getappdata(0,'GS_options_opened');
if sum(currentprogs)~=0 || openoptionswindow == 1
msgbox('Please close all analysis or option windows before exiting the program.','Notice')
else
LoadOptions=getappdata(0,'GS_options');
if isempty(LoadOptions)==0
rmappdata(0,'GS_options');
end
LoadOptions=getappdata(0,'ACU_options');
if isempty(LoadOptions)==0
    rmappdata(0,'ACU_options');
end
LoadOptions=getappdata(0,'Acuity_group_options');
if isempty(LoadOptions)==0
    rmappdata(0,'Acuity_group_options');
end
LoadOptions=getappdata(0,'CO_options');
if isempty(LoadOptions)==0
    rmappdata(0,'CO_options');
end
LoadOptions=getappdata(0,'SRP_options');
if isempty(LoadOptions)==0
    rmappdata(0,'SRP_options');
end
LoadOptions=getappdata(0,'SRP_group_options');
if isempty(LoadOptions)==0
    rmappdata(0,'SRP_group_options');
end
delete(hObject);
end


% --- Executes on button press in AnalysisProgram_Master_GlobalSettings.
function AnalysisProgram_Master_GlobalSettings_Callback(hObject, eventdata, handles)
% hObject    handle to AnalysisProgram_Master_GlobalSettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AnalysisProgram_GlobalSettings
setappdata(0,'GS_options_confirmed',1);
setappdata(0,'GS_options_opened',1);
set(handles.GlobalSettingsIndicator,'Backgroundcolor',[1 .6 0]);
