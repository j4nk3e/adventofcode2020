mem = {}
for l in io.lines() do
    local mask = l:gmatch('mask = (%S+)')()
    local addr, val = l:gmatch('mem%[(%d+)%] = (%d+)')()
    if mask then
        f = {}
        for i in mask:gmatch('()X') do table.insert(f, i) end
        m = tonumber(mask:gsub('X', '0'), 2)
    else
        for i = 0, 1 << #f do
            f0, f1 = 0, 0
            for n, b in ipairs(f) do
                v = 1 << (n - 1)
                if v & i == 0 then
                    f0 = f0 | 1 << (36 - b)
                else
                    f1 = f1 | 1 << (36 - b)
                end
            end
            mem[(addr | m | f1) & ~f0] = val
        end
    end
end
s = 0
for _, m in pairs(mem) do s = s + m end
print(string.format('%i', s))