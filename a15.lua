i, p, m = 0, 0, {}
function n()
    s = m[p]
    m[p], i = i, i + 1
end
for t in io.read '*a':gmatch '%d+' do
    p = t + 0
    n()
end
while i < 30000000 do
    p = s and i - s - 1 or 0
    n()
    b = i == 2020 and p or b
end
print(p, b)