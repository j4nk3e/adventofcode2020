d={}e={}i={}o={}for e,n in io.read'*a':gmatch'([^\n]+) %(%l+ ([^%)]+)'do
d[e]=n end require'pl'for d,n in pairs(d)do z={}for e in d:gmatch'%l+'do
z[#z+1]=e o[e]=(o[e]or 0)+1 i[e]=1 end for n in n:gmatch'%l+'do e[n]=e[n]and
e[n]*Set(z)or Set(z)end end while not u do u=''for r,n in pairs(e)do if
Set.len(n)==1 then for o,d in pairs(e)do if o~=r then e[o]=d-n end end
else u=j end for e in pairs(n)do i[e]=nil end end end x=0 for e in
pairs(i)do x=x+o[e]end k=tablex.keys(e)table.sort(k)for _,o in
pairs(k)do n=n and n..','or''n=n..Set.values(e[o])[1]end print(x,n)