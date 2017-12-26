function [MetaA,MetaB] = MetaEquilibrium(A,B)
%¼ÆËãÔª¾ùºâ
switch ceil(2*rand(1))
    case 1
        i = 1;j = 2;
    case 2
        i = 2;j = 1;
end

if i == 1
    MetaA = max(min(A,[],j));
else
    MetaA = min(max(A,[],j));
end

if i == 2
    MetaB = max(min(B,[],j));
else
    MetaB = min(max(B,[],j));
end

end