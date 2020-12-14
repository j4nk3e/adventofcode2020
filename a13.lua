b = require 'bint'(64)
d, l = 0, io.lines()
i = l()
for t in l():gmatch '%P+' do
    if t ~= 'x' then
        w = math.ceil(i / t) * t - i
        if not m or w < m then
            m = w
            r = t * w
        end
        if o then
            while not b.eq((o + d) % t, 0) do o = o + p end
            p = p * t
        else
            o = 0
            p = b(t)
        end
    end
    d = d + 1
end
print(r, o)
