
local addonName, addonNamespace = ...
local addon = addonNamespace.addon
local addonTitle = select(2, GetAddOnInfo(addonName))

local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")

-- create the configuration interface
function addon:CreateConfig()
  -- create the top level config
	local config = CreateFrame('FRAME', addonTitle .. 'Config', InterfaceOptionsFramePanelContainer)
	config.name = addonTitle
  InterfaceOptions_AddCategory(config)
	self.ui.config = config

  -- create child panels
  self:CreateConfigPanels()
end

-- open the options frame to our panel
function addon:ShowConfig()
	InterfaceOptionsFrame_OpenToCategory(addon.ui.config)
end

-- create a minimap icon
function addon:CreateMinimapIcon()

  -- minimap config
  local miniButton = LibStub("LibDataBroker-1.1"):NewDataObject("PIAddon",
	{
		type = "data source",
		text = addonTitle,
		icon = "132219", -- kick icon
		OnClick = function(self, btn)
			addon:ShowConfig()
		end,
		OnTooltipShow = function(tooltip)
			if not tooltip or not tooltip.AddLine then return end
			tooltip:AddLine(addonTitle)
		end,
		
	})
		
  -- create minimap
	self.ui.MinimapIcon = LibStub("LibDBIcon-1.0", true)
	self.ui.MinimapIcon:Register(addonName, miniButton, self.db.global.minimap)
	self:MinimapUpdate()
end

function addon:MinimapUpdate()
	if (not self.ui.MinimapIcon) then return end
end