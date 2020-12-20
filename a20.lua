local bit = require "bit"
local p, borders = {}, {}
local piece
for line in io.lines() do
    local id = line:gmatch '(%d+)'()
    if id then
        piece = {id = id + 0, count = {}}
        p[piece.id] = piece
    elseif #line > 0 then
        table.insert(piece, tonumber(line:gsub('#', '1'):gsub('%.', '0'), 2))
    end
end
for id, piece in pairs(p) do
    local r, l = 0, 0
    for i, b in ipairs(piece) do
        r = r + bit.lshift(bit.band(1, b), i - 1)
        l = l + bit.lshift(bit.band(bit.rshift(b, 9), 1), i - 1)
    end
    piece.border = {l, r, piece[1], piece[10]}
    for i = 1, 4 do
        local q = 0
        for n = 1, 10 do
            q = bit.bor(q, bit.lshift(bit.band(
                                          bit.rshift(piece.border[i], n - 1), 1),
                                      10 - n))
        end
        table.insert(piece.border, q)
    end
    for _, b in ipairs(piece.border) do
        if borders[b] then
            table.insert(borders[b], piece.id)
        else
            borders[b] = {piece.id}
        end
    end
end
for b, ids in pairs(borders) do
    for _, id in pairs(ids) do
        if #ids == 2 then table.insert(p[id].count, #ids) end
    end
end
fac = 1
for id, piece in pairs(p) do
    print(id, #piece.count)
    if #piece.count == 4 then fac = fac * id end
end
print(fac)