local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

-- Text extraction patterns similar to extrakto
local patterns = {
	-- URLs
	url = {
		"https?://[%w%.-]+[%w%-%.%_%~%:%/%?%#%[%]%@%!%$%&%'%(%)%*%+%,%;%=]*",
		"ftp://[%w%.-]+[%w%-%.%_%~%:%/%?%#%[%]%@%!%$%&%'%(%)%*%+%,%;%=]*",
		"ssh://[%w%.-]+[%w%-%.%_%~%:%/%?%#%[%]%@%!%$%&%'%(%)%*%+%,%;%=]*",
	},
	-- File paths
	path = {
		"/[%w%.%-_/]+",
		"~/[%w%.%-_/]*",
		"%.%./[%w%.%-_/]*",
		"%./[%w%.%-_/]*",
		"[%w%.%-_]+/[%w%.%-_/]*",
	},
	-- Git hashes
	git_hash = {
		"%x%x%x%x%x%x%x+",
	},
	-- IP addresses
	ip = {
		"%d+%.%d+%.%d+%.%d+",
	},
	-- Email addresses
	email = {
		"[%w%.%-_]+@[%w%.%-_]+%.[%w]+",
	},
	-- Docker container IDs/names
	docker = {
		"[%w%-_]+:[%w%.%-_]+",
	},
	-- UUIDs
	uuid = {
		"%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x",
	},
	-- Words (sequences of word characters, including hyphenated words)
	word = {
		"[%w%-]+",
	},
}

-- Extract text from pane content using patterns
local function extract_text(content, filter_type)
	local matches = {}
	local seen = {}

	local selected_patterns = filter_type and patterns[filter_type] or {}

	-- If no specific filter, use all patterns including 'word'
	if not filter_type then
		selected_patterns = {}
		for name, pattern_list in pairs(patterns) do
			for _, pattern in ipairs(pattern_list) do
				table.insert(selected_patterns, pattern)
			end
		end
	else
		selected_patterns = patterns[filter_type] or {}
	end
	-- Extract matches using selected patterns
	for _, pattern in ipairs(selected_patterns) do
		for match in content:gmatch(pattern) do
			local trimmed = match:match("^%s*(.-)%s*$") -- trim whitespace
			if trimmed and #trimmed > 2 and not seen[trimmed] then
				seen[trimmed] = true
				table.insert(matches, trimmed)
			end
		end
	end

	return matches
end

-- Main function to run extrakto
function M.run_extrakto(window, pane, filter_type, action_type)
	-- Get only visible pane content (viewport only, no scrollback)
	local lines = pane:get_logical_lines_as_text()

	local matches = extract_text(lines, filter_type)

	if #matches == 0 then
		window:toast_notification("Extrakto", "No matches found", nil, 3000)
		return
	end

	-- Create temporary file for matches
	local temp_file = os.tmpname()
	local file = io.open(temp_file, "w")
	if not file then
		window:toast_notification("Extrakto", "Failed to create temp file", nil, 3000)
		return
	end

	for _, match in ipairs(matches) do
		file:write(match .. "\n")
	end
	file:close()

	-- Get the shell command to use based on action type
	local copy_cmd = "pbcopy" -- Default for macOS

	-- Run fzf in a lower split
	window:perform_action(
		act.SplitPane({
			direction = "Down",
			size = { Percent = 30 }, -- Use 30% of the screen height
			command = {
				args = {
					"sh",
					"-c",
					string.format(
						[[
						cd "%s"
						selection=$(cat %s | /usr/local/bin/fzf \
							--height=100%% \
							--layout=reverse \
							--border \
							--prompt="Extrakto> " \
							--preview-window=hidden \
							--header="ENTER=copy to clipboard, ESC=cancel" \
							--bind="enter:accept" \
							--bind="esc:abort")

						if [ $? -eq 0 ] && [ -n "$selection" ]; then
							printf "%%s" "$selection" | %s
						fi

						rm -f %s
						exit 0
					]],
						os.getenv("HOME") or "/tmp",
						temp_file,
						copy_cmd,
						temp_file
					),
				},
				cwd = os.getenv("HOME") or "/tmp",
			},
		}),
		pane
	)
end

-- Convenience functions for different filter types
function M.run_extrakto_all(window, pane)
	M.run_extrakto(window, pane, nil, "copy")
end

function M.run_extrakto_urls(window, pane)
	M.run_extrakto(window, pane, "url", "copy")
end

function M.run_extrakto_paths(window, pane)
	M.run_extrakto(window, pane, "path", "copy")
end

function M.run_extrakto_words(window, pane)
	M.run_extrakto(window, pane, "word", "copy")
end

function M.run_extrakto_git(window, pane)
	M.run_extrakto(window, pane, "git_hash", "copy")
end

-- Insert version (experimental)
function M.run_extrakto_insert(window, pane)
	M.run_extrakto(window, pane, nil, "insert")
end

-- Get key bindings for extrakto
function M.get_keys()
	return {
		-- Main extrakto binding (like tmux prefix + tab)
		{
			key = "e",
			mods = "LEADER",
			action = wezterm.action_callback(M.run_extrakto_all),
		},
		-- Individual filter bindings
		{
			key = "u",
			mods = "LEADER|CTRL",
			action = wezterm.action_callback(M.run_extrakto_urls),
		},
		{
			key = "p",
			mods = "LEADER|CTRL",
			action = wezterm.action_callback(M.run_extrakto_paths),
		},
		{
			key = "w",
			mods = "LEADER|CTRL",
			action = wezterm.action_callback(M.run_extrakto_words),
		},
		{
			key = "g",
			mods = "LEADER|CTRL",
			action = wezterm.action_callback(M.run_extrakto_git),
		},
		-- Show command palette for extrakto (alternative to menu)
		{
			key = "E",
			mods = "LEADER|SHIFT",
			action = wezterm.action.ShowLauncherArgs({
				title = "Extrakto - Use Ctrl+A + Ctrl+Key for filters",
				flags = "FUZZY|KEY_ASSIGNMENTS",
			}),
		},
	}
end

return M

