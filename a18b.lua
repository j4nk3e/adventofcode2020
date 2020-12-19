function e(n)return not n:find'%p'and n or n:find'%('and
e(n:gsub('%b()',function(n)return e(n:sub(2,-2))end))or
n:find('%+')and e(n:gsub('(%d+) %+ (%d+)',function(d,n)return
d+n end))or e(n:gsub('(%d+) %* (%d+)',function(n,d)return n*d
end))end s=0 for n in io.lines()do s=s+e(n)end print(s)