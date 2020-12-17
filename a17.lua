require 'pl'
f, counts = {}, {}
local minx, maxx = 0, 0
local miny, maxy = 0, 0
local minz, maxz = 0, 0
function setmz(tab)
    local mt = {
        __newindex = function(t, k, v)
            rawset(t, k, v)
            if v then
                minz = math.min(k, minz)
                maxz = math.max(k, maxz)
            end
        end,
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
        __newindex = function(t, k, v)
            rawset(t, k, v)
            if v then
                miny = math.min(k, miny)
                maxy = math.max(k, maxy)
            end
        end,
        __index = function(t, k)
            t[k] = {}
            setmx(t[k])
            return t[k]
        end
    }
    setmetatable(tab, mt)
end
function setmx(tab)
    local mt = {
        __newindex = function(t, k, v)
            rawset(t, k, v)
            if v and v > 0 then
                minx = math.min(k, minx)
                maxx = math.max(k, maxx)
            end
        end
    }
    setmetatable(tab, mt)
end
setmz(f)
setmz(counts)

z, y = 0, 0
function surrounding(z, y, x)
    count = 0
    for a = -1, 1, 1 do
        for b = -1, 1, 1 do
            for c = -1, 1, 1 do
                if not (a == 0 and b == 0 and c == 0) then
                    count = count + (f[z + a][y + b][x + c] or 0)
                end
            end
        end
    end
    return count
end
for l in io.lines() do
    x = 0
    for c in l:gmatch '.' do
        f[z][y][x] = c == '#' and 1 or nil
        x = x + 1
    end
    y = y + 1
end
function step()
    for z = minz - 1, maxz + 1 do
        for y = miny - 1, maxy + 1 do
            for x = minx - 1, maxx + 1 do
                counts[z][y][x] = surrounding(z, y, x)
            end
        end
    end
    all = 0
    for z = minz - 1, maxz + 1 do
        for y = miny - 1, maxy + 1 do
            for x = minx - 1, maxx + 1 do
                g = counts[z][y][x]
                h = f[z][y][x]
                if h then
                    f[z][y][x] = (g > 1 and g < 4) and 1 or nil
                else
                    f[z][y][x] = (g == 3) and 1 or nil
                end
                if f[z][y][x] then all = all + 1 end
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
