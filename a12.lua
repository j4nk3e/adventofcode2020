x, y, d = 0, 0, 0
function F(n)
    if d == 0 then
        E(n)
    elseif d == 90 then
        S(n)
    elseif d == 180 then
        W(n)
    else
        N(n)
    end
end
function R(n) d = (d + n) % 360 end
function L(n) d = (d - n + 360) % 360 end
function E(n) x = x + n end
function W(n) x = x - n end
function S(n) y = y + n end
function N(n) y = y - n end

for c, n in io.read '*a':gmatch '(%u)(%d+)' do
    print(c, n)
    _G[c](n + 0)
    print(x, y, d)
end
print(math.abs(x) + math.abs(y))
