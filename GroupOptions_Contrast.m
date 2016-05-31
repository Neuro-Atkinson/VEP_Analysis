function varargout = GroupOptions_Contrast(varargin)
% GROUPOPTIONS_CONTRAST MATLAB code for GroupOptions_Contrast.fig
%      GROUPOPTIONS_CONTRAST, by itself, creates a new GROUPOPTIONS_CONTRAST or raises the existing
%      singleton*.
%
%      H = GROUPOPTIONS_CONTRAST returns the handle to a new GROUPOPTIONS_CONTRAST or the handle to
%      the existing singleton*.
%
%      GROUPOPTIONS_CONTRAST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GROUPOPTIONS_CONTRAST.M with the given input arguments.
%
%      GROUPOPTIONS_CONTRAST('Property','Value',...) creates a new GROUPOPTIONS_CONTRAST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GroupOptions_Contrast_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GroupOptions_Contrast_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GroupOptions_Contrast

% Last Modified by GUIDE v2.5 18-Mar-2015 14:31:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GroupOptions_Contrast_OpeningFcn, ...
                   'gui_OutputFcn',  @GroupOptions_Contrast_OutputFcn, ...
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


% --- Executes just before GroupOptions_Contrast is made visible.
function GroupOptions_Contrast_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GroupOptions_Contrast (see VARARGIN)

% Choose default command line output for GroupOptions_Contrast
handles.output = hObject;
handles.forceclose=0;
LoadOptions=getappdata(0,'Contrast_group_options');
if isempty(LoadOptions)==0
    for i = 1:22
        if i < 7
            if i == 1
                set(handles.(LoadOptions{i,1}),'String',(LoadOptions{i,2}));
                handles=startup_groups(handles);
            else
                set(handles.(LoadOptions{i,1}),'String',(LoadOptions{i,2}));
            end
        elseif i < 12
            set(handles.(LoadOptions{i,1}),'BackgroundColor',(LoadOptions{i,2}));
        elseif i == 12
            set(handles.Contrast_options_group1_files,'String',(LoadOptions{i,2}));
            handles.group1fname=LoadOptions{i,2};
            handles.group1pathname=LoadOptions{i+1,2};
            filenum=length(LoadOptions{i,2});
            titlestring=sprintf('Group %s Files (%s)',num2str(i-11),num2str(filenum));
            set(handles.group1listtxt,'String',titlestring);
        elseif i == 14
            set(handles.Contrast_options_group2_files,'String',(LoadOptions{i,2}));
            handles.group2fname=LoadOptions{i,2};
            handles.group2pathname=LoadOptions{i+1,2};
            filenum=length(LoadOptions{i,2});
            titlestring=sprintf('Group %s Files (%s)',num2str(i-12),num2str(filenum));
            set(handles.group2listtxt,'String',titlestring);
        elseif i == 16
            set(handles.Contrast_options_group3_files,'String',(LoadOptions{i,2}));
            handles.group3fname=LoadOptions{i,2};
            handles.group3pathname=LoadOptions{i+1,2};
            filenum=length(LoadOptions{i,2});
            titlestring=sprintf('Group %s Files (%s)',num2str(i-13),num2str(filenum));
            set(handles.group3listtxt,'String',titlestring);
        elseif i == 18
            set(handles.Contrast_options_group4_files,'String',(LoadOptions{i,2}));
            handles.group4fname=LoadOptions{i,2};
            handles.group4pathname=LoadOptions{i+1,2};
            filenum=length(LoadOptions{i,2});
            titlestring=sprintf('Group %s Files (%s)',num2str(i-14),num2str(filenum));
            set(handles.group4listtxt,'String',titlestring);
        elseif i == 20
            set(handles.Contrast_options_group5_files,'String',(LoadOptions{i,2}));
            handles.group5fname=LoadOptions{i,2};
            handles.group5pathname=LoadOptions{i+1,2};
            filenum=length(LoadOptions{i,2});
            titlestring=sprintf('Group %s Files (%s)',num2str(i-15),num2str(filenum));
            set(handles.group5listtxt,'String',titlestring);
        elseif i == 22
            handles.groupsloaded=LoadOptions{i,2};
        end
    end
    
else
    handles.groupsloaded=[0,0,0,0,0];
    handles.group1fname='Load Group 1 Files';
    handles.group1pathname='';
    handles.group2fname='Load Group 2 Files';
    handles.group2pathname='';
    handles.group3fname='Load Group 3 Files';
    handles.group3pathname='';
    handles.group4fname='Load Group 4 Files';
    handles.group4pathname='';
    handles.group5fname='Load Group 5 Files';
    handles.group5pathname='';
end
handles.error = 0;

% Update handles structure
guidata(hObject, handles);
set(gcf,'CloseRequestFcn',@modified_closefcn)
% UIWAIT makes GroupOptions_Contrast wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GroupOptions_Contrast_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Contrast_options_group_num_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast_options_group_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Contrast_options_group_num as text
%        str2double(get(hObject,'String')) returns contents of Contrast_options_group_num as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);
if handles.error > 1
    return;
else
    num_userinput=str2num(userinput);
    if num_userinput == 1
        set(handles.Contrast_options_color_group2,'Visible','off');
        set(handles.group2colortxt,'Visible','off');
        set(handles.Contrast_options_group2name,'Visible','off');
        set(handles.group2nametxt,'Visible','off');
        set(handles.Contrast_options_group2_files,'Visible','off');
        set(handles.group2listtxt,'Visible','off');
        set(handles.cleargroup2,'Visible','off');
        
        set(handles.Contrast_options_color_group3,'Visible','off');
        set(handles.group3colortxt,'Visible','off');
        set(handles.Contrast_options_group3name,'Visible','off');
        set(handles.group3nametxt,'Visible','off');
        set(handles.Contrast_options_group3_files,'Visible','off');
        set(handles.group3listtxt,'Visible','off');
        set(handles.cleargroup3,'Visible','off');
        
        set(handles.Contrast_options_color_group4,'Visible','off');
        set(handles.group4colortxt,'Visible','off');
        set(handles.Contrast_options_group4name,'Visible','off');
        set(handles.group4nametxt,'Visible','off');
        set(handles.Contrast_options_group4_files,'Visible','off');
        set(handles.group4listtxt,'Visible','off');
        set(handles.cleargroup4,'Visible','off');
        
        set(handles.Contrast_options_color_group5,'Visible','off');
        set(handles.group5colortxt,'Visible','off');
        set(handles.Contrast_options_group5name,'Visible','off');
        set(handles.group5nametxt,'Visible','off');
        set(handles.Contrast_options_group5_files,'Visible','off');
        set(handles.group5listtxt,'Visible','off');
        set(handles.cleargroup5,'Visible','off');
        
    elseif num_userinput == 2
        set(handles.Contrast_options_color_group2,'Visible','on');
        set(handles.group2colortxt,'Visible','on');
        set(handles.Contrast_options_group2name,'Visible','on');
        set(handles.group2nametxt,'Visible','on');
        set(handles.Contrast_options_group2_files,'Visible','on');
        set(handles.group2listtxt,'Visible','on');
        set(handles.cleargroup2,'Visible','on');
        
        set(handles.Contrast_options_color_group3,'Visible','off');
        set(handles.group3colortxt,'Visible','off');
        set(handles.Contrast_options_group3name,'Visible','off');
        set(handles.group3nametxt,'Visible','off');
        set(handles.Contrast_options_group3_files,'Visible','off');
        set(handles.group3listtxt,'Visible','off');
        set(handles.cleargroup3,'Visible','off');
        
        set(handles.Contrast_options_color_group4,'Visible','off');
        set(handles.group4colortxt,'Visible','off');
        set(handles.Contrast_options_group4name,'Visible','off');
        set(handles.group4nametxt,'Visible','off');
        set(handles.Contrast_options_group4_files,'Visible','off');
        set(handles.group4listtxt,'Visible','off');
        set(handles.cleargroup4,'Visible','off');
        
        set(handles.Contrast_options_color_group5,'Visible','off');
        set(handles.group5colortxt,'Visible','off');
        set(handles.Contrast_options_group5name,'Visible','off');
        set(handles.group5nametxt,'Visible','off');
        set(handles.Contrast_options_group5_files,'Visible','off');
        set(handles.group5listtxt,'Visible','off');
        set(handles.cleargroup5,'Visible','off');
        
    elseif num_userinput == 3
        set(handles.Contrast_options_color_group2,'Visible','on');
        set(handles.group2colortxt,'Visible','on');
        set(handles.Contrast_options_group2name,'Visible','on');
        set(handles.group2nametxt,'Visible','on');
        set(handles.Contrast_options_group2_files,'Visible','on');
        set(handles.group2listtxt,'Visible','on');
        set(handles.cleargroup2,'Visible','on');
        
        set(handles.Contrast_options_color_group3,'Visible','on');
        set(handles.group3colortxt,'Visible','on');
        set(handles.Contrast_options_group3name,'Visible','on');
        set(handles.group3nametxt,'Visible','on');
        set(handles.Contrast_options_group3_files,'Visible','on');
        set(handles.group3listtxt,'Visible','on');
        set(handles.cleargroup3,'Visible','on');
        
        set(handles.Contrast_options_color_group4,'Visible','off');
        set(handles.group4colortxt,'Visible','off');
        set(handles.Contrast_options_group4name,'Visible','off');
        set(handles.group4nametxt,'Visible','off');
        set(handles.Contrast_options_group4_files,'Visible','off');
        set(handles.group4listtxt,'Visible','off');
        set(handles.cleargroup4,'Visible','off');
        
        set(handles.Contrast_options_color_group5,'Visible','off');
        set(handles.group5colortxt,'Visible','off');
        set(handles.Contrast_options_group5name,'Visible','off');
        set(handles.group5nametxt,'Visible','off');
        set(handles.Contrast_options_group5_files,'Visible','off');
        set(handles.group5listtxt,'Visible','off');
        set(handles.cleargroup5,'Visible','off');
        
    elseif num_userinput == 4
        set(handles.Contrast_options_color_group2,'Visible','on');
        set(handles.group2colortxt,'Visible','on');
        set(handles.Contrast_options_group2name,'Visible','on');
        set(handles.group2nametxt,'Visible','on');
        set(handles.Contrast_options_group2_files,'Visible','on');
        set(handles.group2listtxt,'Visible','on');
        set(handles.cleargroup2,'Visible','on');
        
        set(handles.Contrast_options_color_group3,'Visible','on');
        set(handles.group3colortxt,'Visible','on');
        set(handles.Contrast_options_group3name,'Visible','on');
        set(handles.group3nametxt,'Visible','on');
        set(handles.Contrast_options_group3_files,'Visible','on');
        set(handles.group3listtxt,'Visible','on');
        set(handles.cleargroup3,'Visible','on');
        
        set(handles.Contrast_options_color_group4,'Visible','on');
        set(handles.group4colortxt,'Visible','on');
        set(handles.Contrast_options_group4name,'Visible','on');
        set(handles.group4nametxt,'Visible','on');
        set(handles.Contrast_options_group4_files,'Visible','on');
        set(handles.group4listtxt,'Visible','on');
        set(handles.cleargroup4,'Visible','on');
        
        set(handles.Contrast_options_color_group5,'Visible','off');
        set(handles.group5colortxt,'Visible','off');
        set(handles.Contrast_options_group5name,'Visible','off');
        set(handles.group5nametxt,'Visible','off');
        set(handles.Contrast_options_group5_files,'Visible','off');
        set(handles.group5listtxt,'Visible','off');
        set(handles.cleargroup5,'Visible','off');
    elseif num_userinput == 5
        set(handles.Contrast_options_color_group2,'Visible','on');
        set(handles.group2colortxt,'Visible','on');
        set(handles.Contrast_options_group2name,'Visible','on');
        set(handles.group2nametxt,'Visible','on');
        set(handles.Contrast_options_group2_files,'Visible','on');
        set(handles.group2listtxt,'Visible','on');
        set(handles.cleargroup2,'Visible','on');
        
        set(handles.Contrast_options_color_group3,'Visible','on');
        set(handles.group3colortxt,'Visible','on');
        set(handles.Contrast_options_group3name,'Visible','on');
        set(handles.group3nametxt,'Visible','on');
        set(handles.Contrast_options_group3_files,'Visible','on');
        set(handles.group3listtxt,'Visible','on');
        set(handles.cleargroup3,'Visible','on');
        
        set(handles.Contrast_options_color_group4,'Visible','on');
        set(handles.group4colortxt,'Visible','on');
        set(handles.Contrast_options_group4name,'Visible','on');
        set(handles.group4nametxt,'Visible','on');
        set(handles.Contrast_options_group4_files,'Visible','on');
        set(handles.group4listtxt,'Visible','on');
        set(handles.cleargroup4,'Visible','on');
        
        set(handles.Contrast_options_color_group5,'Visible','on');
        set(handles.group5colortxt,'Visible','on');
        set(handles.Contrast_options_group5name,'Visible','on');
        set(handles.group5nametxt,'Visible','on');
        set(handles.Contrast_options_group5_files,'Visible','on');
        set(handles.group5listtxt,'Visible','on');
        set(handles.cleargroup5,'Visible','on');
    end
    
end


% --- Executes during object creation, after setting all properties.
function Contrast_options_group_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Contrast_options_group_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Contrast_options_group1name_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast_options_group1name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Contrast_options_group1name as text
%        str2double(get(hObject,'String')) returns contents of Contrast_options_group1name as a double
userinput=get(hObject,'String');
checkinputString(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function Contrast_options_group1name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Contrast_options_group1name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Contrast_options_group2name_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast_options_group2name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Contrast_options_group2name as text
%        str2double(get(hObject,'String')) returns contents of Contrast_options_group2name as a double
userinput=get(hObject,'String');
checkinputString(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function Contrast_options_group2name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Contrast_options_group2name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Contrast_options_group3name_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast_options_group3name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Contrast_options_group3name as text
%        str2double(get(hObject,'String')) returns contents of Contrast_options_group3name as a double
userinput=get(hObject,'String');
checkinputString(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function Contrast_options_group3name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Contrast_options_group3name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Contrast_options_group4name_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast_options_group4name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Contrast_options_group4name as text
%        str2double(get(hObject,'String')) returns contents of Contrast_options_group4name as a double
userinput=get(hObject,'String');
checkinputString(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function Contrast_options_group4name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Contrast_options_group4name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Contrast_options_group5name_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast_options_group5name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Contrast_options_group5name as text
%        str2double(get(hObject,'String')) returns contents of Contrast_options_group5name as a double
userinput=get(hObject,'String');
checkinputString(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function Contrast_options_group5name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Contrast_options_group5name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in Contrast_options_group1_files.
function Contrast_options_group1_files_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast_options_group1_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Contrast_options_group1_files contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Contrast_options_group1_files


% --- Executes during object creation, after setting all properties.
function Contrast_options_group1_files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Contrast_options_group1_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Contrast_options_color_group1.
function Contrast_options_color_group1_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast_options_color_group1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.group1_color=uisetcolor;
set(handles.Contrast_options_color_group1,'BackgroundColor',handles.group1_color);
guidata(hObject, handles);


% --- Executes on button press in Contrast_options_color_group2.
function Contrast_options_color_group2_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast_options_color_group2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.group2_color=uisetcolor;
set(handles.Contrast_options_color_group2,'BackgroundColor',handles.group2_color);
guidata(hObject, handles);

% --- Executes on button press in Contrast_options_color_group3.
function Contrast_options_color_group3_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast_options_color_group3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.group3_color=uisetcolor;
set(handles.Contrast_options_color_group3,'BackgroundColor',handles.group3_color);
guidata(hObject, handles);

% --- Executes on button press in Contrast_options_color_group4.
function Contrast_options_color_group4_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast_options_color_group4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.group4_color=uisetcolor;
set(handles.Contrast_options_color_group4,'BackgroundColor',handles.group4_color);
guidata(hObject, handles);

% --- Executes on button press in Contrast_options_color_group5.
function Contrast_options_color_group5_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast_options_color_group5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.group5_color=uisetcolor;
set(handles.Contrast_options_color_group5,'BackgroundColor',handles.group5_color);
guidata(hObject, handles);


% --- Executes on selection change in Contrast_options_group2_files.
function Contrast_options_group2_files_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast_options_group2_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Contrast_options_group2_files contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Contrast_options_group2_files


% --- Executes during object creation, after setting all properties.
function Contrast_options_group2_files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Contrast_options_group2_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Contrast_options_group3_files.
function Contrast_options_group3_files_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast_options_group3_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Contrast_options_group3_files contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Contrast_options_group3_files


% --- Executes during object creation, after setting all properties.
function Contrast_options_group3_files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Contrast_options_group3_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Contrast_options_group5_files.
function Contrast_options_group5_files_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast_options_group5_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Contrast_options_group5_files contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Contrast_options_group5_files


% --- Executes during object creation, after setting all properties.
function Contrast_options_group5_files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Contrast_options_group5_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Contrast_options_group4_files.
function Contrast_options_group4_files_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast_options_group4_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Contrast_options_group4_files contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Contrast_options_group4_files


% --- Executes during object creation, after setting all properties.
function Contrast_options_group4_files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Contrast_options_group4_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function checkinputString(hObject, userinput, handles)
    checkerror=get(hObject,'Backgroundcolor');
    if checkerror(1,1)==1 && checkerror(1,2) == 0 && checkerror(1,3) == 0
        string= isvarname(userinput);
        if string == 0
            msgbox('Group name must be a valid variable format','Error');
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
            msgbox('There are other errors that should be corrected first.','Error');
        else
            string=isvarname(userinput);
            if string == 0
                handles.error=handles.error+1;
                msgbox('Group name must be a valid variable format','Error');
                set(hObject,'String','');
                set(hObject,'Backgroundcolor','r');
            else
                handles.error=handles.error-1;
                set(hObject,'Backgroundcolor','g');
            end
        end
    end
guidata(hObject, handles);
 

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
            elseif number > 5
                msgbox('Input needs to be a number less than 5','Error')
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
                elseif number > 5
                    handles.error=handles.error+1;
                    msgbox('Input needs to be a number less than 5','Error')
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


function modified_closefcn(hObject, eventdata, handles)
Contrast_GroupSettingsHandles=guidata(hObject);
if Contrast_GroupSettingsHandles.forceclose==1
    delete(hObject);
else
    if Contrast_GroupSettingsHandles.error >=1
        msgbox('You can not confirm settings if errors are present.','Error')
    else

        Contrast_group_options{1,1}='Contrast_options_group_num';
        Contrast_group_options{1,2}=get(Contrast_GroupSettingsHandles.(Contrast_group_options{1,1})','String');
        Contrast_group_options{2,1}='Contrast_options_group1name';
        Contrast_group_options{2,2}=get(Contrast_GroupSettingsHandles.(Contrast_group_options{2,1})','String');
        Contrast_group_options{3,1}='Contrast_options_group2name';
        Contrast_group_options{3,2}=get(Contrast_GroupSettingsHandles.(Contrast_group_options{3,1})','String');
        Contrast_group_options{4,1}='Contrast_options_group3name';
        Contrast_group_options{4,2}=get(Contrast_GroupSettingsHandles.(Contrast_group_options{4,1})','String');
        Contrast_group_options{5,1}='Contrast_options_group4name';
        Contrast_group_options{5,2}=get(Contrast_GroupSettingsHandles.(Contrast_group_options{5,1})','String');
        Contrast_group_options{6,1}='Contrast_options_group5name';
        Contrast_group_options{6,2}=get(Contrast_GroupSettingsHandles.(Contrast_group_options{6,1})','String');
        Contrast_group_options{7,1}='Contrast_options_color_group1';
        Contrast_group_options{7,2}=get(Contrast_GroupSettingsHandles.(Contrast_group_options{7,1})','BackgroundColor');
        Contrast_group_options{8,1}='Contrast_options_color_group2';
        Contrast_group_options{8,2}=get(Contrast_GroupSettingsHandles.(Contrast_group_options{8,1})','BackgroundColor');
        Contrast_group_options{9,1}='Contrast_options_color_group3';
        Contrast_group_options{9,2}=get(Contrast_GroupSettingsHandles.(Contrast_group_options{9,1})','BackgroundColor');
        Contrast_group_options{10,1}='Contrast_options_color_group4';
        Contrast_group_options{10,2}=get(Contrast_GroupSettingsHandles.(Contrast_group_options{10,1})','BackgroundColor');
        Contrast_group_options{11,1}='Contrast_options_color_group5';
        Contrast_group_options{11,2}=get(Contrast_GroupSettingsHandles.(Contrast_group_options{11,1})','BackgroundColor');

        Contrast_group_options{12,1}='Contrast_options_group1files';
        Contrast_group_options{12,2}=Contrast_GroupSettingsHandles.group1fname;
        Contrast_group_options{13,1}='Contrast_options_group1paths';
        Contrast_group_options{13,2}=Contrast_GroupSettingsHandles.group1pathname;

        Contrast_group_options{14,1}='Contrast_options_group2files';
        Contrast_group_options{14,2}=Contrast_GroupSettingsHandles.group2fname;
        Contrast_group_options{15,1}='Contrast_options_group2paths';
        Contrast_group_options{15,2}=Contrast_GroupSettingsHandles.group2pathname;

        Contrast_group_options{16,1}='Contrast_options_group3files';
        Contrast_group_options{16,2}=Contrast_GroupSettingsHandles.group3fname;
        Contrast_group_options{17,1}='Contrast_options_group3paths';
        Contrast_group_options{17,2}=Contrast_GroupSettingsHandles.group3pathname;

        Contrast_group_options{18,1}='Contrast_options_group4files';
        Contrast_group_options{18,2}=Contrast_GroupSettingsHandles.group4fname;
        Contrast_group_options{19,1}='Contrast_options_group4paths';
        Contrast_group_options{19,2}=Contrast_GroupSettingsHandles.group4pathname;

        Contrast_group_options{20,1}='Contrast_options_group5files';
        Contrast_group_options{20,2}=Contrast_GroupSettingsHandles.group5fname;
        Contrast_group_options{21,1}='Contrast_options_group5paths';
        Contrast_group_options{21,2}=Contrast_GroupSettingsHandles.group5pathname;

        Contrast_group_options{22,1}='groupsloaded';
        Contrast_group_options{22,2}=Contrast_GroupSettingsHandles.groupsloaded;

        setappdata(0,'Contrast_group_options',Contrast_group_options);
        setappdata(0,'Contrast_group_options_confirmed',2);


        Contrast_GroupHandles = guidata(ContrastAnalysis_Master);
        groupsloaded=sum(Contrast_GroupSettingsHandles.groupsloaded);
        numgroups=str2num(get(Contrast_GroupSettingsHandles.Contrast_options_group_num,'String'));
        if groupsloaded==0 || groupsloaded ~= numgroups
            set(Contrast_GroupHandles.GroupSettingsIndicator,'Backgroundcolor',[1 .6 0]);
            msgbox('Data can not be processed until all groups are properly loaded.','Error')
            set(Contrast_GroupHandles.ProcessDataButton,'Enable','off');
        else
            set(Contrast_GroupHandles.GroupSettingsIndicator,'Backgroundcolor',[0 1 0]);
            general_options_check=get(Contrast_GroupHandles.ContrastSettingsIndicator,'Backgroundcolor');
            if general_options_check == [0 1 0]
                set(Contrast_GroupHandles.ProcessDataButton,'Enable','on');
            end
        end
        delete(hObject);
    end
end




% --- Executes on button press in loadgroupbutton.
function loadgroupbutton_Callback(hObject, eventdata, handles)
% hObject    handle to loadgroupbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
checkgrouplimit=str2num(get(handles.Contrast_options_group_num,'String'));
set(handles.Contrast_options_group_num,'Enable','off');
set(hObject,'Enable','off');
for i=1:checkgrouplimit
    if handles.groupsloaded(1,i)==0
        clear fname pathname files ftitle
        ftitle = sprintf('Select Group %s Files',num2str(i));
        [fname,pathname] = uigetfile('*.dat',ftitle,'MultiSelect','on');
        
        if iscell(fname)==0
            fname={fname};
        end
        
        file_length=length(fname);
        for filenum=1:file_length 
            valid_name=isvarname(fname{1,filenum}(1,1:end-4));
            if valid_name==0
                output=sprintf('The following filename was incompatible with the program: %s',fname{1,filenum});
                msgbox(output,'Error');
                set(handles.Contrast_options_group_num,'Enable','on');
                set(hObject,'Enable','on')
                return;
            end
        end
        
        titlestring=sprintf('Group %s Files (%s)',num2str(i),num2str(filenum));
        if i == 1
            handles.group1fname=fname;
            handles.group1pathname=pathname;
            handles.groupsloaded(1,i)=1;
            set(handles.Contrast_options_group1_files,'String',fname);
            set(handles.group1listtxt,'String',titlestring);
        elseif i == 2
            handles.group2fname=fname;
            handles.group2pathname=pathname;
            handles.groupsloaded(1,i)=1;
            set(handles.Contrast_options_group2_files,'String',fname);
            set(handles.group2listtxt,'String',titlestring);
        elseif i == 3
            handles.group3fname=fname;
            handles.group3pathname=pathname;
            handles.groupsloaded(1,i)=1;
            set(handles.Contrast_options_group3_files,'String',fname);
            set(handles.group3listtxt,'String',titlestring);
        elseif i == 4
            handles.group4fname=fname;
            handles.group4pathname=pathname;
            handles.groupsloaded(1,i)=1; 
            set(handles.Contrast_options_group4_files,'String',fname);
            set(handles.group4listtxt,'String',titlestring);
        elseif i == 5
            handles.group5fname=fname;
            handles.group5pathname=pathname;
            handles.groupsloaded(1,i)=1;
            set(handles.Contrast_options_group5_files,'String',fname);
            set(handles.group5listtxt,'String',titlestring);
        end
    end
end
set(handles.Contrast_options_group_num,'Enable','on');
set(hObject,'Enable','on');
guidata(hObject, handles);
% --- Executes on button press in cleargroup1.
function cleargroup1_Callback(hObject, eventdata, handles)
% hObject    handle to cleargroup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.group1fname=[];
handles.group1pathname=[];
handles.groupsloaded(1,1)=0;
set(handles.Contrast_options_group1_files,'String','Load Group 1 Files');
guidata(hObject, handles);
% --- Executes on button press in cleargroup2.
function cleargroup2_Callback(hObject, eventdata, handles)
% hObject    handle to cleargroup2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.group2fname=[];
handles.group2pathname=[];
handles.groupsloaded(1,2)=0;
set(handles.Contrast_options_group2_files,'String','Load Group 2 Files');
guidata(hObject, handles);
% --- Executes on button press in cleargroup3.
function cleargroup3_Callback(hObject, eventdata, handles)
% hObject    handle to cleargroup3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.group3fname=[];
handles.group3pathname=[];
handles.groupsloaded(1,3)=0;
set(handles.Contrast_options_group3_files,'String','Load Group 3 Files');
guidata(hObject, handles);
% --- Executes on button press in cleargroup4.
function cleargroup4_Callback(hObject, eventdata, handles)
% hObject    handle to cleargroup4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.group4fname=[];
handles.group4pathname=[];
handles.groupsloaded(1,4)=0;
set(handles.Contrast_options_group4_files,'String','Load Group 4 Files');
guidata(hObject, handles);
% --- Executes on button press in cleargroup5.
function cleargroup5_Callback(hObject, eventdata, handles)
% hObject    handle to cleargroup5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.group5fname=[];
handles.group5pathname=[];
handles.groupsloaded(1,5)=0;
set(handles.Contrast_options_group5_files,'String','Load Group 5 Files');
guidata(hObject, handles);


% --------------------------------------------------------------------
function guiwindowsoptions_Callback(hObject, eventdata, handles)
% hObject    handle to guiwindowsoptions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function forceclose_Callback(hObject, eventdata, handles)
% hObject    handle to forceclose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.forceclose=1;
set(hObject,'Checked','on');
guidata(hObject,handles);

function [handles]=startup_groups(handles)
groupnum=get(handles.Contrast_options_group_num,'String');
    num_userinput=str2num(groupnum);
    if num_userinput == 1
        set(handles.Contrast_options_color_group2,'Visible','off');
        set(handles.group2colortxt,'Visible','off');
        set(handles.Contrast_options_group2name,'Visible','off');
        set(handles.group2nametxt,'Visible','off');
        set(handles.Contrast_options_group2_files,'Visible','off');
        set(handles.group2listtxt,'Visible','off');
        set(handles.cleargroup2,'Visible','off');
        
        set(handles.Contrast_options_color_group3,'Visible','off');
        set(handles.group3colortxt,'Visible','off');
        set(handles.Contrast_options_group3name,'Visible','off');
        set(handles.group3nametxt,'Visible','off');
        set(handles.Contrast_options_group3_files,'Visible','off');
        set(handles.group3listtxt,'Visible','off');
        set(handles.cleargroup3,'Visible','off');
        
        set(handles.Contrast_options_color_group4,'Visible','off');
        set(handles.group4colortxt,'Visible','off');
        set(handles.Contrast_options_group4name,'Visible','off');
        set(handles.group4nametxt,'Visible','off');
        set(handles.Contrast_options_group4_files,'Visible','off');
        set(handles.group4listtxt,'Visible','off');
        set(handles.cleargroup4,'Visible','off');
        
        set(handles.Contrast_options_color_group5,'Visible','off');
        set(handles.group5colortxt,'Visible','off');
        set(handles.Contrast_options_group5name,'Visible','off');
        set(handles.group5nametxt,'Visible','off');
        set(handles.Contrast_options_group5_files,'Visible','off');
        set(handles.group5listtxt,'Visible','off');
        set(handles.cleargroup5,'Visible','off');
        
    elseif num_userinput == 2
        set(handles.Contrast_options_color_group2,'Visible','on');
        set(handles.group2colortxt,'Visible','on');
        set(handles.Contrast_options_group2name,'Visible','on');
        set(handles.group2nametxt,'Visible','on');
        set(handles.Contrast_options_group2_files,'Visible','on');
        set(handles.group2listtxt,'Visible','on');
        set(handles.cleargroup2,'Visible','on');
        
        set(handles.Contrast_options_color_group3,'Visible','off');
        set(handles.group3colortxt,'Visible','off');
        set(handles.Contrast_options_group3name,'Visible','off');
        set(handles.group3nametxt,'Visible','off');
        set(handles.Contrast_options_group3_files,'Visible','off');
        set(handles.group3listtxt,'Visible','off');
        set(handles.cleargroup3,'Visible','off');
        
        set(handles.Contrast_options_color_group4,'Visible','off');
        set(handles.group4colortxt,'Visible','off');
        set(handles.Contrast_options_group4name,'Visible','off');
        set(handles.group4nametxt,'Visible','off');
        set(handles.Contrast_options_group4_files,'Visible','off');
        set(handles.group4listtxt,'Visible','off');
        set(handles.cleargroup4,'Visible','off');
        
        set(handles.Contrast_options_color_group5,'Visible','off');
        set(handles.group5colortxt,'Visible','off');
        set(handles.Contrast_options_group5name,'Visible','off');
        set(handles.group5nametxt,'Visible','off');
        set(handles.Contrast_options_group5_files,'Visible','off');
        set(handles.group5listtxt,'Visible','off');
        set(handles.cleargroup5,'Visible','off');
        
    elseif num_userinput == 3
        set(handles.Contrast_options_color_group2,'Visible','on');
        set(handles.group2colortxt,'Visible','on');
        set(handles.Contrast_options_group2name,'Visible','on');
        set(handles.group2nametxt,'Visible','on');
        set(handles.Contrast_options_group2_files,'Visible','on');
        set(handles.group2listtxt,'Visible','on');
        set(handles.cleargroup2,'Visible','on');
        
        set(handles.Contrast_options_color_group3,'Visible','on');
        set(handles.group3colortxt,'Visible','on');
        set(handles.Contrast_options_group3name,'Visible','on');
        set(handles.group3nametxt,'Visible','on');
        set(handles.Contrast_options_group3_files,'Visible','on');
        set(handles.group3listtxt,'Visible','on');
        set(handles.cleargroup3,'Visible','on');
        
        set(handles.Contrast_options_color_group4,'Visible','off');
        set(handles.group4colortxt,'Visible','off');
        set(handles.Contrast_options_group4name,'Visible','off');
        set(handles.group4nametxt,'Visible','off');
        set(handles.Contrast_options_group4_files,'Visible','off');
        set(handles.group4listtxt,'Visible','off');
        set(handles.cleargroup4,'Visible','off');
        
        set(handles.Contrast_options_color_group5,'Visible','off');
        set(handles.group5colortxt,'Visible','off');
        set(handles.Contrast_options_group5name,'Visible','off');
        set(handles.group5nametxt,'Visible','off');
        set(handles.Contrast_options_group5_files,'Visible','off');
        set(handles.group5listtxt,'Visible','off');
        set(handles.cleargroup5,'Visible','off');
        
    elseif num_userinput == 4
        set(handles.Contrast_options_color_group2,'Visible','on');
        set(handles.group2colortxt,'Visible','on');
        set(handles.Contrast_options_group2name,'Visible','on');
        set(handles.group2nametxt,'Visible','on');
        set(handles.Contrast_options_group2_files,'Visible','on');
        set(handles.group2listtxt,'Visible','on');
        set(handles.cleargroup2,'Visible','on');
        
        set(handles.Contrast_options_color_group3,'Visible','on');
        set(handles.group3colortxt,'Visible','on');
        set(handles.Contrast_options_group3name,'Visible','on');
        set(handles.group3nametxt,'Visible','on');
        set(handles.Contrast_options_group3_files,'Visible','on');
        set(handles.group3listtxt,'Visible','on');
        set(handles.cleargroup3,'Visible','on');
        
        set(handles.Contrast_options_color_group4,'Visible','on');
        set(handles.group4colortxt,'Visible','on');
        set(handles.Contrast_options_group4name,'Visible','on');
        set(handles.group4nametxt,'Visible','on');
        set(handles.Contrast_options_group4_files,'Visible','on');
        set(handles.group4listtxt,'Visible','on');
        set(handles.cleargroup4,'Visible','on');
        
        set(handles.Contrast_options_color_group5,'Visible','off');
        set(handles.group5colortxt,'Visible','off');
        set(handles.Contrast_options_group5name,'Visible','off');
        set(handles.group5nametxt,'Visible','off');
        set(handles.Contrast_options_group5_files,'Visible','off');
        set(handles.group5listtxt,'Visible','off');
        set(handles.cleargroup5,'Visible','off');
    elseif num_userinput == 5
        set(handles.Contrast_options_color_group2,'Visible','on');
        set(handles.group2colortxt,'Visible','on');
        set(handles.Contrast_options_group2name,'Visible','on');
        set(handles.group2nametxt,'Visible','on');
        set(handles.Contrast_options_group2_files,'Visible','on');
        set(handles.group2listtxt,'Visible','on');
        set(handles.cleargroup2,'Visible','on');
        
        set(handles.Contrast_options_color_group3,'Visible','on');
        set(handles.group3colortxt,'Visible','on');
        set(handles.Contrast_options_group3name,'Visible','on');
        set(handles.group3nametxt,'Visible','on');
        set(handles.Contrast_options_group3_files,'Visible','on');
        set(handles.group3listtxt,'Visible','on');
        set(handles.cleargroup3,'Visible','on');
        
        set(handles.Contrast_options_color_group4,'Visible','on');
        set(handles.group4colortxt,'Visible','on');
        set(handles.Contrast_options_group4name,'Visible','on');
        set(handles.group4nametxt,'Visible','on');
        set(handles.Contrast_options_group4_files,'Visible','on');
        set(handles.group4listtxt,'Visible','on');
        set(handles.cleargroup4,'Visible','on');
        
        set(handles.Contrast_options_color_group5,'Visible','on');
        set(handles.group5colortxt,'Visible','on');
        set(handles.Contrast_options_group5name,'Visible','on');
        set(handles.group5nametxt,'Visible','on');
        set(handles.Contrast_options_group5_files,'Visible','on');
        set(handles.group5listtxt,'Visible','on');
        set(handles.cleargroup5,'Visible','on');
    end
    


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Contrast_options_color_group1.
function Contrast_options_color_group1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Contrast_options_color_group1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
