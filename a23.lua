local c_max
local c_min
function Cup(i)
    return {
        v = i,
        find = function(self, n)
            if self.v == n then
                return self
            elseif not self.next then
                return nil
            else
                return self.next:find(n)
            end
        end
    }
end
local cup
local start
for i in io.read '*a':gmatch '%d' do
    local c = Cup(i + 0)
    c_max = math.max(c.v, c_max or c.v)
    c_min = math.min(c.v, c_min or c.v)
    if cup then
        cup.next = c
    else
        start = c
    end
    cup = c
end

local function pr(c)
    local t = {c.v}
    local p = c.next
    while p and p ~= c do
        t[#t + 1] = p.v
        p = p.next
    end
    return table.concat(t, '')
end

cup.next = start
for _ = 1, 100 do
    -- The crab picks up the three cups that are immediately clockwise
    -- of the current cup.
    local move = start.next
    local last = move
    for i = 1, 2 do last = last.next end
    -- They are removed from the circle; cup spacing
    -- is adjusted as necessary to maintain the circle.
    start.next = last.next
    last.next = nil
    -- The crab selects a destination cup: the cup with a label equal to the
    -- current cup's label minus one. If this would select one of the cups
    -- that was just picked up, the crab will keep subtracting one until it
    -- finds a cup that wasn't just picked up.
    local label = start.v - 1
    if label < c_min then label = c_max end
    while move:find(label) do
        label = label - 1
        -- If at any point in this process the value goes below the
        -- lowest value on any cup's label, it wraps around to the
        -- highest value on any cup's label instead.
        if label < c_min then label = c_max end
    end
    local dest = start:find(label)
    -- The crab places the cups it just picked up so that they are
    -- immediately clockwise of the destination cup. They keep the
    -- same order as when they were picked up.
    last.next, dest.next = dest.next, move
    -- The crab selects a new current cup: the cup which is immediately
    -- clockwise of the current cup.
    start = start.next
end
print(pr(start:find(1).next))
