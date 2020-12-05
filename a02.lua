v,w=0,0 for a,b,c,d in
io.read'*a':gmatch'(%d+)-(%d+) (%l): (%l+)'do
n=0 for o in d:gmatch(c..'+')do n=n+#o end
v,w=n>=a+0 and n<=b+0 and v+1 or
v,(d:sub(a,a)==c)~=(d:sub(b,b)==c)and
w+1 or w end print(v,w)