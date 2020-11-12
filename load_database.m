function output_image = load_database()
%% Description
% Loads the dataset in preparation for face recognition

%% Variables
persistent loadedImage; % persistent type is local to function but retain memory when used in another file
persistent numImage;

%% Dataset Loading Function
if(isempty(loadedImage)) 
    allImages = zeros(92*112,... % Pixels of each image
        40); % Number of folders representing a single person
    cd(strcat('training_set')); 
    for i=1:40 
        cd(strcat('s',num2str(i))); 
        for j=1:10 
            imageContainer = imread(strcat(num2str(j),'.pgm')); 
            allImages(:,(i-1)*10+j)... % get all images from each folder
                = reshape(imageContainer,size(imageContainer,1)... 
                *size(imageContainer,2),1); % reshape images into arrays for analysis
        end
        disp('Loading Database');
        cd .. % changes folder directory back to load other faces
    end
    numImage = uint8(allImages); % changes all the images within the database to 8-bit images
end
loadedImage = ""; % Needs to return to empty next time image needs to be loaded
output_image = numImage;