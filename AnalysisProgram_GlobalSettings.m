function varargout = AnalysisProgram_GlobalSettings(varargin)
% ANALYSISPROGRAM_GLOBALSETTINGS MATLAB code for AnalysisProgram_GlobalSettings.fig
%      ANALYSISPROGRAM_GLOBALSETTINGS, by itself, creates a new ANALYSISPROGRAM_GLOBALSETTINGS or raises the existing
%      singleton*.
%
%      H = ANALYSISPROGRAM_GLOBALSETTINGS returns the handle to a new ANALYSISPROGRAM_GLOBALSETTINGS or the handle to
%      the existing singleton*.
%
%      ANALYSISPROGRAM_GLOBALSETTINGS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALYSISPROGRAM_GLOBALSETTINGS.M with the given input arguments.
%
%      ANALYSISPROGRAM_GLOBALSETTINGS('Property','Value',...) creates a new ANALYSISPROGRAM_GLOBALSETTINGS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AnalysisProgram_GlobalSettings_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AnalysisProgram_GlobalSettings_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AnalysisProgram_GlobalSettings

% Last Modified by GUIDE v2.5 02-Jul-2014 16:06:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AnalysisProgram_GlobalSettings_OpeningFcn, ...
                   'gui_OutputFcn',  @AnalysisProgram_GlobalSettings_OutputFcn, ...
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


% --- Executes just before AnalysisProgram_GlobalSettings is made visible.
function AnalysisProgram_GlobalSettings_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AnalysisProgram_GlobalSettings (see VARARGIN)

% Choose default command line output for AnalysisProgram_GlobalSettings
handles.output = hObject;
LoadOptions=getappdata(0,'GS_options');
if isempty(LoadOptions)==0
    looplength=length(LoadOptions);
    for i=1:looplength
       if i < 21
       set(handles.(LoadOptions{i,1}),'String',(LoadOptions{i,2}));
       elseif i < 23
       set(handles.(LoadOptions{i,1}),'Value',(LoadOptions{i,2}));  
       elseif i < 25
       set(handles.(LoadOptions{i,1}),'String',(LoadOptions{i,2}));
       end
    end
end
handles.error=0;
% Update handles structure
guidata(hObject, handles);
set(gcf,'CloseRequestFcn',@modified_closefcn)
% UIWAIT makes AnalysisProgram_GlobalSettings wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AnalysisProgram_GlobalSettings_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function GS_option_recordfreq_Callback(hObject, eventdata, handles)
% hObject    handle to GS_option_recordfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GS_option_recordfreq as text
%        str2double(get(hObject,'String')) returns contents of GS_option_recordfreq as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function GS_option_recordfreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GS_option_recordfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GS_option_ampgain_Callback(hObject, eventdata, handles)
% hObject    handle to GS_option_ampgain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GS_option_ampgain as text
%        str2double(get(hObject,'String')) returns contents of GS_option_ampgain as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function GS_option_ampgain_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GS_option_ampgain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in GS_option_normwaves.
function GS_option_normwaves_Callback(hObject, eventdata, handles)
% hObject    handle to GS_option_normwaves (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of GS_option_normwaves



function GS_option_totalchans_Callback(hObject, eventdata, handles)
% hObject    handle to GS_option_totalchans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GS_option_totalchans as text
%        str2double(get(hObject,'String')) returns contents of GS_option_totalchans as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function GS_option_totalchans_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GS_option_totalchans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GS_option_lhchannel_Callback(hObject, eventdata, handles)
% hObject    handle to GS_option_lhchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GS_option_lhchannel as text
%        str2double(get(hObject,'String')) returns contents of GS_option_lhchannel as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function GS_option_lhchannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GS_option_lhchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GS_option_rhchannel_Callback(hObject, eventdata, handles)
% hObject    handle to GS_option_rhchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GS_option_rhchannel as text
%        str2double(get(hObject,'String')) returns contents of GS_option_rhchannel as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function GS_option_rhchannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GS_option_rhchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GS_option_vidgetchannel_Callback(hObject, eventdata, handles)
% hObject    handle to GS_option_vidgetchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GS_option_vidgetchannel as text
%        str2double(get(hObject,'String')) returns contents of GS_option_vidgetchannel as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function GS_option_vidgetchannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GS_option_vidgetchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GS_option_strobechannel_Callback(hObject, eventdata, handles)
% hObject    handle to GS_option_strobechannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GS_option_strobechannel as text
%        str2double(get(hObject,'String')) returns contents of GS_option_strobechannel as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function GS_option_strobechannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GS_option_strobechannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GS_option_event1channel_Callback(hObject, eventdata, handles)
% hObject    handle to GS_option_event1channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GS_option_event1channel as text
%        str2double(get(hObject,'String')) returns contents of GS_option_event1channel as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function GS_option_event1channel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GS_option_event1channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GS_option_event2channel_Callback(hObject, eventdata, handles)
% hObject    handle to GS_option_event2channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GS_option_event2channel as text
%        str2double(get(hObject,'String')) returns contents of GS_option_event2channel as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function GS_option_event2channel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GS_option_event2channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GS_option_event3channel_Callback(hObject, eventdata, handles)
% hObject    handle to GS_option_event3channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GS_option_event3channel as text
%        str2double(get(hObject,'String')) returns contents of GS_option_event3channel as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function GS_option_event3channel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GS_option_event3channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GS_option_event4channel_Callback(hObject, eventdata, handles)
% hObject    handle to GS_option_event4channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GS_option_event4channel as text
%        str2double(get(hObject,'String')) returns contents of GS_option_event4channel as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function GS_option_event4channel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GS_option_event4channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GS_option_e4thresh_Callback(hObject, eventdata, handles)
% hObject    handle to GS_option_e4thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GS_option_e4thresh as text
%        str2double(get(hObject,'String')) returns contents of GS_option_e4thresh as a double
userinput=get(hObject,'String');
checkinputdouble(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function GS_option_e4thresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GS_option_e4thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GS_option_e3thresh_Callback(hObject, eventdata, handles)
% hObject    handle to GS_option_e3thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GS_option_e3thresh as text
%        str2double(get(hObject,'String')) returns contents of GS_option_e3thresh as a double
userinput=get(hObject,'String');
checkinputdouble(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function GS_option_e3thresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GS_option_e3thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GS_option_e2thresh_Callback(hObject, eventdata, handles)
% hObject    handle to GS_option_e2thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GS_option_e2thresh as text
%        str2double(get(hObject,'String')) returns contents of GS_option_e2thresh as a double
userinput=get(hObject,'String');
checkinputdouble(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function GS_option_e2thresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GS_option_e2thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GS_option_e1thresh_Callback(hObject, eventdata, handles)
% hObject    handle to GS_option_e1thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GS_option_e1thresh as text
%        str2double(get(hObject,'String')) returns contents of GS_option_e1thresh as a double
userinput=get(hObject,'String');
checkinputdouble(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function GS_option_e1thresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GS_option_e1thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in GS_option_confirmthresh.
function GS_option_confirmthresh_Callback(hObject, eventdata, handles)
% hObject    handle to GS_option_confirmthresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of GS_option_confirmthresh



function GS_option_strobedig_Callback(hObject, eventdata, handles)
% hObject    handle to GS_option_strobedig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GS_option_strobedig as text
%        str2double(get(hObject,'String')) returns contents of GS_option_strobedig as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function GS_option_strobedig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GS_option_strobedig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GS_option_event1dig_Callback(hObject, eventdata, handles)
% hObject    handle to GS_option_event1dig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GS_option_event1dig as text
%        str2double(get(hObject,'String')) returns contents of GS_option_event1dig as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function GS_option_event1dig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GS_option_event1dig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GS_option_event2dig_Callback(hObject, eventdata, handles)
% hObject    handle to GS_option_event2dig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GS_option_event2dig as text
%        str2double(get(hObject,'String')) returns contents of GS_option_event2dig as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function GS_option_event2dig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GS_option_event2dig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GS_option_event3dig_Callback(hObject, eventdata, handles)
% hObject    handle to GS_option_event3dig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GS_option_event3dig as text
%        str2double(get(hObject,'String')) returns contents of GS_option_event3dig as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function GS_option_event3dig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GS_option_event3dig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GS_option_event4dig_Callback(hObject, eventdata, handles)
% hObject    handle to GS_option_event4dig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GS_option_event4dig as text
%        str2double(get(hObject,'String')) returns contents of GS_option_event4dig as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function GS_option_event4dig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GS_option_event4dig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function modified_closefcn(hObject, eventdata, handles)
GlobalSettingsHandles=guidata(hObject);
setappdata(0,'GS_options_opened',0);
if GlobalSettingsHandles.error >=1
    msgbox('You can not confirm settings if errors are present.','Error')
else
GS_options{1,1}='GS_option_recordfreq';
GS_options{1,2}=get(GlobalSettingsHandles.(GS_options{1,1})','String');
GS_options{2,1}='GS_option_ampgain';
GS_options{2,2}=get(GlobalSettingsHandles.(GS_options{2,1})','String');
GS_options{3,1}='GS_option_totalchans';
GS_options{3,2}=get(GlobalSettingsHandles.(GS_options{3,1})','String');
GS_options{4,1}='GS_option_lhchannel';
GS_options{4,2}=get(GlobalSettingsHandles.(GS_options{4,1})','String');
GS_options{5,1}='GS_option_rhchannel';
GS_options{5,2}=get(GlobalSettingsHandles.(GS_options{5,1})','String');
GS_options{6,1}='GS_option_vidgetchannel';
GS_options{6,2}=get(GlobalSettingsHandles.(GS_options{6,1})','String');
GS_options{7,1}='GS_option_strobechannel';
GS_options{7,2}=get(GlobalSettingsHandles.(GS_options{7,1})','String');
GS_options{8,1}='GS_option_event1channel';
GS_options{8,2}=get(GlobalSettingsHandles.(GS_options{8,1})','String');
GS_options{9,1}='GS_option_event2channel';
GS_options{9,2}=get(GlobalSettingsHandles.(GS_options{9,1})','String');
GS_options{10,1}='GS_option_event3channel';
GS_options{10,2}=get(GlobalSettingsHandles.(GS_options{10,1})','String');
GS_options{11,1}='GS_option_event4channel';
GS_options{11,2}=get(GlobalSettingsHandles.(GS_options{11,1})','String');
GS_options{12,1}='GS_option_e1thresh';
GS_options{12,2}=get(GlobalSettingsHandles.(GS_options{12,1})','String');
GS_options{13,1}='GS_option_e2thresh';
GS_options{13,2}=get(GlobalSettingsHandles.(GS_options{13,1})','String');
GS_options{14,1}='GS_option_e3thresh';
GS_options{14,2}=get(GlobalSettingsHandles.(GS_options{14,1})','String');
GS_options{15,1}='GS_option_e4thresh';
GS_options{15,2}=get(GlobalSettingsHandles.(GS_options{15,1})','String');
GS_options{16,1}='GS_option_strobedig';
GS_options{16,2}=get(GlobalSettingsHandles.(GS_options{16,1})','String');
GS_options{17,1}='GS_option_event1dig';
GS_options{17,2}=get(GlobalSettingsHandles.(GS_options{17,1})','String');
GS_options{18,1}='GS_option_event2dig';
GS_options{18,2}=get(GlobalSettingsHandles.(GS_options{18,1})','String');
GS_options{19,1}='GS_option_event3dig';
GS_options{19,2}=get(GlobalSettingsHandles.(GS_options{19,1})','String');
GS_options{20,1}='GS_option_event4dig';
GS_options{20,2}=get(GlobalSettingsHandles.(GS_options{20,1})','String');
GS_options{21,1}='GS_option_normwaves';
GS_options{21,2}=get(GlobalSettingsHandles.(GS_options{21,1})','Value');
GS_options{22,1}='GS_option_confirmthresh';
GS_options{22,2}=get(GlobalSettingsHandles.(GS_options{22,1})','Value');
GS_options{23,1}='GS_option_strobe_thresh';
GS_options{23,2}=get(GlobalSettingsHandles.(GS_options{23,1})','String');
GS_options{24,1}='GS_option_totaldigitalchans';
GS_options{24,2}=get(GlobalSettingsHandles.(GS_options{24,1})','String');

setappdata(0,'GS_options',GS_options);
setappdata(0,'GS_options_confirmed',2);
AnalysisHandles = guidata(AnalysisProgram);
set(AnalysisHandles.GlobalSettingsIndicator,'Backgroundcolor',[0 1 0]);
delete(hObject); 
end


function checkinput(hObject, userinput, handles)
    checkerror=get(hObject,'Backgroundcolor');
    if checkerror(1,1)==1 && checkerror(1,2) == 0 && checkerror(1,3) == 0
        number=str2num(userinput);
        checknumber=isempty(number);
        if checknumber==1
            msgbox('Input needs to be a number','Error')
            set(hObject,'String',''); 
            set(hObject,'Backgroundcolor','r');
        else
            checkint=isinteger(int8(number));
            if checkint == 0
                msgbox('Input needs to be a number','Error')
                set(hObject,'String',''); 
                set(hObject,'Backgroundcolor','r');
            else
                handles.error=handles.error-1;
                set(hObject,'Backgroundcolor','g');
            end
        end
    else
        if handles.error >= 1
            set(hObject,'String',''); 
            set(hObject,'Backgroundcolor','r');
            handles.error=handles.error+1;
            msgbox('There are other errors that should be corrected first.','Error')
        else
            number=str2num(userinput);
            checknumber=isempty(number);
            if checknumber==1
                handles.error=handles.error+1;
                msgbox('Input needs to be a number','Error')
                set(hObject,'String',''); 
                set(hObject,'Backgroundcolor','r');
            else
                checkint=isinteger(int8(number));
                if checkint == 0
                    handles.error=handles.error+1;
                    msgbox('Input needs to be a number','Error')
                    set(hObject,'String',''); 
                    set(hObject,'Backgroundcolor','r');
                else
                    handles.error=handles.error-1;
                    set(hObject,'Backgroundcolor','g');
                end
            end
        end
    end
guidata(hObject, handles); 

function checkinputdouble(hObject, userinput, handles)
    checkerror=get(hObject,'Backgroundcolor');
    if checkerror(1,1)==1 && checkerror(1,2) == 0 && checkerror(1,3) == 0
        number=str2num(userinput);
        checknumber=isempty(number);
        if checknumber==1
            msgbox('Input needs to be a number','Error')
            set(hObject,'String',''); 
            set(hObject,'Backgroundcolor','r');
        else
            handles.error=handles.error-1;
            set(hObject,'Backgroundcolor','g');
        end
    else
        if handles.error >= 1
            set(hObject,'String',''); 
            set(hObject,'Backgroundcolor','r');
            handles.error=handles.error+1;
            msgbox('There are other errors that should be corrected first.','Error')
        else
            number=str2num(userinput);
            checknumber=isempty(number);
            if checknumber==1
                handles.error=handles.error+1;
                msgbox('Input needs to be a number','Error')
                set(hObject,'String',''); 
                set(hObject,'Backgroundcolor','r');
            else
                set(hObject,'Backgroundcolor','g');
            end
        end
    end
guidata(hObject, handles);
    
            



function GS_option_strobe_thresh_Callback(hObject, eventdata, handles)
% hObject    handle to GS_option_strobe_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GS_option_strobe_thresh as text
%        str2double(get(hObject,'String')) returns contents of GS_option_strobe_thresh as a double
userinput=get(hObject,'String');
checkinputdouble(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function GS_option_strobe_thresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GS_option_strobe_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GS_option_totaldigitalchans_Callback(hObject, eventdata, handles)
% hObject    handle to GS_option_totaldigitalchans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GS_option_totaldigitalchans as text
%        str2double(get(hObject,'String')) returns contents of GS_option_totaldigitalchans as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function GS_option_totaldigitalchans_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GS_option_totaldigitalchans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
