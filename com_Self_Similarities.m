%% ���ڼ���ͼƬ����������������
function self_similarities = com_Self_Similarities(src_image,region_size,patch_size, bin)
t1=clock;%��ʱ

%%
%��ȡͼ��ת����lab�ռ�
figure;imshow(src_image);
cform = makecform('srgb2lab'); % rgbת��lab
lab_image = applycform(src_image,cform);
% figure;imshow(lab_image);

%%
%����ÿ�����ص����������������
lab_size = size(lab_image);
vec_size = 45;%45��bin
alpha = 1/(85^2);%�����������õĲ���alpha
self_similarities = zeros(lab_size(1), lab_size(2), vec_size);
center_region = [floor(region_size(1)/2), floor(region_size(2)/2)];
center_patch = [floor(patch_size(1)/2), floor(patch_size(2)/2)];
for row=center_region(1)+1:1:lab_size(1)-center_region(1)
    for col=center_region(2)+1:1:lab_size(2)-center_region(2)
        patch = lab_image(row-center_patch(1):row + center_patch(1), col-center_patch(1):col + center_patch(1), :);%ȡpatch
        region = lab_image(row-center_region(1):row + center_region(1), col-center_region(2):col + center_region(2), :);%ȡregion
        SSD_region = cal_ssd(patch, region, alpha, center_patch);%����������
        vec = get_self_sim_vec(SSD_region, bin, vec_size);%������ת��Ϊ��������������
        [LSSD,ps]=mapminmax(vec' ,0,1);%�������ӹ�һ��
        self_similarities(row, col, :) = LSSD';
    end
end
t2=clock;
etime(t2,t1);