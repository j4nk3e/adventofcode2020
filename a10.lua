a,b,v,m=0,1,0,{[0]=0}for n in
io.lines()do m[n+0]=0 end for
n in pairs(m)do v=n if m[n+1]then
a=1+a elseif m[n+3]then b=1+b end
end function r(n)q=m[n]if n==v
then return 1 elseif q>0 then
return q end for e=n+1,n+3 do
m[n]=m[n]+(m[e]and r(e)or 0)end
return m[n]end print(a*b,r(0))