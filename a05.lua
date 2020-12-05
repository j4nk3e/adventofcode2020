m,a=0,{}for l in io.lines()do
n=tonumber(l:gsub('[FL]','0'):gsub('[BR]','1'),2)a[n]=1
m=n>m and n or m end print(m) for i,n in pairs(a)do if
m==i-2 then print(m+1)end m=i end
