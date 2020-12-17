local valid, errorRate, r = nil, nil, {}
local d = 'departure'
local e = '%d+'

local function checkRule(rule, n)
    for name, part in pairs(rule.rules) do
        if part[1] <= n and part[2] >= n then return name end
    end
end

local function check(n)
    for _, rules in pairs(r) do if checkRule(rules, n) then return true end end
end

local function insertValid(str)
    local i = 1
    local t = {}
    table.insert(valid, t)
    for num in str:gmatch(e) do
        t[i] = num + 0
        i = i + 1
    end
end

local i = 0
for line in io.lines() do
    local name, rules = line:gmatch('(%P+): ([^\n]+)')()
    if rules then
        for from, to in (rules .. ' or'):gmatch('(%d+)-(%d+) or') do
            if not r[name] then r[name] = {rules = {}} end
            table.insert(r[name].rules, {from + 0, to + 0})
        end
        i = i + 1
    elseif line:find('your.*') then
        valid = {}
    elseif line:find('nearby.*') then
        errorRate = 0
    elseif errorRate then
        local ok = true
        for num in line:gmatch(e) do
            if not check(num + 0) then
                errorRate = errorRate + num
                ok = false
            end
        end
        if ok then insertValid(line) end
    elseif valid and line:find(e) then
        insertValid(line)
    end
end
for _, rule in pairs(r) do
    rule.candidates = {}
    for n = 1, i do rule.candidates[n] = true end
end

local function count(candidates)
    local c, last = 0, 0
    for n, ok in pairs(candidates) do
        if ok then
            c = c + 1
            last = n
        end
    end
    return c, last
end

local function search()
    for name, rule in pairs(r) do
        if name:find(d) and not rule.i then return true end
    end
end

while search() do
    search()
    for _, rule in pairs(r) do
        for _, ticket in pairs(valid) do
            for n = 1, #ticket do
                if not checkRule(rule, ticket[n]) then
                    rule.candidates[n] = nil
                end
            end
        end
        local c, last = count(rule.candidates)
        if c == 1 then
            rule.i = last
            for _, del in pairs(r) do del.candidates[last] = false end
        end
    end
end
local n = 1
for name, rule in pairs(r) do if name:find(d) then n = n * valid[1][rule.i] end end
print(errorRate, n)
