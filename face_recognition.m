%% Description
% When file is run, it will load random image and find an image closest to
% the loaded image

%% Load random image and show

loadedImage = load_database();
randomIndex = round(400*rand(1,1));          
randomImage = loadedImage(:,randomIndex);
imshow(reshape(randomImage,112,92));

%% Store remaining images in array for analysis
