function calc(result, operator, num)
    if operator == '+' then
        return result + num
    else
        return result * num
    end
end

function eval(b)
    local result = 0
    local operator = '+'
    for num, op in b:gmatch('(%d*)(%p*)') do
        if op == '+' or op == '*' then
            operator = op
        elseif op == '(' then
            return tostring(eval(b:gsub('%b()', function(q)
                return tostring(eval(q:sub(2, -2)))
            end)))
        elseif num ~= '' then
            result = calc(result, operator, num)
        end
    end
    return tostring(result)
end

sum = 0
for line in io.lines() do
    e = eval(line)
    sum = sum + e
    print(line, '=', e, '=>', sum)
end
print(sum)

