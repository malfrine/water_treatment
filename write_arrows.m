%% init
load minlp_main.mat

%splitter 1 to mixer 1 -'\draw[->] (splitter1_pw) -- (mixer1_igf);'
[I, J] = find(B_s_tu.val == 1);
tail = uels(I);
tip = uels(J);

strM1 = cell(length(I),1);
for i = 1:length(I)
    strM1{i} = ['\\draw[->] (splitter1_', tail(i) ,') -- ( mixer1_', tip(i), ');\n'];
end

%mixer 1 to treatment unit -'\draw[->] (mixer1_st) -- (st);'
%treatment unit to splitter 2 -'\draw[->] (st) -- (splitter2_st);'
[I, J] = find(B_tu.val == 1);
tail = uels(I);
tip = uels(I);

strM2 = cell(length(I),1);
strM3 = cell(length(I),1);
for i = 1:length(I)
    strM2{i} = ['\\draw[->] (mixer1_', tail(i) ,') -- (', tip(i), ');\n'];
    strM3{i} = ['\\draw[->] (', tail(i) ,') -- ( splitter2_', tip(i), ');\n'];
end

%splitter 2 to mixer 2 -'\draw[->] (splitter2_st) -- (mixer2_igf);'
%mixer 2 back to mixer 1 - '\draw[->] (mixer2_st) -- (mixer1_igf);'
[I, J] = find(B_tu_tup.val == 1);
tail = uels(I);
tip = uels(J);

strM4 = cell(length(I),1);
strM5 = cell(length(I),1);
for i = 1:length(I)
    strM4{i} = ['\\draw[->] (splitter2_', tail(i) ,') -- ( mixer2_', tip(i), ');\n'];
    strM5{i} = ['\\draw[->] (mixer2_', tip(i) ,') -- ( mixer1_', tip(i), ');\n'];
end

%splitter 2 to mixer 3 - '\draw[->] (splitter2_st) -- (mixer3_sgu);'

[I, J] = find(B_exit.val == 1);
tip = uels(I);
tail = uels(J);

strM6 = cell(length(I),1);

for i = 1:length(I)
    strM6{i} = ['\\draw[->] (splitter2_',tip(i),') -- (mixer3_',tail(i),'); \n'];
end

%mixer 3 to sgu - '\draw[->] (mixer3_sgu) -- (sgu);'
[I, J] = find(B_in_sgu.val == 1);
tail = uels(I);

strM7 = cell(length(I),1);

for i = 1:length(I)
   strM7{i} = ['\\draw[->] (mixer3_',tail(i),') -- (',tail(i),'); \n'];
end


%sgu to mixer4 - '\draw[->] (sgu) -- (mixer4_pro);'
[I, J] = find(B_exit_sgu.val == 1);
tip = uels(I);
tail = uels(J);

strM8 = cell(length(I),1);

for i = 1:length(I)
   strM8{i} = ['\\draw[->] (',tip(i),') -- (mixer4_',tail(i),'); \n']; 
end

%mixer4 to pro - '\draw[->] (mixer4_pro) -- (pro);'
[I, J] = find(B_pro.val == 1);
tip = uels(I);
tail = uels(J);

strM9 = cell(length(I),1);

for i = 1:length(I)
   strM9{i} = ['\\draw[->] (mixer4_',tip(i),') -- (',tip(i),'); \n']; 
end

if B_rec_otsg_bbd.val == 1
   strM10 = '\\draw[->] (otsg) -- (otsgr1) \n';
else
   strM10 = '';
end

%mixer4 to pro - '\draw[->] (mixer4_pro) -- (pro);'

str_array = {strM1; strM2; strM3; strM4; strM5; strM6; strM7; strM8; ...
    strM9; strM10};

% export to .tex file.
fid = fopen('arrows.tex','w');
for i = 1:length(str_array)
    for j = 1:length(str_array{i})
        try
            str1 = strjoin(str_array{i}{j});
            str1 = strrep(char(['\',sprintf(str1)]),' ','');
            %str2 = strrep(char(str2),';',';\n');
            fprintf(fid,str1);
        catch
            
        end
        
    end
end
st = fclose(fid);

fprintf('arrows.tex has been created.\n')
