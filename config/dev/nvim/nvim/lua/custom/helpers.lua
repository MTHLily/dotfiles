local helper = {}

helper.mergeTables = function(base_table, ...)
    for _, table in ipairs(vararg) do
        for _, v in ipairs(table) do base_table.insert(v) end
    end
end

return helper
