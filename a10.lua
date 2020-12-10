n, a, b, m = 1, 0, 1, {}
for j in io.lines() do
    m[n] = j + 0
    n = n + 1
end
t = m[1]
table.sort(m)
p = 0
m[0] = 0
for n, j in pairs(m) do
    if j - p == 1 then
        a = a + 1
    elseif j - p == 3 then
        b = b + 1
    end
    p = j
end
v = {}
function r(i)
    if i == #m then
        return 1
    elseif v[i] then
        return v[i]
    end
    b = 0
    for n = i + 1, #m do
        if m[n] > m[i] + 3 then break end
        b = b + r(n)
    end
    v[i] = b
    return b
end
print(a * b, r(0))

