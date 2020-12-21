require 'pl'
local inp = {}
local allerg = {}
local ingr = {}
local ing_count = {}
for i, a in io.read '*a':gmatch('([^\n]+) %(contains ([^\n]+)%)') do inp[i] = a end
for i, a in pairs(inp) do
    ingredients = {}
    for w in i:gmatch('%l+') do
        ingredients[#ingredients + 1] = w
        ing_count[w] = (ing_count[w] or 0) + 1
        ingr[w] = true
    end
    for b in a:gmatch('%l+') do
        if not allerg[b] then
            allerg[b] = Set(ingredients)
        else
            allerg[b] = allerg[b] * Set(ingredients)
        end
    end
end
unique = false
while not unique do
    unique = true
    for q, b in pairs(allerg) do
        if Set.len(b) == 1 then
            for h, brem in pairs(allerg) do
                if h ~= q then allerg[h] = brem - b end
            end
        else
            unique = false
        end
        for i in pairs(b) do ingr[i] = nil end
    end
end
count = 0
for i in pairs(ingr) do count = count + ing_count[i] end
keys = tablex.keys(allerg)
table.sort(keys)
n = ''
for _, k in pairs(keys) do
    if #n > 0 then n = n .. ',' end
    n = n .. Set.values(allerg[k])[1]
end
print(count, n)
