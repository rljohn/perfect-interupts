---@diagnostic disable: undefined-global
local addonName, addonNamespace = ...
local addon = addonNamespace.addon

-- toggles for logging
local ENABLE_OUTPUT=true
local ENABLE_DIAG=true
local ENABLE_DUMPING=true

-- LOGGING
function addon:Printf(...)
 if (not ENABLE_OUTPUT) then return end
 local status, res = pcall(format, ...)
 if status then
  self:Print(res)
  end
end

-- DIAG
function addon:Diagf(...)
	if (not ENABLE_DIAG) then return end
	local status, res = pcall(format, ...)
	if status then
	  self:Print(res)
	end
end

-- DUMP
function addon:Dump(data)
 if (not ENABLE_DUMPING) then return end
 DevTools_Dump(data)
end

-- strings

function addon:SpaceStripper(str)
	if (not str) then return str end
	return string.gsub(str, "[^%S\n]+", "")
end