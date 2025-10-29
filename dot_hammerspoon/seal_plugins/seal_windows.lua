--- === Seal.plugins.windows ===
---
--- A plugin to search and switch to open windows
local obj = {}
obj.__index = obj
obj.__name = "seal_windows"

function obj:commands()
   return {}
end

function obj:bare()
   return self.choicesWindows
end

function obj.choicesWindows(query)
   local choices = {}
   if query == nil or query == "" then
      return choices
   end

   -- Get all windows from all spaces
   local windows = hs.window.allWindows()

   for _, win in ipairs(windows) do
      if win:isStandard() and win:isVisible() then
         local app = win:application()
         local title = win:title()
         local appName = app:name()
         local searchText = (title .. " " .. appName):lower()

         -- Match against query
         if string.match(searchText, query:lower()) then
            local choice = {}
            choice["text"] = title
            choice["subText"] = appName
            choice["image"] = hs.image.imageFromAppBundle(app:bundleID())
            choice["uuid"] = obj.__name.."__"..win:id()
            choice["plugin"] = obj.__name
            choice["type"] = "focusWindow"
            choice["windowID"] = win:id()
            table.insert(choices, choice)
         end
      end
   end

   return choices
end

function obj.completionCallback(rowInfo)
   if rowInfo["type"] == "focusWindow" then
      local win = hs.window.get(rowInfo["windowID"])
      if win then
         win:focus()
      end
   end
end

return obj
