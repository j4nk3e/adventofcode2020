mem = {}
for l in io.lines() do
    local mask = l:gmatch('mask = (%S+)')()
    local addr, val = l:gmatch('mem%[(%d+)%] = (%d+)')()
    if mask then
        mask1 = tonumber(mask:gsub('X', '0'), 2)
        mask0 =
            tonumber(mask:gsub('[1X]', 'a'):gsub('0', '1'):gsub('a', '0'), 2)
        print(mask:gsub('X', '0'), mask1)
        print(mask:gsub('[1X]', 'a'):gsub('0', '1'):gsub('a', '0'), mask0)
    else
        mem[tonumber(addr)] = ~(~tonumber(val) | mask0) | mask1
    end
end
s = 0
for _, m in pairs(mem) do s = s + m end
print(s, b)
