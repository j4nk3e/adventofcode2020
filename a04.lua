function o(n,d)return function(r)return r-n>0 and r-n<d end end
c={eyr=o(2019,12),byr=o(1919,84),iyr=o(2009,12),hgt=function(n)e,g=n:gmatch'(%d+)(%a+)'()return
g=='cm'and o(149,45)(e)or g=='in'and o(58,19)(e)end,hcl=function(n)return
n:find'#[%da-f]+'and#n==7 end,pid=function(n)return#n==9 and
n:find'%d+'end,ecl=function(n)return({amb=1,blu=1,brn=1,gry=1,grn=1,hzl=1,oth=1})[n]end}x=io.read'*a'function
w(d)for n,e in pairs(c)do r=d:gmatch(n..':(%S+)')()if not(r and e(r))then return 0 end
end end for n in(x..'\n\n'):gmatch'(.-)\n\n'do d=(d or 0)+(w(n)or 1)end print(d)