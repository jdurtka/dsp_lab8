% James Durtka
% EELE 477 Spring 2017
% Lab #8 - SPFirst P-13

%4.1 testing the dtmfdesign() function

fb = [697 770 852 941 1209 1336 1477 1633];
fs = 8000;

Ln = 173;
Ln_filters = (dtmfdesign(fb,Ln,fs))';

ww = [0:0.001:pi];

% Code for comparing the two possible filter lengths follows.
% Experimental results: length-40 does a poor job discriminating
% signals. Even length-80 does not uniquely filter a single frequency
% within the 1/sqrt(2) specification.
%
% 100 appears to be very borderline, so 110 or 120 is probably a safe
% choice.


%-----------------------------------------------------------
% Examine the filters
%-----------------------------------------------------------

figure

plot(ww,(1/sqrt(2))*ones(1,length(ww)));
hold on

size_n = size(Ln_filters);
length_n = size_n(1,1);
for ii = 1:length_n
    this_impulse = Ln_filters(ii,:);
    length(this_impulse);
    HH = freqz(this_impulse,1,ww);
    plot(ww,abs(HH));
end
xlabel('\omega');
ylabel('|H(e^{j\omega})|');
title('A set of BPFs (length 120) to filter DMTF signals');