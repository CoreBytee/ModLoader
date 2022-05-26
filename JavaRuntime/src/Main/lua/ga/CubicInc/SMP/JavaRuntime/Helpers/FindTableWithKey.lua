return function (Tbl, Key, Value)
    for Index, SubTable in pairs(Tbl) do
        if SubTable[Key] == Value then
            return SubTable
        end
    end
end