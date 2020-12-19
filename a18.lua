function e(n)return not n:find'%p'and n or n:find'%('and
e(n:gsub('%b()',function(n)return e(n:sub(2,-2))end))or
e(n:gsub('(%d+) (%p) (%d+)',function(e,d,n)return d=='*'and e*n or
e+n end,1))end s=0 for n in io.lines()do s=s+e(n)end print(s)