
[gh, n, m, val, sv] = textread('igrf2015.txt','%s %f %f %f %f');
N=max(n);
g=zeros(N,N+1);
h=zeros(N,N+1);
hsv=zeros(N,N+1);
gsv=zeros(N,N+1);
for x=1:length(gh)
    if strcmp(gh(x),'g')
        g(n(x),m(x)+1) = val(x);
        gsv(n(x),m(x)+1) = sv(x);
    else
        h(n(x),m(x)+1) = val(x);
        hsv(n(x),m(x)+1) = sv(x);
    end
end
count=1;
S = zeros(N,N+1);
for n=1:N
    for m=0:n
        if m>1
            S(n,m+1) = S(n,m)*((n-m+1)/(n+m))^0.5;
        elseif m>0
            S(n,m+1) = S(n,m)*(2*(n-m+1)/(n+m))^0.5;
        elseif n==1
            S(n,1) = 1;
        else
            S(n,1) = S(n-1,1)*(2*n-1)/(n);
        end
        gS(count,1) = n; gS(count,2)=m;
        gS(count,3)=g(n,m+1)*S(n,m+1); gS(count,4)=gsv(n,m+1)*S(n,m+1);
        hS(count,1) = n; hS(count,2)=m;
        hS(count,3)=h(n,m+1)*S(n,m+1); hS(count,4)=hsv(n,m+1)*S(n,m+1);
        count=count+1;
    end
end

%Split into g and h coefficients with format of m 2015 SV in order of n
%value
dlmwrite('igrfSg2015.txt',gS,'\t')
dlmwrite('igrfSh2015.txt',hS,'\t')
