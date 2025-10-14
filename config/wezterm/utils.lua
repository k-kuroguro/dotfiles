local module = {}

--- Recursively merge two tables (destructive).
--- Fields from `t2` will overwrite or be merged into `t1`.
--- @param t1 table
--- @param t2 table
--- @return table
function module.merge_tables_inplace(t1, t2)
	for k, v in pairs(t2) do
		if (type(v) == "table") and (type(t1[k] or false) == "table") then
			module.merge_tables_inplace(t1[k], t2[k])
		else
			t1[k] = v
		end
	end
	return t1
end

--- Load a Lua configuration file and return its table.
--- @param path string Path to the Lua file to load.
--- @return table # The loaded configuration table, or {} on failure.
function module.load_config(path)
	if not path then
		return {}
	end

	local ok, result = pcall(dofile, path)
	if not ok or type(result) ~= "table" then
		return {}
	end

	return result
end

return module
