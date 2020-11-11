function output_image = load_database()
%% Description
% Loads the dataset in preparation for face recognition

%% Variables
persistent loaded; % persistent data type is used for 
persistent numeric_Image;

%% Dataset Loading Function
if(isempty(loaded))
    all_Images = zeros(10304,40);
    cd(strcat('training_set'));
    for i=1:40
        cd(strcat('s',num2str(i)));
        for j=1:10
            image_Container = imread(strcat(num2str(j),'.pgm'));
            all_Images(:,(i-1)*10+j)=reshape(image_Container,size(image_Container,1)*size(image_Container,2),1);
        end
        disp('Loading Database');
        cd ..
    end
    numeric_Image = uint8(all_Images);
end
loaded = 1;
output_image = numeric_Image;