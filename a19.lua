local rules = {}
local a, b = 0, 0

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
        -- 0: 8 11
        prefixes = resolve(42)
        postfixes = resolve(31)
    elseif #line > 0 then
        local pre_count = 0
        local post_count = 0
        for i = 1, #line, 8 do
            if prefixes[line:sub(i, i + 7)] then
                pre_count = pre_count + 1
            else
                break
            end
        end
        for i = #line - 7, 1, -8 do
            if postfixes[line:sub(i, i + 7)] then
                post_count = post_count + 1
            else
                break
            end
        end
        local chunks = #line / 8
        if pre_count >= 2 and post_count >= 1 and chunks == 3 then
            a = a + 1
        end
        if post_count > 0 and pre_count > post_count and post_count + pre_count >=
            chunks then b = b + 1 end
    end
end
print(a, b)
