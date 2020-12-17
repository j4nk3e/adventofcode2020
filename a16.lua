r={}d='departure'e='%d+'function z(n,e)for r,n in
pairs(n.j)do if n[1]<=e and n[2]>=e then return 1
end end end function y(n)for _,e in pairs(r)do if
z(e,n)then return 1 end end end function
x(n)w,t=1,{}v[#v+1]=t for n in n:gmatch(e)do
t[w]=n+0 w=w+1 end end i=0 for n in io.lines()do
g,j=n:gmatch'(%P+): ([^\n]+)'()if j then for e,n
in(j..' or'):gmatch'(%d+)-(%d+) or'do
if not r[g]then r[g]={j={}}end
table.insert(r[g].j,{e+0,n+0})end i=i+1 elseif
n:find'^y'then v={}elseif n:find'^n'then p=0
elseif p then ok=1 for n in n:gmatch(e)do if not
y(n+0)then p=p+n ok=h end end if ok then x(n)end
elseif v and n:find(e)then x(n)end end for _,n
in pairs(r)do n.z={}for e=1,i do n.z[e]=1 end end
function o(n)c,l=0,0 for e,n in pairs(n)do if n
then c=c+1 l=e end end return c,l end function
b()for e,n in pairs(r)do if e:find(d)and not n.i
then return 1 end end end while b()do b()for e,n
in pairs(r)do for r,e in pairs(v)do for r=1,#e do
if not z(n,e[r])then n.z[r]=h end end end
c,l=o(n.z)if c==1 then n.i=l for _,n in pairs(r)do
n.z[l]=h end end end end n=1 for r,e in pairs(r)do
if r:find(d)then n=n*v[1][e.i]end end print(p,n)
