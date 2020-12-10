a,b,n,q,m=1,1,1,25,{}for e in io.lines()do m[n]=e+0 if n>q
then for e=n-q,n do for t=n-q,n do if m[e]+m[t]==m[n]then
goto e end end end g=m[n]end::e::n=n+1 end t=m[1]for n in
pairs(m)do repeat if t<g then b=b+1 t=t+m[b]elseif t>g then
t=t-m[a]a=a+1 end until t==g end for n=a,b do y=math.min(y
or m[n],m[n])x=math.max(x or m[n],m[n])end print(g,y+x)