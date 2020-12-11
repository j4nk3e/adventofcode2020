n,e,f=table.insert,{},{}for d in io.lines()do r={}for
e in d:gmatch('.')do n(r,e)end n(e,r)n(f,r)end function
h(r,o)q=0 for n=-1,1 do for t=-1,1 do if n~=0 or t~=0
then c,d=o+n,r+t while i and e[c]and e[c][d]=='.'do
c,d=c+n,d+t end if e[c]and e[c][d]=='#'then q=q+1 end
end end end return q end k=4 repeat t,v,j=nil,0,{}for
d=1,#e do j[d]={}for o=1,#e[d]do n=h(o,d)if e[d][o]=='L'and
n==0 then j[d][o]='#'t=1 elseif e[d][o]=='#'and n>=k then
j[d][o]='L't=1 else j[d][o]=e[d][o]end v=v+(j[d][o]=='#'and
1 or 0)end end e=j if not t and not i then
k,i,e,t,z=5,1,f,1,v end until not t print(z,v)