k,x=1,{}for l in io.read'*a':gmatch'%p+'do
w,i,r=#l,0,{}x[k]=r k=k+1 while i do
i=l:find('#',i+1)r[i or 0]=1 end end function
u(r,d)i,t=0,0 for c=1+d,#x,d do i=(i+r)%w
t=x[c][i+1] and t+1 or t end return t end
print(u(1,1)*u(3,1)*u(5,1)*u(7,1)*u(1,2))