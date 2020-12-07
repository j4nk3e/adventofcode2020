g = 'shiny gold'
n, x, r = 0, -1, {[g] = 1}
u = '(%a+ %a+) bags?%p?%s?'
v = ' contain (.-)%.'
w, z, i = u .. v, '(%d) ' .. u, io.read '*a'
while x < n do
    x = n
    for a, b in i:gmatch(w) do
        for c, d in b:gmatch(z) do
            t = r[d] and not r[a]
            r[a] = t and c or r[a]
            n = n + (t and 1 or 0)
        end
    end
end
function s(c)
    m = 1
    for c, d in i:gmatch(c .. ' bags' .. v)():gmatch(z) do m = m + c * s(d) end
    return m
end
print(n, s(g) - 1)
