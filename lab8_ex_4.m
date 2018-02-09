% James Durtka
% EELE 477 Spring 2017
% Lab #8 - SPFirst P-13

%4.2 testing the dtmfscore() function

%------------------------------------------------
% Generate a test signal
%------------------------------------------------
xx = dtmfdial('5',8000);

%------------------------------------------------
% Generate the filters
%------------------------------------------------
fb = [697 770 852 941 1209 1336 1477 1633];
fs = 8000;

Ln = 120;
Ln_filters = (dtmfdesign(fb,Ln,fs))';

%------------------------------------------------
% Test the scoring function
%------------------------------------------------
size_n = size(Ln_filters);
length_n = size_n(1,1);
for ii = 1:length_n
    this_impulse = Ln_filters(ii,:);
    disp(fb(ii));
    disp(dtmfscore(xx,this_impulse));
end