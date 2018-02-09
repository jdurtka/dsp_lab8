function hh = dtmfdesign(fb, L, fs)

% James Durtka
% EELE 477 Spring 2017
% Lab #8 - SPFirst P-13
% 4.1 dtmfdesign() function

% hh = dtmfdesign(fb, L, fs)
% returns a matrix (L by length(fb)) where each column contains
% the impulse response of a BPF, one for each frequency in fb
% fb = vector of center frequencies
% L = length of FIR bandpass filters
% fs = sampling freq
%
% Each BPF must be scaled so that its frequency response has a
% maximum magnitude equal to one.

%create empty storage vector
hh = [];
%and indices
nn = (0:1:L-1);

%Experimentally determined value
beta = 2/L;

for ii = 1:length(fb)
    this_freq = fb(ii);
    
    %h[n] = beta*cos(2*pi*f_b*n/f_s), 0 <= n <= L-1
    hh = [hh (beta*cos(2*pi*this_freq*nn/fs))'];
end