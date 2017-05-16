function miffile(filename,svnum)

%% mif C/A Code Generate
% Copyright (c) 2017-3-9 Mohismist 张伟成
%   All rights reserved.
%   Email: mohismist@yahoo.com
%
% Reference:
%
% Introductions:
%   说明：产生.mif格式的C/A码
%   @param filename: output file: filename.mif
%   @param svnum: satellite PRN number
%
%% ***** G2 Code Phase Shift *****
    if(nargin~=2)
        error('Please check the input parameters.');
    end
    gs2=[5;6;7;8;17;18;139;140;141;251;252;254;255;256;257;258;
        469;470;471; 472;473;474;509;512;513;514;515;516;859;860;861;862];

    g2shift=gs2(svnum);
    g1 = zeros(1023,1);
    g2 = zeros(1023,1);
%% ***** Generate G1 code *****
    reg = -1*ones(10,1);
    for k=1:1023
        g1(k) = reg(10);
        reg = [reg(3)*reg(10);reg(1:9)];
    end
%% ***** Generate G2 code *****
    reg = -1*ones(10,1);
    for k = 1:1023
        g2(k) = reg(10);
        reg = [reg(2)*reg(3)*reg(6)*reg(8)*reg(9)*reg(10);reg(1:9)];
    end
%% ***** Shift G2 code *****
    g2 = [g2(1023-g2shift+1:1023); g2(1:1023-g2shift)];
%% ***** Form single sample C/A code *****
    ss_ca = g1.*g2;
    data_ca = -ss_ca;
    data_ca( data_ca<0 )=0;
    data_ca = num2str([data_ca; 0])';

%% ***** Generate .mif File *****
    fid=fopen(strcat(filename,'.mif'),'w');
    fprintf(fid,'WIDTH=1;\n'); %指定每个数值的字宽
    fprintf(fid,'DEPTH=1024;\n'); %指定数值的个数，即ROM的深度
    fprintf(fid,'ADDRESS_RADIX=UNS;\n'); %指定地址的数制（UNS：无符号数）
    fprintf(fid,'DATA_RADIX=HEX;\n'); %指定数据基数
    fprintf(fid,'CONTENT BEGIN\n'); %固定格式
    for k=1:1024 %数据段数据
        fprintf(fid,'%3d',k-1);
        fprintf(fid,' : ');
        fprintf(fid,'%s',data_ca(k));
        fprintf(fid,';\n');
    end
    fprintf(fid,'END;\n'); %固定格式
    fclose(fid);
end