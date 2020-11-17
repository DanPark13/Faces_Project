%% Find closest possible face

% Show random image onto a popup plot
subplot(121);
imshow(reshape(randomImage,112,92));
title('Mask Face');

% Calculate closest possible face
subplot(122);
p = randomImage-meanValue;
s = single(p)'*V;
B=[]; % empty array that stores search image signature

for i=1:size(remainingImages,2)
    B = [B,norm(allImageSignatures(i,:)-s,2)];
    if(rem(i,20) == 0),imshow(reshape(remainingImages(:,i),112,92)),end;
    drawnow;
end

% Show calculated closest image
[a,i] = min(B);
plot(122);
imshow(reshape(remainingImages(:,i),112,92));
title('No Mask Face');