s,x,d=0,0,'\n\n'for n
in(io.read'*a'..d):gmatch('(.-)'..d)do
f,a,b=0,{},{}for d in
n:gmatch'[^\n]+'do
for n in d:gmatch'%l'do
a[n],s=1,s+(a[n]and
0 or 1)if f then
b[n],x=1,x+(b[n]and
0 or 1)end end
for n in pairs(b)do
b[n]=d:find(n)x=b[n]and
x or x-1 end f=nil end
end print(s,x)