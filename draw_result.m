%% ���ڻ�����ͬ���ֵļ����
function draw_result(src_img, sig_score_img, region_size, scale)

ma=max(max(sig_score_img));
mi=min(min(sig_score_img));

norm_sig_score_img = (sig_score_img - mi)./(ma-mi);%��һ���÷�
norm_sig_score_img = norm_sig_score_img.*255;
norm_sig_score_img=imresize(norm_sig_score_img,scale);
figure,imshow(uint8(norm_sig_score_img));%�������Ե÷ֽ��ͼ

%�������÷�λ�ÿ��Ŀ��
[x y]=find(sig_score_img==ma);%���÷�λ��
rect_img = zeros(size(sig_score_img,1), size(sig_score_img,2));
rect_img(x-floor(region_size(1)/2):x+floor(region_size(1)/2),y-floor(region_size(2)/2):y+floor(region_size(2)/2))=128;
rect_img=imresize(rect_img,scale);%�Ŵ��ԭͼ���С
rect_size=[size(src_img, 1), size(src_img, 2)];
src_img(:,:,1) = src_img(:,:,1) + uint8(rect_img(1:rect_size(1),1:rect_size(2)));
figure,imshow(src_img);
