x, y = 0, 0
wx, wy = 10, -1
function F(n)
    x = x + wx * n
    y = y + wy * n
end
function R(n)
    if n == 180 then
        wx, wy = -wx, -wy
    elseif n == 90 then
        wx, wy = -wy, wx
    elseif n == 270 then
        wx, wy = wy, -wx
    end
end
function L(n) R(360 - n) end
function E(n) wx = wx + n end
function W(n) wx = wx - n end
function S(n) wy = wy + n end
function N(n) wy = wy - n end

for c, n in io.read '*a':gmatch '(%u)(%d+)' do _G[c](n + 0) end
print(math.abs(x) + math.abs(y))
