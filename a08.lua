function machine()
    return {
        a = 0,
        p = 1,
        nop = function(self) return self.p + 1 end,
        jmp = function(self, q) return self.p + q end,
        acc = function(self, q)
            self.a = self.a + q
            return self.p + 1
        end
    }
end
i, mem = 1, {}
for cmd in io.lines() do
    c, a = cmd:gmatch '(%S+) (%S+)'()
    mem[i] = {c = c, a = a}
    i = i + 1
end
function run(replace)
    local pos, ops = {}, machine()
    while '' do
        if (pos[ops.p]) then return ops.a end
        pos[ops.p] = true
        if ops.p > #mem then return nil, ops.a end
        c, a = mem[ops.p].c, mem[ops.p].a
        if ops.p == replace then
            if c == 'nop' then
                ops.p = ops.jmp(ops, a)
            elseif c == 'jmp' then
                ops.p = ops.nop(ops, a)
            end
        else
            ops.p = ops[c](ops, a)
        end
    end
end
i = 0
while '' do
    r, y = run(i)
    x = i == 0 and r or x
    i = i + 1
    if not r then break end
end
print(x, y)
