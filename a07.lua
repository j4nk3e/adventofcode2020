g='shiny gold'n,r=0,{}function s(n)m=1 for n,d in l[n]:gmatch(z)do
m=m+n*s(d)end return m end u='(.-) bags?'function y(i)for d,o in
pairs(l)do for e,o in o:gmatch(z)do if o==i and not r[d]then r[d],n=1,n+1
y(d)end end end end v=' contain (.-)%.'w,z,l=u..v,'(%d) '..u,{}for
n in io.lines()do u,c=n:gmatch(w)()l[u]=c end y(g)print(n,s(g)-1)