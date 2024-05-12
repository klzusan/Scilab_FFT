clear;
[s, Fs, bits] = wavread('ex2024.wav');
sf = fft(s);
sf_ = abs(sf);

j = 1;
for i = 1:5000
    if sf_(i) > 10000 then
        printf("f%d = %d\n", j, i);
        j = j + 1;
    end
end

[h, hm, fr] = wfir('bp', 700, [.026 .029], 'hm', );
cs = convol(s, h);
csf = fft(cs);
csf_ = abs(csf);

clf();
subplot(1,2,1);
plot2d(sf_, rect = [1000,0,4000,13000]);
xtitle('Original');
subplot(1,2,2);
plot2d(csf_, rect = [1000,0,4000,7000]);
xtitle('Filtered');

disp("End");
