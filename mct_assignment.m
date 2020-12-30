function varargout = mct_assignment(varargin)
% MCT_ASSIGNMENT MATLAB code for mct_assignment.fig
%      MCT_ASSIGNMENT, by itself, creates a new MCT_ASSIGNMENT or raises the existing
%      singleton*.
%
%      H = MCT_ASSIGNMENT returns the handle to a new MCT_ASSIGNMENT or the handle to
%      the existing singleton*.
%
%      MCT_ASSIGNMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MCT_ASSIGNMENT.M with the given input arguments.
%
%      MCT_ASSIGNMENT('Property','Value',...) creates a new MCT_ASSIGNMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mct_assignment_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mct_assignment_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mct_assignment

% Last Modified by GUIDE v2.5 20-Nov-2020 09:46:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mct_assignment_OpeningFcn, ...
                   'gui_OutputFcn',  @mct_assignment_OutputFcn, ...
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


% --- Executes just before mct_assignment is made visible.
function mct_assignment_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mct_assignment (see VARARGIN)

% Choose default command line output for mct_assignment
handles.output = hObject;

axes(handles.axes1)
plot(0,0);
xlabel('time');
ylabel('signal');
title('time domain graph');

axes(handles.axes2)
plot(0,0);
xlabel('frequency');
ylabel('P_{X}');
title('Power spectral density')


% Update handles structure

guidata(hObject, handles);

% UIWAIT makes mct_assignment wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mct_assignment_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in source_data.
function source_data_Callback(hObject, eventdata, handles)
% hObject    handle to source_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns source_data contents as cell array
%        contents{get(hObject,'Value')} returns selected item from source_data
str = get(handles.source_data, 'String');
val = get(handles.source_data, 'Value');

switch str{val}
    case 'random bits'
        data=randi([0,1],30000,1);
    case 'text file'
        filename = 'sample_text.txt';
        data= text2bits(filename);
    case 'grayscale image'
        filename = 'sample_image.bmp';
        [data,m,n]=im2bits(filename);
        handles.image_m=m;
        handles.image_n=n;
    case 'audio file'
        filename='sample_audio.m4a';
        [data,fs]=audio2bits(filename);
        handles.fs=fs;
end
handles.data=data;
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function source_data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to source_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in channel_coding.
function channel_coding_Callback(hObject, eventdata, handles)
% hObject    handle to channel_coding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns channel_coding contents as cell array
%        contents{get(hObject,'Value')} returns selected item from channel_coding
str = get(handles.channel_coding, 'String');
val = get(handles.channel_coding, 'Value');
data=handles.data;
handles.encoded_data=Encode(str{val},data);
handles.data_to_be_modulated=handles.encoded_data;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function channel_coding_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel_coding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in modulation.
function modulation_Callback(hObject, eventdata, handles)
% hObject    handle to modulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns modulation contents as cell array
%        contents{get(hObject,'Value')} returns selected item from modulation
str = get(handles.modulation, 'String');
val = get(handles.modulation, 'Value');
data1=handles.data;
data2=handles.encoded_data;
[demod1_5,demod2_5] = modulation(data1,data2,str{val});
handles.demod2=demod2_5;
handles.demod1=demod1_5;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function modulation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to modulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in Display_Results.
function Display_Results_Callback(hObject, eventdata, handles)
% hObject    handle to Display_Results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(handles.channel_coding, 'String');
val = get(handles.channel_coding, 'Value');
data=handles.data;
demod_data1=handles.demod1;
demod_data2=handles.demod2;

decoded_data=Decode(str{val},demod_data2,length(data));

X_F=fft(demod_data1);
N=length(X_F);
X_k_ss=(2/N)*X_F(1:N/2);
psd=0.5*(X_k_ss.*conj(X_k_ss));
axes(handles.axes1)
plot(demod_data1);
xlabel('time');
ylabel('signal');
title('time domain graph');

axes(handles.axes2)
plot(psd);
xlabel('frequency');
ylabel('P_{X}');
xlim([-1000,N]);
title('Power spectral density')

str = get(handles.source_data, 'String');
val = get(handles.source_data, 'Value');

switch str{val}
    case 'random bits'
        set(handles.original_text, 'String',num2str(handles.data'));
        set(handles.with_coding_text, 'String',num2str(decoded_data) );
        set(handles.without_coding_text, 'String',num2str(demod_data1) );
    case 'text file'
        og_text=bits2text(data);
        decoded_text=bits2text(decoded_data);
        demod_text=bits2text(demod_data1);
        set(handles.original_text, 'String',og_text);
        set(handles.with_coding_text, 'String',decoded_text );
        set(handles.without_coding_text, 'String',demod_text );
        
    case 'grayscale image'
        m=handles.image_m;
        n=handles.image_n;
        og_image=bits2im(data,m,n);
        decoded_image=bits2im(decoded_data,m,n);
        demod_image=bits2im(demod_data1,m,n);
        figure()
        imshow(og_image);
        title('Original image');
        
        figure()
        imshow(decoded_image);
        title('Recieved image with coding');
        
        figure()
        imshow(demod_image);
        title('Recieved image without coding');
        
    case 'audio file'
        fs=handles.fs;
        og_audio=bits2audio(handles.data);
        decoded_audio=bits2audio(decoded_data);
        demod_audio=bits2audio(demod_data1);
        sound(og_audio,fs);
        pause(1);
       

end
