function xx = dtmfdial(keyNames,fs)

% James Durtka
% EELE 477 Spring 2017
% Lab #8 - SPFirst P-13
% 3.1 dtmfdial() function

dtmf.keys = ['1','2','3','A';
            '4','5','6','B';
            '7','8','9','C';
            '*','0','#','D'];
dtmf.colTones = ones(4,1)*[1209,1336,1477,1633];
dtmf.rowTones = [697;770;852;941]*ones(1,4);

tone_length = 0.2;
silence_length = 0.05;

%Initialize empty vector for tones
xx = [];

%Input vector keyNames
for ii = 1:length(keyNames)
    thisKey = keyNames(ii);
    
    [coltone,rowtone] = find(thisKey==dtmf.keys);
    
    testExp = size(coltone);
    testVal = testExp(1);
    
    %If the character is not found...
    if (testVal == 0)
        fprintf(1,'Invalid character input to dtmfdial()');
        return;
    end
    
    %Else, continue
    freqA = dtmf.colTones(1,coltone);
    freqB = dtmf.rowTones(rowtone,1);
    
    %Append the tone
    num_samples = tone_length*fs;
    xx = [xx, cos(2*pi*freqA*(0:num_samples-1)/fs)+cos(2*pi*freqB*(0:num_samples-1)/fs)];
    
    %Append a period of silence
    xx = [xx, zeros(1,silence_length*fs)];
    
end