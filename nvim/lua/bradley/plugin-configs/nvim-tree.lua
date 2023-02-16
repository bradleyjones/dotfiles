require("nvim-tree").setup({
	hijack_cursor = true,

	view = {
		adaptive_size = true,
		width = 30,
		side = "left",
		mappings = {
			list = {
				{ key = "<C-[>", action = "dir_up" },
				{ key = "<C-]", action = "cd" },
				{ key = "?", action = "toggle_help" },
				{ key = " ", action = "preview" },
			},
		},
		float = {
			enable = false,
		},
	},

	git = {
		enable = true, -- show git statuses
	},

	actions = {
		open_file = {
			quit_on_open = true,
		}
	},
})
