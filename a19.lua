require 'pl'
local rules = {}
local matches = 0

local function resolve(rule_id)
    local rule = rules[rule_id]
    if type(rule) == 'string' then return {[rule] = true} end
    local result = {}
    for _, group in pairs(rule) do
        local part_result = resolve(group[1])
        if group[2] then
            for g in pairs(resolve(group[2])) do
                for prefix in pairs(part_result) do
                    result[prefix .. g] = true
                end
            end
        else
            for part in pairs(part_result) do result[part] = true end
        end
    end
    return result
end

local allowed
for line in io.lines() do
    local num, rule = line:gmatch('(%d+): ([^\n]+)')()
    if num then
        local c = rule:gmatch('"(%l)"')()
        if c then
            rules[num + 0] = c
        else
            local parts = {}
            rules[num + 0] = parts
            for p in ('| ' .. rule):gmatch('%|([%s%d]+)') do
                local group = {}
                table.insert(parts, group)
                for d in p:gmatch('%s(%d+)') do
                    table.insert(group, d + 0)
                end
            end
        end
    elseif #line == 0 then
        allowed = resolve(0)
    elseif #line > 0 then
        if allowed[line] then matches = matches + 1 end
    end
end
print(matches)
