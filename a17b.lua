require 'pl'
f = {}

function setmq(tab)
    local mt = {
        __index = function(t, k)
            t[k] = {}
            setmz(t[k])
            return t[k]
        end
    }
    setmetatable(tab, mt)
end
function setmz(tab)
    local mt = {
        __index = function(t, k)
            t[k] = {}
            setmy(t[k])
            return t[k]
        end
    }
    setmetatable(tab, mt)
end
function setmy(tab)
    local mt = {
        __index = function(t, k)
            t[k] = {}
            return t[k]
        end
    }
    setmetatable(tab, mt)
end

function surrounding(a, b, c, d)
    local count = 0
    for _, u in pairs(f) do
        local q, z, y, x = unpack(u)
        if (q - 2 < a and a < q + 2 and z - 2 < b and b < z + 2 and y - 2 < c and
            c < y + 2 and x - 2 < d and d < x + 2 and
            not (q == a and z == b and y == c and x == d)) then
            count = count + 1
        end
    end
    return count
end

y = 0
for l in io.lines() do
    x = 0
    for c in l:gmatch '.' do
        if c == '#' then table.insert(f, {0, 0, y, x}) end
        x = x + 1
    end
    y = y + 1
end

function step()
    local counts = {}
    setmq(counts)
    for _, b in pairs(f) do
        mq, mz, my, mx = unpack(b)
        for q = mq - 1, mq + 1 do
            for z = mz - 1, mz + 1 do
                for y = my - 1, my + 1 do
                    for x = mx - 1, mx + 1 do
                        if not counts[q][z][y][x] then
                            counts[q][z][y][x] = surrounding(q, z, y, x)
                        end
                    end
                end
            end
        end
    end
    all = 0
    for q, qq in pairs(counts) do
        for z, zz in pairs(qq) do
            for y, yy in pairs(zz) do
                for x, xx in pairs(yy) do
                    local new = {q, z, y, x}
                    local j = nil
                    for i, h in pairs(f) do
                        if tablex.compare(h, new,
                                          function(a, b)
                            return a == b
                        end) then
                            j = i
                            break
                        end
                    end
                    if j then
                        if xx > 1 and xx < 4 then
                            all = all + 1
                        else
                            f[j] = nil
                        end
                    elseif xx == 3 then
                        table.insert(f, new)
                        all = all + 1
                    end
                end
            end
        end
    end
    print(all)
end
step()
step()
step()
step()
step()
step()
