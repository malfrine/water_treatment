%% init
load minlp_main.mat

%% mass balance

err_count = 0;

%eqn4 - overall mass balance
left4 = sum(F_s.val) - F_BFW.val;
right4 = sum(F_loss.val);
eqn4 = isequal(left4, right4);

%eqn5 - mass balance around spliiter 1

[left5, right5, eqn5] = deal(zeros(length(set_s),1));

for s = s_start:s_end
    sx = s-s_start+1;
    left5(sx) = F_s.val(s);
    right5(sx) = sum(F_s_tu.val(s,tu_start:tu_end));
    eqn5(sx) = isequal(round(left5(sx)), round(right5(sx)));
end

[left6, right6, eqn6] = deal(zeros(length(set_tu),1));
[left7, right7, eqn7] = deal(zeros(length(set_tu),1));
[left9, right9, eqn9] = deal(zeros(length(set_tu),1));

[left10, right10, eqn10] = deal(zeros(length(set_tu),length(set_c)));
[left12, right12, eqn12] = deal(zeros(length(set_tu),length(set_c)));
[left13, right13, eqn13] = deal(zeros(length(set_tu),length(set_c)));

for tu = tu_start:tu_end
    tux = tu-tu_start+1;
    
    %eqn 6 - mass balance around mixer 1
    left6(tux) = sum(F_s_tu.val(s_start:s_end,tu)) +...
        sum(F_rec.val(tu_start:tu_end,tu));
    right6(tux) = F_in.val(tu);
    eqn6(tux) = isequal(round(left6(tux)), round(right6(tux)));
    
    %eqn 7 - mass balance around splitter 2
    left7(tux) = F_out.val(tu);
    right7(tux) = sum(F_rec.val(tu,tu_start:tu_end)) + F_exit.val(tu);
    eqn7(tux) = isequal(round(left7(tux)), round(right6(tux)));
    
    %eqn9 - mass balance around treatment units
    left9(tux) = F_in.val(tu) - F_out.val(tu);
    right9(tux) = F_loss.val(tu);
    eqn9(tux) = isequal(round(left9(tux)),round(right9(tux)));

    for c = c_start:c_end
        cx = c - c_start + 1;
        
        %eqn10 - component mass balance for tu
        left10(tux,cx) = (1 - RR.val(tu,c)) * ML_in.val(tu,c) - ...
            ML_out.val(tu,c) - F_loss.val(tu) * C_loss.val(tu,c);
        eqn10(tux,cx) = isequal(round(left10(tux,cx)), round(right10(tux,cx)));
        
        %eqn12 - component mass balance around mixer 1
        left12(tux,cx) = ...
            sum(F_rec.val(tu_start:tu_end,tu) .* C_out.val(tu_start:tu_end, c)) ...
            + sum(F_s_tu.val(s_start:s_end,tu) .* C_c_s.val(s_start:s_end, c))...
            - ML_in.val(tu,c) ;
        eqn12(tux,cx) = isequal(round(left12(tux,cx)), round(right12(tux,cx)));
        
        %eqn13 - component mass balance around splitter 
        left13(tux,cx) = C_out.val(tu,c) * ( ...
            sum(F_rec.val(tu, tu_start:tu_end)) + F_exit.val(tu)) ...
            - ML_out.val(tu,c);
        eqn13(tux,cx) = isequal(round(left13(tux,cx)), round(right13(tux,cx)));
    end   
end

%eqn8 - mass balance around mixer 3

left8 = sum(F_exit.val);
right8 = F_BFW.val;
eqn8 = isequal(round(left8), round(right8));



eqns = {eqn4, eqn5, eqn6, eqn7, eqn8, eqn9, eqn10, 1, eqn12, eqn13};

for i = 1:length(eqns)
    [sub_I,sub_J] = find(eqns{i} == 0);
    for j = 1:length(sub_I)
        fprintf('error in eqn%i, subscript (%i,%i).\n',...
            i+3, sub_I(j), sub_J(j));
        err_count = err_count + 1;
    end
end


fprintf('model check complete: there are %i errors.\n', err_count);

