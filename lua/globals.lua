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

_G.Config.fyler_get_path = function()
	return vim.api.nvim_buf_get_name(0):sub(9, -1)
end

_G.Config.search_get_exclude = function()
	local exclude = {
		-- binary files
		"*.a",
		"*.o",
		"*.so",
		"*.obj",
		"*.lib",
		"*.dll",
		"*.exe",
		"*.ilk",
		"*.pdb",
		"*.tar",
		"*.gz",
		"*.xz",
		"*.zip",
		"*.7z",
		"*.jar",

		-- media files
		"*.pdf",
		"*.png",
		"*.jpg",
		"*.jpeg",
		"*.gif",
		"*.ico",
		"*.svg",
		"*.wav",
		"*.ogg",
		"*.mp3",
		"*.mp4",
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
		"dist/",
		"target/",
		"vendor/",
		".vs/",
		".idea/",
		".gradle/",
		"gradle/wrapper/",
		"__pycache__/",
		"zig-out/",
		"node_modules/",
		".svelte-kit/",
		".godot/",
	}

	local exclude_java = {
		".classpath",
		".project",
		".settings",
	}
	if vim.fn.isdirectory("./.gradle") == 1 and vim.fn.filereadable("./gradlew") == 1 then
		exclude = vim.tbl_extend("force", exclude, exclude_java)
	end

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
	if vim.fn.isdirectory("./Assets") == 1 and vim.fn.filereadable("./Assembly-CSharp.csproj") == 1 then
		exclude = vim.tbl_extend("force", exclude, exclude_unity_engine)
	end

	return exclude
end
