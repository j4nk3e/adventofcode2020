local tiles = {}
local autogen = {
    __index = function(t, k)
        t[k] = {}
        return t[k]
    end
}
setmetatable(tiles, autogen)

local function adj(x, z)
    local c = 0
    c = c + (tiles[x + 1][z] and 1 or 0)
    c = c + (tiles[x - 1][z] and 1 or 0)
    c = c + (tiles[x][z + 1] and 1 or 0)
    c = c + (tiles[x][z - 1] and 1 or 0)
    c = c + (tiles[x + 1][z - 1] and 1 or 0)
    c = c + (tiles[x - 1][z + 1] and 1 or 0)
    return c
end

for line in io.lines() do
    local x, z = 0, 0
    for s in line:gsub('se', 'f'):gsub('sw', 'g'):gsub('nw', 'x')
                 :gsub('ne', 'y'):gmatch('.') do
        ({
            e = function() x = x + 1 end,
            w = function() x = x - 1 end,
            f = function() z = z + 1 end,
            x = function() z = z - 1 end,
            g = function()
                x = x - 1
                z = z + 1
            end,
            y = function()
                x = x + 1
                z = z - 1
            end
        })[s]()
    end
    tiles[x][z] = not tiles[x][z]
end

local function count()
    local a = 0
    for _, t in pairs(tiles) do
        for _, b in pairs(t) do if b then a = a + 1 end end
    end
    return a
end
local a = count()

for _ = 1, 100 do
    local counts = {}
    local min, max
    for x in pairs(tiles) do
        min = math.min(x, min or x)
        max = math.max(x, max or x)
        counts[x + 1] = {}
        counts[x - 1] = {}
        counts[x] = {}
    end
    tiles[min - 1] = {}
    tiles[max + 1] = {}
    for x, t in pairs(tiles) do
        for z, b in pairs(t) do
            if b then
                counts[x][z] = counts[x][z] or adj(x, z)
                counts[x - 1][z] = counts[x - 1][z] or adj(x - 1, z)
                counts[x + 1][z] = counts[x + 1][z] or adj(x + 1, z)
                counts[x][z - 1] = counts[x][z - 1] or adj(x, z - 1)
                counts[x][z + 1] = counts[x][z + 1] or adj(x, z + 1)
                counts[x - 1][z + 1] = counts[x - 1][z + 1] or adj(x - 1, z + 1)
                counts[x + 1][z - 1] = counts[x + 1][z - 1] or adj(x + 1, z - 1)
            end
        end
    end
    for x, t in pairs(counts) do
        for z, c in pairs(t) do
            tiles[x][z] = c == 2 or c == 1 and tiles[x][z]
        end
    end
end
print(a, count())
