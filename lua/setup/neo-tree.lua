require("neo-tree").setup({
	window = {
		mappings = {
			["Y"] = function(state)
				-- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
				-- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
				local node = state.tree:get_node()
				local filepath = node:get_id()
				local filename = node.name
				local modify = vim.fn.fnamemodify

				local results = {
					filepath,
					modify(filepath, ":."),
					modify(filepath, ":~"),
					filename,
					modify(filename, ":r"),
					modify(filename, ":e"),
				}

				vim.ui.select({
					"1. Absolute path: " .. results[1],
					"2. Path relative to CWD: " .. results[2],
					"3. Path relative to HOME: " .. results[3],
					"4. Filename: " .. results[4],
					"5. Filename without extension: " .. results[5],
					"6. Extension of the filename: " .. results[6],
				}, { prompt = "Choose to copy to clipboard:" }, function(choice)
					if choice == nil then
						return
					end
					local i = tonumber(choice:sub(1, 1))
					local result = results[i]
					vim.fn.setreg('"', result)
					vim.notify("Copied: " .. result)
				end)
			end,
		},
	},
	filesystem = {
		bind_to_cwd = false, -- Prevent Neo-tree from changing the working directory
		--cwd_target = { current_dir = true }, -- Ensure Neo-tree uses the current working directory
	},
  event_handlers = {
    {
      event = "file_opened",
      handler = function()
        -- Automatically close Neo-tree after opening a file
        require("neo-tree.command").execute({ action = "close" })
      end,
    },
  },
})

vim.api.nvim_set_keymap("n", "<leader>n", ":Neotree reveal left<CR>", { noremap = true, silent = true })
