%Defense Services Hackathon - Team Aeolus.
x=imread...
('E:\Projects\Defence Serv. Hackathon\ImageProcessingCodes/TankPlatoonHDImage.jpg');
image = double(x)/255;
[Rows, Columns, Dimensions] = size(image);
figure(1)
imshow(image)
t0 = cputime;

%------The Discrete Cosine Transformation------%
block_size = input('Size of blocks:');
diagonals = input('Number of diagonals to be considered ZigZag traversing:');
quantization_level = input('Number of quantization_levels:');

[quant_image, High, max, min, Ro, Co, Do]= ...
    dct_zigzag (image,Rows,Columns,Dimensions,diagonals,quantization_level,block_size);
length_quant = length(quant_image);

%------Huffman Encoding------%
Probability = zeros(1,High+1); %Finding the Probability.
for i = 0:High
    Probability(i+1)=length(find(quant_image==i))/(Ro*Co);
end

[compressed, data_length, codes, data] =...
    huffman_compression(quant_image, Probability, Ro, Co, Do, High);

%------Data Transmission------%
%--1. Channel Encoding-- --2. Modulation(BPSK)-- --3. ChannelEqualization--
%--4. DeModulation--- --5. Channel Decoding--%

[compressed_padded, padding, n0] = data_padding(compressed);
%-----Padding the data with sufficient number of bits so that a block of 40
% bits is taken at a time for processing, one after the other --------
% n0 is the total number of such 40 bit blocks formed---------

seconds = 0;
comprd = [];
for count = 1:n0
In_Enco__BPSK__Ch_Equa = n0 - count;
seconds = (cputime-t0);
comp1 = zeros(1,40);
    for x = 1:40
    comp1(x)=compressed_padded((count-1)*40 + x);
    end
    
% -----------Channel Encoding----------------
[encoded] = ch_encoding(comp1);

% -------------Modulation----------------
modulated=bpsk_modulation(encoded);

%-----------Channel Equalization-------------
filter_coeff=fir1(8,0.6);
snr=4;
equalized = equalizer(modulated,filter_coeff,snr);

% ------------DEMODULATION---------------------
demodulated=bpsk_demodulation(equalized);

% ----------CHANNEL DECODING-------------------
decoded = ch_decoding(demodulated);
comprd = [comprd decoded];
end
compressed_pro=comprd;
% % when channel not used
% compressed_pro = compressed;
% padding = 0;
%------Data Recovery / Huffman Decoding------%
recovered_data =...
recover_data (codes, data_length, compressed_pro, padding, data, length_quant);

%------Image Recovery------%
%------IDCT & ZigZag Decoding------%
recovered_image = ...
idct_zigzag(recovered_data,diagonals,max,min,High,Ro,Co,Do,block_size,Rows,Columns,Dimensions);

%------Output------%
figure(4)
imshow(recovered_image);
MSE=sqrt(sum(((recovered_image(:)-image(:)).^2))/(Ro*Co*Do));
SNR=sqrt((sum((recovered_image(:)).^2))/(Ro*Co*Do))/MSE;
RUN_TIME_IN_MINUTES = (cputime-t0)/60;
quantization_level;
Size_of_Block_taken_for_DCT = block_size;
Nmber_of_diagonals = diagonals;
COMPRESSION_RATIO = 8*Ro*Co*Do/length(compressed);
SNR;