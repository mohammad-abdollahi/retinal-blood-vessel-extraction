clc;
close all;
clear;

images_path = 'Documents/computer_vision/HW_4/DRIVE/images/';
masks_path = 'Documents/computer_vision/HW_4/DRIVE/mask/';
answers_path = 'Documents/computer_vision/HW_4/DRIVE/1st_manual/';
d = dir(images_path);
total_acc = 0;
total_sen = 0;
total_spec = 0;
imgs = [];
for i=1:numel(d)
    if d(i).isdir == 0
        img = imread([images_path d(i).name]);
        mask = imread([masks_path d(i).name(1:2) '_test_mask.gif']);
        answer = imread([answers_path d(i).name(1:2) '_manual1.gif']);
        
        mask = im2double(mask);
        img_gray = rgb2gray(img);
        img = im2double(img_gray);
        
        
        
        s = imfilter(img, fspecial('average', [12,12]));
        k = 0.4;
        T = k*s;
        im = double(img<s);
        j = img.*im;
        %imshow(j);
        %pause();
        
        se = strel('diamond',20);
        erodedmask = imerode(mask,se);
        
        Threshold = 5;
        bloodVessels = VesselExtract(img_gray, Threshold);
        j = bloodVessels.*im;
        se = strel('disk', 1);
        j = imclose(j, se);
        j = medfilt2(j, [3,3]);
        
        imshow(j.*erodedmask)
        %pause();
        res = j.*erodedmask;
        imwrite(res, ['Documents/computer_vision/HW_4/DRIVE/results/' d(i).name(1:2) '_result.tif'])
        
        answer = answer > 0;
        res = res > 0;
        
        disp(['image ' d(i).name ' : sensevity specification accuracy']);
        [sen, spec, acc] = Scores(res, answer)
        total_acc = total_acc + acc;
        total_sen = total_sen + sen;
        total_spec = total_spec + spec;
    end
end
total_acc = total_acc/40
total_sen = total_sen/40
total_spec = total_spec/40

