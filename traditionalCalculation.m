function bearing = traditionalCalculation(sig1, sig2, sig3, frequency)
f1 = fft(sig1);
f2 = fft(sig2);
f3 = fft(sig3);

[~, p1] = max(abs(f1));
[~, p2] = max(abs(f2));
[~, p3] = max(max(f3));

t1 = angle(f1(p1)) / (2*pi*frequency);
t2 = angle(f2(p2)) / (2*pi*frequency);
t3 = angle(f3(p3)) / (2*pi*frequency);

bearing = atan((t3 - t2)/(2*(t3 - t1) - (t3 - t2)));
end