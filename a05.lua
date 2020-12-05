a={}for l in io.lines()do
n=tonumber(l:gsub('[FL]','0'):gsub('%D','1'),2)a[n]=1 end
for i in pairs(a)do m,x=i,m==i-2 and m+1 or x end print(m,x)