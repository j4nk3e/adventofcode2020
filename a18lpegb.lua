require 'lpeg'
-- Lexical Elements
local Space = lpeg.S(" \n\t") ^ 0
local Number = lpeg.C(lpeg.P "-" ^ -1 * lpeg.R("09") ^ 1) * Space
local TermOp = lpeg.C(lpeg.S("*/")) * Space
local FactorOp = lpeg.C(lpeg.S("+-")) * Space
local Open = "(" * Space
local Close = ")" * Space

-- Grammar
local Exp, Term, Factor = lpeg.V "Exp", lpeg.V "Term", lpeg.V "Factor"
G = lpeg.P {
    Exp,
    Exp = lpeg.Ct(Term * (TermOp * Term) ^ 0),
    Term = lpeg.Ct(Factor * (FactorOp * Factor) ^ 0),
    Factor = Number + Open * Exp * Close
}

G = Space * G * -1

function e(x)
    if type(x) == "string" then
        return tonumber(x)
    else
        local op1 = e(x[1])
        for i = 2, #x, 2 do
            local op = x[i]
            local op2 = e(x[i + 1])
            if (op == "+") then
                op1 = op1 + op2
            elseif (op == "*") then
                op1 = op1 * op2
            end
        end
        return op1
    end
end

function evalExp(s) return e(lpeg.match(G, s)) end

s = 0
for line in io.lines() do
    e = evalExp(line)
    s = s + e
    print(line, '=', e, '=>', s)
end
print(s)

