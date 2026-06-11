clc;
clear;
close all;

%% Message Input

message = 'HELLO THIS IS A BPSK COMMUNICATION SYSTEM PROJECT';

%% Text to Binary

ascii = double(message);

binary_matrix = dec2bin(ascii,8);

bits = reshape(binary_matrix' - '0',1,[]);

%% BPSK Modulation

bpsk = 2*bits - 1;

%% Add Noise

noise = 0.2 * randn(size(bpsk));
received = bpsk + noise;

%% Receiver

recovered_bits = received > 0;

%% BER Calculation

errors = sum(bits ~= recovered_bits);

BER = errors / length(bits);

%% Binary to Text

recovered_matrix = reshape(recovered_bits,8,[])';

recovered_ascii = bin2dec(num2str(recovered_matrix));

recovered_message = char(recovered_ascii)';

%% Display Results

disp('Original Message:')
disp(message)

disp('Recovered Message:')
disp(recovered_message)

disp(['Total Bits Transmitted = ', num2str(length(bits))]);
disp(['Total Bits Recovered = ', num2str(length(recovered_bits))]);

fprintf('Number of Errors = %d\n', errors);
fprintf('BER = %.3f\n', BER);

%% Plots

figure;

subplot(3,1,1);
stairs(bits,'LineWidth',2);
title('Binary Data');
ylim([-0.5 1.5]);
grid on;

subplot(3,1,2);
stairs(bpsk,'LineWidth',2);
title('BPSK Modulated Signal');
ylim([-1.5 1.5]);
grid on;

subplot(3,1,3);
plot(received,'o-','LineWidth',1.5);
title('Received Signal with Noise');
grid on;

figure;

subplot(2,1,1)
stairs(bits,'LineWidth',2)
title('Original Bits')
ylim([-0.5 1.5])
grid on

subplot(2,1,2)
stairs(recovered_bits,'LineWidth',2)
title('Recovered Bits')
ylim([-0.5 1.5])
grid on

%% BER vs Noise Analysis

noise_levels = [0.1 0.3 0.5 0.7 1.0];

BER_values = zeros(size(noise_levels));

for i = 1:length(noise_levels)

    noise = noise_levels(i) * randn(size(bpsk));

    received = bpsk + noise;

    recovered_bits = received > 0;

    errors = sum(bits ~= recovered_bits);

    BER_values(i) = errors / length(bits);

end

figure;

plot(noise_levels, BER_values, '-o', 'LineWidth', 2);

title('BER vs Noise Level');

xlabel('Noise Level');

ylabel('Bit Error Rate (BER)');

grid on;
