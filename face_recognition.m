%% Description
% When file is run, it will load random image and find an image closest to
% the loaded image

%% Load random image and display it
loadedImage = load_database();
randomIndex = round(400*rand(1,1));          
randomImage = loadedImage(:,randomIndex);
imshow(reshape(randomImage,112,92));

%% Get variables for analysis

% Store all images minus chosen image into an array
remainingImages = loadedImage(:,[1:randomIndex - 1 randomIndex + 1:end]);

% Blank image for resetting tracking images
blankImage = uint8(ones(1,size(remainingImages,2)));

% Find mean of remaining images and remove them from chosen image
meanValue = uint8(mean(remainingImages,2));                
meanRemovedImage = remainingImages - uint8(single(meanValue)*single(blankImage));

% Finding the eigenvector of image
A = single(meanRemovedImage)'*single(meanRemovedImage);
[V,D] = eig(A);
V = single(meanRemovedImage)*V;

% Create structures for each individual image
imageSignature = 20; % Play around with this   
V=V(:,end:-1:end-(imageSignature-1));          
allImageSignatures=zeros(size(remainingImages,2),imageSignature);

% Multiply eigenvectors and store with the image signatures
for i=1:size(remainingImages,2)
    allImageSignatures(i,:) = single(meanRemovedImage(:,i))'*V;  
end

%% Find closest possible face

% Show random image onto a popup plot
subplot(121);
imshow(reshape(randomImage,112,92));
title('Looking for this Face','FontWeight','bold','Fontsize',16,'color','red');

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
subplot(122);
imshow(reshape(remainingImages(:,i),112,92));
title('Recognition Completed','FontWeight','bold','Fontsize',16,'color','red');