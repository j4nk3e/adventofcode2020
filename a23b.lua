L={}function C(n)L[n]={v=n}return L[n]end function
x(n,d)return n.v==d and n or n.n and x(n.n,d)end
for d in io.read'*a':gmatch'%d'do z=C(d+0)if n
then n.n=z else E=z end n=z end for d=#L+1,1e6 do
d=C(d)n.n=d n=d end t=#L n.n=E for n=1,1e7 do d=E.n
o=d.n.n E.n=o.n o.n=N n=E.v>1 and E.v-1 or t while
x(d,n)do n=n>1 and n-1 or t end n=L[n]o.n,n.n=n.n,d
E=E.n end print(L[1].n.v*L[1].n.n.v)