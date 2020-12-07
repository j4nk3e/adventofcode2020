g='shiny gold'n,x,r=0,-1,{[g]=1}u='(%a+ %a+) bags?%p?%s?'v=' contain (.-)%.'w,z,i=u..v,'(%d) '..u,io.read'*a'while x<n do
x=n for d,a in i:gmatch(w)do for o,a in a:gmatch(z)do t=r[a]and not r[d]r[d]=t and o or r[d]n=n+(t and 1 or 0)end end end
function s(n)m=1 for n,d in i:gmatch(n..' bags'..v)():gmatch(z)do m=m+n*s(d)end return m end print(n,s(g)-1)