rows, save = {}, {}
for row in io.lines() do
    r = {}
    for c in row:gmatch('.') do table.insert(r, c) end
    table.insert(rows, r)
    table.insert(save, r)
end
function adj(x, y)
    q = 0
    for a = -1, 1 do
        for b = -1, 1 do
            if a ~= 0 or b ~= 0 then
                c, d = y + a, x + b
                while see and rows[c] and rows[c][d] == '.' do
                    c, d = c + a, d + b
                end
                if rows[c] and rows[c][d] == '#' then q = q + 1 end
            end
        end
    end
    return q
end
rule = 4
function step()
    local t, v = 0, 0
    next = {}
    for y = 1, #rows do
        next[y] = {}
        for x = 1, #rows[y] do
            n = adj(x, y)
            if rows[y][x] == 'L' and n == 0 then
                next[y][x] = '#'
                t = t + 1
            elseif rows[y][x] == '#' and n >= rule then
                next[y][x] = 'L'
                t = t + 1
            else
                next[y][x] = rows[y][x]
            end
            if next[y][x] == '#' then v = v + 1 end
        end
    end
    rows = next
    return t, v
end
repeat delta, z = step() until delta == 0
rule, see, rows = 5, true, save
repeat delta, w = step() until delta == 0
print(z, w)
