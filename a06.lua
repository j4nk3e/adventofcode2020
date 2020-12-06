s, x, d = 0, 0, '\n\n'
for g in (io.read '*a' .. d):gmatch("(.-)" .. d) do
    f, a, b = 0, {}, {}
    for e in g:gmatch '[^\n]+' do
        for c in e:gmatch '%l' do
            s = s + (a[c] and 0 or 1)
            a[c] = 1
            if f == 0 then
                x = x + (b[c] and 0 or 1)
                b[c] = 1
            end
        end
        for h in pairs(b) do
            b[h] = e:find(h)
            x = b[h] and x or x - 1
        end
        f = 1
    end
end
print(s, x)
