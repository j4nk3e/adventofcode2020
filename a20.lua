local bit = require "bit"
local p, borders = {}, {}
local piece
for line in io.lines() do
    local id = line:gmatch '(%d+)'()
    if id then
        piece = {
            id = id + 0,
            count = {},
            rot = 0,
            flip = false,
            r = function(self)
                return self.border[(self.rot + 0) % 4 + (self.flip and 5 or 1)]
            end,
            b = function(self)
                return self.border[(self.rot + (self.flip and 3 or 1)) % 4 +
                           (self.flip and 5 or 1)]
            end,
            l = function(self)
                return self.border[(self.rot + 2) % 4 + (self.flip and 5 or 1)]
            end,
            t = function(self)
                return self.border[(self.rot + (self.flip and 1 or 3)) % 4 +
                           (self.flip and 5 or 1)]
            end
        }
        p[piece.id] = piece
    elseif #line > 0 then
        piece[#piece + 1] = tonumber(line:gsub('#', '1'):gsub('%.', '0'), 2)
    end
end
local p_count = 0
for id, piece in pairs(p) do
    p_count = p_count + 1
    local r, l = 0, 0
    for i, b in ipairs(piece) do
        r = r + bit.lshift(bit.band(1, b), i - 1)
        l = l + bit.lshift(bit.band(bit.rshift(b, 9), 1), i - 1)
    end
    piece.border = {r, piece[10], l, piece[1]}
    for i = 1, 4 do
        local q = 0
        for n = 1, 10 do
            q = bit.bor(q, bit.lshift(bit.band(
                                          bit.rshift(piece.border[i], n - 1), 1),
                                      10 - n))
        end
        piece.border[#piece.border + 1] = q
    end
    for _, b in ipairs(piece.border) do
        if borders[b] then
            borders[b][#borders[b] + 1] = piece.id
        else
            borders[b] = {piece.id}
        end
    end
end
for _, ids in pairs(borders) do
    for _, id in pairs(ids) do
        if #ids == 2 then p[id].count[#p[id].count + 1] = #ids end
    end
end
local fac = 1
local corners = {}
for id, piece in pairs(p) do
    if #piece.count == 4 then
        corners[#corners + 1] = id
        fac = fac * id
    end
end
print(fac)
local tl = p[table.remove(corners, #corners)]
local row = {tl}
local rows = {row}
while #borders[tl:l()] ~= 1 or #borders[tl:t()] ~= 1 do tl.rot = tl.rot + 1 end
while #borders[row[#row]:r()] ~= 1 do
    local prev_r = row[#row]:r()
    local next_b = borders[prev_r]
    local next
    if next_b[1] == row[#row].id then
        next = p[next_b[2]]
    else
        next = p[next_b[1]]
    end
    while next:l() ~= prev_r do
        next.rot = next.rot + 1
        if next.rot > 3 then
            next.flip = true
            next.rot = next.rot % 4
        end
    end
    assert(next:l() == prev_r)
    row[#row + 1] = next
end
while #rows * #row < p_count do
    row = {}
    rows[#rows + 1] = row
    while #row < #rows[#rows - 1] do
        local prev_b = rows[#rows - 1][#row + 1]:b()
        local next_b = borders[prev_b]
        assert(#next_b == 2)
        print(rows[#rows - 1][#row + 1].rot, rows[#rows - 1][#row + 1].flip,
              #next_b, #rows, #row + 1)
        local next
        if next_b[1] == rows[#rows - 1][#row + 1].id then
            next = p[next_b[2]]
        else
            next = p[next_b[1]]
        end
        assert(next)
        while next:t() ~= rows[#rows - 1][#row + 1]:b() do
            next.rot = next.rot + 1
            if next.rot > 3 then
                next.flip = true
                next.rot = next.rot % 4
            end
        end
        assert(next:t() == prev_b)
        row[#row + 1] = next
    end
end
print(#rows)
