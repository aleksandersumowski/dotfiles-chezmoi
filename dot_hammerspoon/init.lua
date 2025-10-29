-- Disable window animations for instant resizing
hs.window.animationDuration = 0

-- Function to install SpoonInstall automatically
local function ensureSpoonInstall()
	local spoonPath = os.getenv("HOME") .. "/.hammerspoon/Spoons"
	local spoonInstallPath = spoonPath .. "/SpoonInstall.spoon"

	-- Ensure Spoons directory exists
	hs.execute(string.format('mkdir -p "%s"', spoonPath))

	-- Check if SpoonInstall is already installed
	if not hs.fs.attributes(spoonInstallPath) then
		print("SpoonInstall not found, downloading...")

		local zipUrl = "https://github.com/Hammerspoon/Spoons/raw/master/Spoons/SpoonInstall.spoon.zip"
		local zipPath = os.tmpname()

		-- Download the zip file
		local output, status = hs.execute(string.format('curl -L "%s" -o "%s"', zipUrl, zipPath))

		if status then
			-- Unzip to Spoons directory
			hs.execute(string.format('unzip -q "%s" -d "%s"', zipPath, spoonPath))
			os.remove(zipPath)
			print("SpoonInstall installed successfully!")
			return true
		else
			print("Failed to download SpoonInstall")
			return false
		end
	else
		print("SpoonInstall already installed")
		return true
	end
end

-- Ensure SpoonInstall is available
if ensureSpoonInstall() then
	hs.loadSpoon("SpoonInstall")
	spoon.SpoonInstall.use_syncinstall = true
	Install = spoon.SpoonInstall

	-- Install and configure EmmyLua
	Install:andUse("EmmyLua")

	-- Install and configure Seal
	Install:andUse("Seal", {
		fn = function(s)
			-- Load the apps and windows plugins
			s:loadPlugins({ "apps", "windows" })

			-- Configure the apps plugin
			s.plugins.apps.appSearchPaths = {
				"/Applications",
				"/System/Applications",
				"~/Applications",
			}
		end,
		hotkeys = {
			toggle = { { "cmd" }, "space" },
		},
		start = true,
	})

	-- Install and configure WindowHalfsAndThirds
	Install:andUse("WindowHalfsAndThirds", {
		fn = function(s)
			s:bindHotkeys(s.defaultHotkeys)
		end,
	})
end
