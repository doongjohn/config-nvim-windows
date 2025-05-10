_G.Config = {}

_G.Config.buf_get_short_path = function()
	local filepath = vim.fs.normalize(vim.fn.expand("%:.:h"))
	if not filepath or filepath == "." then
		return ""
	end
	local parts = vim.split(filepath, "/")
	local n = #parts
	if n >= 3 then
		return "…/" .. table.concat(vim.list_slice(parts, math.max(n - 2, 1)), "/")
	else
		return filepath
	end
end

_G.Config.oil_get_path = function()
	return vim.api.nvim_buf_get_name(0):sub(7, -1)
end

_G.Config.rg_get_exclude = function()
	local exclude = {
		-- files
		"*.a",
		"*.o",
		"*.so",
		"*.obj",
		"*.lib",
		"*.dll",
		"*.exe",
		"*.ilk",
		"*.pdb",
		"*.pdf",
		"*.png",
		"*.jpg",
		"*.jpeg",
		"*.gif",
		"*.ttf",
		"*.otf",
		"*.psd",
		"*.fbx",
		"*.vrm",

		-- folders
		".git/",
		".github/",
		"*cache/",
		"obj/",
		".objs/",
		".deps/",
		".venv/",
		"bin/",
		"out/",
		"build/",
		"target/",
		"vendor/",
		"dist/",
		"node_modules/",
		".svelte-kit/",
		"__pycache__/",
		"zig-out/",
		".godot/",
	}

	local exclude_unity_engine = {
		"*.meta",
		"*.asset",
		"*.unity",
		"*.prefab",
		"*.mat",
		"*.physicMaterial",
		"*.inputactions",
		"Logs/*",
		"Temp/*",
		"Library/*",
		"Packages/*",
		"ProjectSettings/*",
		"UserSettings/*",
		"UIElementsSchema/*",
	}
	if vim.fn.isdirectory("./Assets") and vim.fn.filereadable("./Assembly-CSharp.csproj") then
		exclude = vim.tbl_extend("force", exclude, exclude_unity_engine)
	end

	return exclude
end
