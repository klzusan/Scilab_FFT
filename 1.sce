clear;
[s, Fs, bits] = wavread('ex2024.wav');
N = size(s, 'c');

win = window('hm', N);

sf = fft(s.*win);
sf_ = abs(sf);

x = Fs*(0:(N/2))/N;

j = 1;
for i = 1:12000
    if sf_(1:size(x, 'c'))(i) > 4000 then
        printf("f%d = %d\n", j, x(i));
        j = j + 1;
    end
end

[h, hm, fr] = wfir('bp', 400, [600/Fs 630/Fs], 'hm', );
cs = convol(s, h);

N_ = size(cs, 'c');
win_ = window('hm', N_);

csf = fft(cs.*win_);
csf_ = abs(csf);

x_ = Fs * (0:(N_/2))/N_;

scf(0);
clf;
subplot(1,2,1);
plot(x, sf_(1:size(x, 'c')));
xtitle('', 'Frequency [Hz]', 'Amplitude');

subplot(1,2,2);
plot(x_, csf_(1:size(x_, 'c')));
xtitle('', 'Frequency [Hz]', 'Amplitude');

scf(1);
clf;
subplot(1,2,1);
plot(h);
xtitle('', 't / ⊿t', 'h(n)');

subplot(1,2,2);
plot(hm);
xtitle('', 'f / fs', 'H(ω)');

savewave('res.wav', cs);
disp("End");
