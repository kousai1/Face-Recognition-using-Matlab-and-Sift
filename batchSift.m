function [ output ] = batchSift()
%Function is used to generate the SIFT features of all the training images
%   and save them in a database.
 
   output = cell(200,1);     %pre-allocating memory for output
    person=1;
    n=1;
for count=1:1:170              %change 170 to the number of training images you have
    
                                %This part is used to assign a person
    if(count > (10*n))          % number to the training images.
        person = person + 1;    %  Since there are 10 training images per
        n = n + 1;              %   person, the same number is assign for each 10 images.
    end
       
    name = sprintf('Training/train_%03d.pgm',count); %'Prints' the location of the training image.
      
    img = ObjectDetection(name,'HaarCascades/haarcascade_frontalface_alt.mat'); %run the object detect on the training image.
                                
    imgloc = sprintf('croptrain/ctrain_%03d.pgm',count); %saves the cropped training face image.
    imwrite(img,imgloc,'pgm');                           %
    
    [image, descrips, locs] = sift(imgloc);             %Extract the SIFT features
   %Save the feature + person number in a structure.
    output{count} = struct('image', image, 'descriptors',descrips ,'locs',locs, 'person', person);
    
    
    filename = sprintf('Training1/data1.mat'); %save the structure in a database
    save (filename, 'output');                %
    disp(count) %displays image number for user end.
end