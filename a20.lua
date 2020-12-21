local bit = require "bit"
local p, borders = {}, {}
local piece
for line in io.lines() do
    local id = line:gmatch '(%d+)'()
    if id then
        piece = {
            id = id + 0,
            count = {},
            rot = 1,
            flip = false,
            r = function(self)
                local index = self.flip and 5 + (self.rot - 1) % 4 or
                                  (self.rot - 1) % 4 + 1
                return self.border[index]
            end,
            b = function(self)
                local index = self.flip and 5 + (self.rot + 2) % 4 or
                                  (self.rot + 0) % 4 + 1
                return self.border[index]
            end,
            l = function(self)
                local index = self.flip and 5 + (self.rot + 1) % 4 or
                                  (self.rot + 1) % 4 + 1
                return self.border[index]
            end,
            t = function(self)
                local index = self.flip and 5 + (self.rot + 0) % 4 or
                                  (self.rot + 2) % 4 + 1
                return self.border[index]
            end,
            reset = function(self)
                self.rot = 1
                self.flip = false
            end,
            rotate = function(self)
                self.rot = self.rot + 1
                if self.rot > 4 then
                    self.flip = true
                    self.rot = 1
                end
            end,
            pixels = function(self)
                local px = {}
                local max = 8
                local offset = 1
                for y = 1, max do
                    for x = 1, max do
                        if self.rot == 1 then
                            table.insert(px,
                                         1 ==
                                             bit.band(
                                                 bit.rshift(
                                                     self[(self.flip and max - y +
                                                         1 or y) + offset],
                                                     max - x + offset), 1))
                        elseif self.rot == (self.flip and 2 or 4) then
                            table.insert(px,
                                         1 ==
                                             bit.band(
                                                 bit.rshift(
                                                     self[(self.flip and x or
                                                         max - x + 1) + offset],
                                                     max - y + offset), 1))
                        elseif self.rot == 3 then
                            table.insert(px,
                                         1 ==
                                             bit.band(
                                                 bit.rshift(
                                                     self[(self.flip and y or
                                                         max - y + 1) + offset],
                                                     x - 1 + offset), 1))
                        elseif self.rot == (self.flip and 4 or 2) then
                            table.insert(px,
                                         1 ==
                                             bit.band(
                                                 bit.rshift(
                                                     self[(self.flip and max - x +
                                                         1 or x) + offset],
                                                     y - 1 + offset), 1))
                        end
                    end
                end
                return px
            end
        }
        p[piece.id] = piece
    elseif #line > 0 then
        piece[#piece + 1] = tonumber(line:gsub('#', '1'):gsub('%.', '0'), 2)
    end
end

local function mir(z)
    local q = 0
    for n = 1, 10 do
        q = bit.bor(q, bit.lshift(bit.band(bit.rshift(z, n - 1), 1), 10 - n))
    end
    return q
end

local p_count = 0
for _, pc in pairs(p) do
    p_count = p_count + 1
    local r, l = 0, 0
    for i, b in ipairs(pc) do
        r = r + bit.lshift(bit.band(1, b), i - 1)
        l = l + bit.lshift(bit.band(bit.rshift(b, 9), 1), i - 1)
    end
    -- assign borders here
    pc.border = {r, pc[10], mir(l), mir(pc[1]), mir(r), mir(pc[10]), l, pc[1]}
    for _, b in ipairs(pc.border) do
        if borders[b] then
            borders[b][#borders[b] + 1] = pc.id
        else
            borders[b] = {pc.id}
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
for id, pc in pairs(p) do
    if #pc.count == 4 then
        corners[#corners + 1] = id
        fac = fac * id
    end
end
print(fac)

for corn = 1, 8 do
    local start = p[corners[corn % 4 + 1]]
    start.flip = corn > 4
    local row = {start}
    local rows = {row}
    while #borders[start:l()] ~= 1 or #borders[start:t()] ~= 1 do
        start:rotate()
    end
    while #borders[row[#row]:r()] ~= 1 do
        local prev_r = row[#row]:r()
        local next_ids = borders[prev_r]
        local next
        if next_ids[1] == row[#row].id then
            next = p[next_ids[2]]
        else
            next = p[next_ids[1]]
        end
        next:reset()
        while mir(next:l()) ~= prev_r do next:rotate() end
        row[#row + 1] = next
    end
    while #rows * #row < p_count do
        row = {}
        rows[#rows + 1] = row
        while #row < #rows[#rows - 1] do
            local prev_b = rows[#rows - 1][#row + 1]:b()
            local next_ids = borders[prev_b]
            local next
            if next_ids[1] == rows[#rows - 1][#row + 1].id then
                next = p[next_ids[2]]
            else
                next = p[next_ids[1]]
            end
            next:reset()
            while mir(next:t()) ~= rows[#rows - 1][#row + 1]:b() do
                next:rotate()
            end
            row[#row + 1] = next
        end
    end
    local lines = {}
    for i = 1, 12 * 8 do lines[i] = {} end
    local total = 0
    for y, r in ipairs(rows) do
        for x, c in ipairs(r) do
            for i, q in ipairs(c:pixels()) do
                local qy = (y - 1) * 8 + math.floor((i - 1) / 8) + 1
                local qx = (x - 1) * 8 + (i - 1) % 8 + 1
                lines[qy][qx] = q and '#' or '.'
                if q then total = total + 1 end
            end
        end
    end
    local l1 = '..................#.'
    local l2 = '#....##....##....###'
    local l3 = '.#..#..#..#..#..#...'
    local txt = {}
    for _, r in ipairs(lines) do
        local l = ''
        for _, c in ipairs(r) do l = c .. l end
        txt[#txt + 1] = l
    end
    local monster = {}
    for i = 2, #txt - 1 do
        local m2 = txt[i]:find(l2, 0)
        while m2 do
            local m1 = txt[i - 1]:find(l1, m2)
            local m3 = txt[i + 1]:find(l3, m2)
            if m1 == m2 and m2 == m3 then
                table.insert(monster, {i, m2})
            end
            m2 = txt[i]:find(l2, m2 + 1)
        end
    end
    print(#monster, total - #monster * 15)
end
