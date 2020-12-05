q,n=2020,{}for l in io.lines()do n[l+0]=1 end
for x in pairs(n)do for y in pairs(n)do
a=x+y==q and x*y or a for z in pairs(n)do
b=x+y+z==q and x*y*z or b end end end
print(a,b)