-- if true then
-- 	return {}
-- end
return {
	"ibhagwan/fzf-lua",
	event = "VeryLazy",
	cmd = "FzfLua",
	dependencies = { "echasnovski/mini.icons" },
	opts = {
		"ivy",
		defaults = {
			file_icons = "mini",
		},
	},
}
