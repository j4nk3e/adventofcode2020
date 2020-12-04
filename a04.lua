function inrange(s, a, b)
    local i = tonumber(s)
    return i >= a and i <= b
end
req = {
    byr = function(s) return inrange(s, 1920, 2002) end,
    iyr = function(s) return inrange(s, 2010, 2020) end,
    eyr = function(s) return inrange(s, 2020, 2030) end,
    hgt = function(s)
        for cm in s:gmatch('(%d+)cm') do return inrange(cm, 150, 193) end
        for ip in s:gmatch('(%d+)in') do return inrange(ip, 59, 76) end
        return false
    end,
    hcl = function(s) return s:find('#[%da-f]+') and #s == 7 end,
    ecl = function(s)
        return
            ({amb = 1, blu = 1, brn = 1, gry = 1, grn = 1, hzl = 1, oth = 1})[s]
    end,
    pid = function(s) return #s == 9 and s:find '%d+' end
}
q, fail, n = 0, 0, 0
x = io.read '*a'
while q do
    from, to = x:find('\n\n', q)
    if from then
        pass = x:sub(q, to)
    else
        pass = x:sub(q)
    end
    q = to
    r = {}
    n = n + 1
    for l, v in pass:gmatch('(%a+):(%S+)') do r[l] = v end
    for id, p in pairs(req) do
        if r[id] and p(r[id]) then
            print('ok', id, r[id])
        else
            print('false', id, r[id])
            print ''
            fail = fail + 1
            break
        end
    end
end
print('total:', n, 'failed:', fail, 'valid:', n - fail)
