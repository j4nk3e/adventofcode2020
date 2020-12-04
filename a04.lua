function o(s,a,b)return s-a>0 and s-a<b end c={byr=function(s)return
o(s,1919,84)end,iyr=function(s)return o(s,2009,12)end,eyr=function(s)return
o(s,2019,12)end,hgt=function(s)e=s:gmatch'(%d+)cm'()g=s:gmatch'(%d+)in'()return
e and o(e,149,45)or g and o(g,58,19)end,hcl=function(s)return
s:find'#[%da-f]+'and#s==7 end,pid=function(s)return#s==9 and
s:find'%d+'end,ecl=function(s)return({amb=1,blu=1,brn=1,gry=1,grn=1,hzl=1,oth=1})[s]end
}q,d,x=0,0,io.read'*a'function w()for id,p in pairs(c)do r=a:gmatch(id..':(%S+)')()if
not r or not p(r)then return 0 end end end while q do f,t=x:find('\n\n',q)a,q=x:sub(q,f
and t),t d=d+(w()or 1)end print(d)