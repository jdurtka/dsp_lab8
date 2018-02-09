function keys = dtmfrun(xx,L,fs)

% James Durtka
% EELE 477 Spring 2017
% Lab #8 - SPFirst P-13

% 4.3 dtmfrun() function
% Test by typing the following into the command line:
%
%       dtmfrun(dtmfdial('407*89132#BADC',8000),120,8000)

%DTMFRUN keys = dtmfrun(xx,L,fs)
% returns the list of key names found in xx.
% keys = array of characters, i.e., the decoded key names
% xx = DTMF waveform
% L = filter length
% fs = sampling freq
%

center_freqs = [697 770 852 941 1209 1336 1477 1633];
%L = 120;
%fs = 8000;

hh = (dtmfdesign( center_freqs,L,fs ))';
size_n = size(hh);
length_n = size_n(1,1);



%---------------------------------------------
dtmf.keys = ['1','2','3','A';
            '4','5','6','B';
            '7','8','9','C';
            '*','0','#','D'];
rowTones = [1209,1336,1477,1633];
colTones = [697;770;852;941];
%---------------------------------------------

[nstart,nstop] = dtmfcut(xx,fs); %<--Find the beginning and end of tone bursts
keys = [];
for kk=1:length(nstart)
    x_seg = xx(nstart(kk):nstop(kk)); %<--Extract one DTMF tone
    
    %plot(1:length(x_seg),x_seg);
    
    %Get the scores for each frequency
    scores = [];
    for ii = 1:length_n
        this_impulse = hh(ii,:);
        scores = [scores dtmfscore(x_seg,this_impulse)];
    end
    
    %scores
    %Backtrack to find the key pressed
    indices = find(scores == 1);
    frequencies = [];
    for ii = 1:length(indices)
        frequencies = [frequencies center_freqs(indices(ii))];
    end
    %indices

    %Find which is a row and which is a column
    row1 = find(rowTones == frequencies(1));
    row2 = find(rowTones == frequencies(2));
    col1 = find(colTones == frequencies(1));
    col2 = find(colTones == frequencies(2));
    %(Whichever is not, will result in a 0x1 matrix)
    r1 = length(row1);
    if (r1 == 0)
        row1 = row2;
    end
    c1 = length(col1);
    if (c1 == 0)
        col1 = col2;
    end
    %row1
    %col1
    
    %Now the correct row is definitely in row1 and the correct column is
    %definitely in col1...
    keys = [keys dtmf.keys(row1,col1)];
end

%Generate a spectrum with windowing based on the length of a single tone
%(in order to demonstrate the dual frequencies per tone)
segments = length(xx)/(2*length(keys));
spectrogram(xx,kaiser(segments));

figure
specgram(xx)