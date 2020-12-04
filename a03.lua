k,x=1,{}for b in io.read'*a':gmatch'%p+'do
w,j,v=#b,0,{}x[k]=v k=k+1 while j do j=b:find('#',j+1)v[j
or 0]=1 end end function u(v,s)t=0 for y=1,#x/s-1
do t=x[y*s+1][(y*v)%w+1] and t+1 or t end return t
end print(u(1,1)*u(3,1)*u(5,1)*u(7,1)*u(1,2))