require 'pl'
local gd = {}
for p in io.read '*a':gmatch 'Player %d:\n([%d%s]+)' do
    local d = {}
    for n in p:gmatch '%d+' do d[#d + 1] = n + 0 end
    gd[#gd + 1] = d
end

local function play_rec(decks, round, s1, s2)
    local prev = {}
    local size = {s1, s2}
    while size[1] > 0 and size[2] > 0 do
        -- check game that had exactly the same cards in the same order
        -- actually only check the same match in the same round
        -- draw cards
        local key = table.concat(decks[1], ' ', round, round + size[1] - 1) ..
                        '\n'
        table.concat(decks[2], ' ', round, round + size[2] - 1)
        if (prev[key]) then return 1, round, size[1] end
        prev[key] = true
        -- draw cards
        local c1, c2 = decks[1][round], decks[2][round]
        local comp = {c1, c2}
        round = round + 1
        -- check both players have at least as many cards remaining in their
        -- deck as the value of the card they just drew
        local recurse = true
        for i = 1, 2 do if size[i] - 1 < comp[i] then recurse = false end end
        -- determine winner
        local rw =
            recurse and play_rec(tablex.deepcopy(decks), round, c1, c2) or c1 >
                c2 and 1 or 2
        -- move cards down
        decks[rw][round + size[rw] - 1] = comp[rw]
        decks[rw][round + size[rw]] = comp[3 - rw]
        size[rw] = size[rw] + 1
        size[3 - rw] = size[3 - rw] - 1
        decks[1][round - 1] = nil
        decks[2][round - 1] = nil
    end
    -- one deck is empty
    local winner = size[1] > 0 and 1 or 2
    return winner, round, size[winner]
end

local winner, round, size = play_rec(gd, 1, #gd[1], #gd[2])
local f = 1
local score = 0
for i = round + size - 1, round, -1 do
    score = score + gd[winner][i] * f
    f = f + 1
end
print(winner, score)
