decks = {}
for p in io.read '*a':gmatch 'Player %d:\n([%d%s]+)' do
    d = {}
    for n in p:gmatch '%d+' do d[#d + 1] = n + 0 end
    decks[#decks + 1] = d
end
size = {#decks[1], #decks[2]}
round = 1
while size[1] > 0 and size[2] > 0 do
    comp = {decks[1][round], decks[2][round]}
    greater = comp[1] > comp[2] and 1 or 2
    decks[greater][round + size[greater]] = comp[greater]
    decks[greater][round + size[greater] + 1] = comp[3 - greater]
    size[greater] = size[greater] + 1
    size[3 - greater] = size[3 - greater] - 1
    for i = 1, 2 do decks[i][round] = nil end
    round = round + 1
end
winner = size[1] > size[2] and 1 or 2
f = 1
score = 0
for i = round + size[winner] - 1, round, -1 do
    score = score + decks[winner][i] * f
    f = f + 1
end
print(score)
