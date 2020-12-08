    i,r=1,{}for n in io.lines()do
    c,d=n:gmatch'(.).. (%S+)'()r[i]={c,d}i=i+1
    end function z(e)a,p,h,m=0,1,{},{n=function()p=p+1
    end,j=function(n)p=p+n end,a=function(n)a=a+n p=p+1
    end}while''do if h[p]then return a end h[p]=''if
    p>#r then y=a return end c,d=r[p][1],r[p][2]c=p==e
    and(c=='j'and'n'or c=='n'and'j')or c m[c](d)end
    end i=0 repeat s=z(i)x=x or s i=i+1
    until(not s)print(x,y)