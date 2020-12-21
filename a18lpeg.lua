require 'lpeg'
-- Lexical Elements
local Space = lpeg.S(' ') ^ 0
local Number = lpeg.C(lpeg.R("09") ^ 1) * Space
local TermOp = lpeg.C(lpeg.S("+*")) * Space
local Open = "(" * Space
local Close = ")" * Space

-- Grammar
local Exp, Factor = lpeg.V "Exp", lpeg.V "Factor"
G = lpeg.P {
    Exp,
    Exp = lpeg.Ct((Factor * TermOp) ^ 0 * Factor),
    Factor = Number + Open * Exp * Close
}

G = Space * G * -1

-- Evaluator
function eval(x)
    if type(x) == 'string' then
        return tonumber(x)
    else
        local op1 = eval(x[1])
        for i = 2, #x, 2 do
            local op = x[i]
            local op2 = eval(x[i + 1])
            if (op == "+") then
                op1 = op1 + op2
            elseif (op == "*") then
                op1 = op1 * op2
            end
        end
        return op1
    end
end

sum = 0
for line in io.lines() do sum = sum + eval(lpeg.match(G, line)) end
print(sum)
