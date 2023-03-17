local addonName, addonNamespace = ...
local addonTitle = select(2, GetAddOnInfo(addonName))

-- create the AceAddon
local addon = LibStub("AceAddon-3.0"):NewAddon("PerfectInterrupts", "AceConsole-3.0", "AceEvent-3.0")
addonNamespace.addon = addon

-- setup some globals for session state
addon.ui = {}
addon.state = {}

-- database - default settings
local defaults =
{
  global = {
    minimap = {}
  },
  profile = {
  }
}

-- called once when the addon is Loaded
function addon:OnInitialize()
  self.db = LibStub("AceDB-3.0"):New("PerfectInterruptsDB", defaults, true)
  self:LoadPlayerInfo()
  self:RegisterEvents()
  self.state.initialized = true
end

-- called one when the addon is enabled (after player login)
function addon:OnEnable()
  self:Diagf("OnEnable")
  self:RegisterSlashCommands()
  self:UpdateGroupState()
  self:UpdateTalentSpec()
  self:CreateConfig()
  self:CreateMinimapIcon()
  self.state.initialized = true
end

-- load player data
function addon:LoadPlayerInfo()

  -- static player data
  self.state.player_name = UnitName("player")
  self.state.player_realm = self:SpaceStripper(GetNormalizedRealmName())
  self.state.player_guid = UnitGUID("player")
  self.state.player_name_realm = string.format("%s-%s", self.state.player_name, self.state.player_realm)

  -- dynamic player info
  self:UpdatePlayerLevel()
end

-- register the /perfect command
function addon:RegisterSlashCommands()
  self:RegisterChatCommand("perfect", "OnSlashCommand")
end

-- handler for /perfect
function addon:OnSlashCommand(input)
  if (input == "config") then
    self:ShowConfig()
  else
    self:PrintHelp()
  end
end

-- help for /perfect
function addon:PrintHelp()
	addon:Print('Perfect Interrupt Commands:')
  print(' /perfect config - Open the Options menu')
end

