--!optimize 2
--!native

local mod = {}

local function merge(...: { [any]: any }): { [any]: any }
	local merged = {}
	for _, tbl in { ... } do
		for k: any, v in tbl do
			merged[k] = v
		end
	end
	return merged
end

mod.merge =
	merge :: (<T1, T2>(T1, T2) -> T1 & T2) & (<T1, T2, T3>(T1, T2, T3) -> T1 & T2 & T3) & (<T1, T2, T3, T4>(T1, T2, T3, T4) -> T1 & T2 & T3 & T4)

return mod
