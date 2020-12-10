a, b, n, q, m = 1, 1, 1, 25, {}
for i in io.lines() do
    m[n] = i + 0
    if n > q then
        for x = n - q, n do
            for y = n - q, n do
                if m[x] + m[y] == m[n] then goto e end
            end
        end
        g = m[n]
    end
    ::e::
    n = n + 1
end
t = m[1]
repeat
    if t > g then
        t = t - m[a]
        a = a + 1
    elseif t < g then
        b = b + 1
        t = t + m[b]
    end
until t == g
for r = a, b do
    y = math.min(y or m[r], m[r])
    x = math.max(x or m[r], m[r])
end
print(g, y + x)
