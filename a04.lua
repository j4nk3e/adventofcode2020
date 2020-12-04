function o(a, b) return function(s)
return (s-a>0)and s-a<b end end c={
hgt=function(s) e,g=s:gmatch('(%d+'
..')(%a+)')() return g=='cm' and o(
149,45)(e) or g=='in' and o(58,19)(
e) end, eyr=o(2019,12), byr=o(1919,
84), hcl=function(s) return s:find(
'#[%da-f]+') and #s == 7 end,iyr=o(
2009,12), pid=function(s) return #s
==9 and s:find'%d+'end,ecl=function
(s) return({amb=1,blu=1,brn=1,gry=1
, grn=1, hzl=1, oth=1}) [s] end} q,
d=0, 0 x=io.read('*a') function w()
for h, p in pairs(c) do r=a:gmatch(
h..':(%S+)')() if not r or not p(r)
then return (0) end end end while q
do f,t=x:find('\n\n',q)q,a=t,x:sub(
q,f and t)d=d+(w()or 1)end print(d)