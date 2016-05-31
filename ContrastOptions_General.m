function varargout = ContrastOptions_General(varargin)
% CONTRASTOPTIONS_GENERAL MATLAB code for ContrastOptions_General.fig
%      CONTRASTOPTIONS_GENERAL, by itself, creates a new CONTRASTOPTIONS_GENERAL or raises the existing
%      singleton*.
%
%      H = CONTRASTOPTIONS_GENERAL returns the handle to a new CONTRASTOPTIONS_GENERAL or the handle to
%      the existing singleton*.
%
%      CONTRASTOPTIONS_GENERAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTRASTOPTIONS_GENERAL.M with the given input arguments.
%
%      CONTRASTOPTIONS_GENERAL('Property','Value',...) creates a new CONTRASTOPTIONS_GENERAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ContrastOptions_General_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ContrastOptions_General_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ContrastOptions_General

% Last Modified by GUIDE v2.5 29-Apr-2014 14:27:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ContrastOptions_General_OpeningFcn, ...
                   'gui_OutputFcn',  @ContrastOptions_General_OutputFcn, ...
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


% --- Executes just before ContrastOptions_General is made visible.
function ContrastOptions_General_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ContrastOptions_General (see VARARGIN)

% Choose default command line output for ContrastOptions_General
handles.output = hObject;

LoadOptions=getappdata(0,'CO_options');
if isempty(LoadOptions)==0
    looplength=length(LoadOptions);
    for i=1:looplength
        if i <= 5
            set(handles.(LoadOptions{i,1}),'String',(LoadOptions{i,2}));
        elseif i <= 8
            set(handles.(LoadOptions{i,1}),'Value',(LoadOptions{i,2}));  
        else
            set(handles.(LoadOptions{i,1}),'Data',(LoadOptions{i,2}));  
        end
    end
end

handles.error=0;
% Update handles structure
guidata(hObject, handles);
set(gcf,'CloseRequestFcn',@modified_closefcn)

% UIWAIT makes ContrastOptions_General wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ContrastOptions_General_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function CO_options_groups_Callback(hObject, eventdata, handles)
% hObject    handle to CO_options_groups (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CO_options_groups as text
%        str2double(get(hObject,'String')) returns contents of CO_options_groups as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);


% --- Executes during object creation, after setting all properties.
function CO_options_groups_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CO_options_groups (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CO_options_thresh_Callback(hObject, eventdata, handles)
% hObject    handle to CO_options_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CO_options_thresh as text
%        str2double(get(hObject,'String')) returns contents of CO_options_thresh as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);


% --- Executes during object creation, after setting all properties.
function CO_options_thresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CO_options_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CO_options_showcombined.
function CO_options_showcombined_Callback(hObject, eventdata, handles)
% hObject    handle to CO_options_showcombined (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CO_options_showcombined


% --- Executes on button press in CO_options_showleft.
function CO_options_showleft_Callback(hObject, eventdata, handles)
% hObject    handle to CO_options_showleft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CO_options_showleft


% --- Executes on button press in CO_options_showright.
function CO_options_showright_Callback(hObject, eventdata, handles)
% hObject    handle to CO_options_showright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CO_options_showright



function CO_options_windowmin_Callback(hObject, eventdata, handles)
% hObject    handle to CO_options_windowmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CO_options_windowmin as text
%        str2double(get(hObject,'String')) returns contents of CO_options_windowmin as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);


% --- Executes during object creation, after setting all properties.
function CO_options_windowmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CO_options_windowmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function CO_options_windowmax_Callback(hObject, eventdata, handles)
% hObject    handle to CO_options_windowmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CO_options_windowmax as text
%        str2double(get(hObject,'String')) returns contents of CO_options_windowmax as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);


% --- Executes during object creation, after setting all properties.
function CO_options_windowmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CO_options_windowmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function CO_options_contrastcodes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CO_options_contrastcodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'Data', {'2','4','6','8','10','30','50','100'});


% --- Executes during object creation, after setting all properties.
function CO_options_contrasteventcodes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CO_options_contrasteventcodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'Data', {1 3 5 7 9 11 13 15;2 4 6 8 10 12 14 16});



function CO_options_contrast_Callback(hObject, eventdata, handles)
% hObject    handle to CO_options_contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CO_options_contrast as text
%        str2double(get(hObject,'String')) returns contents of CO_options_contrast as a double


% --- Executes during object creation, after setting all properties.
function CO_options_contrast_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CO_options_contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function modified_closefcn(hObject, eventdata, handles)
ContrastSettingsHandles=guidata(hObject);
if ContrastSettingsHandles.error >=1
    msgbox('You can not confirm settings if errors are present.','Error')
else
CO_options{1,1}='CO_options_groups';
CO_options{1,2}=get(ContrastSettingsHandles.(CO_options{1,1})','String');
CO_options{2,1}='CO_options_thresh';
CO_options{2,2}=get(ContrastSettingsHandles.(CO_options{2,1})','String');
CO_options{3,1}='CO_options_contrast';
CO_options{3,2}=get(ContrastSettingsHandles.(CO_options{3,1})','String');
CO_options{4,1}='CO_options_windowmin';
CO_options{4,2}=get(ContrastSettingsHandles.(CO_options{4,1})','String');
CO_options{5,1}='CO_options_windowmax';
CO_options{5,2}=get(ContrastSettingsHandles.(CO_options{5,1})','String');
CO_options{6,1}='CO_options_showcombined';
CO_options{6,2}=get(ContrastSettingsHandles.(CO_options{6,1})','Value');
CO_options{7,1}='CO_options_showleft';
CO_options{7,2}=get(ContrastSettingsHandles.(CO_options{7,1})','Value');
CO_options{8,1}='CO_options_showright';
CO_options{8,2}=get(ContrastSettingsHandles.(CO_options{8,1})','Value');
CO_options{9,1}='CO_options_contrastcodes';
CO_options{9,2}=get(ContrastSettingsHandles.(CO_options{9,1})','Data');
CO_options{10,1}='CO_options_contrasteventcodes';
CO_options{10,2}=get(ContrastSettingsHandles.(CO_options{10,1})','Data');
setappdata(0,'CO_options',CO_options);
setappdata(0,'CO_options_confirmed',2);
AnalysisHandles = guidata(ContrastAnalysis_Master);
set(AnalysisHandles.ContrastSettingsIndicator,'Backgroundcolor',[0 1 0]);
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
