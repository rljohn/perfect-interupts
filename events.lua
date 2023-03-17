local addonName, addonNamespace = ...
local addon = addonNamespace.addon

function addon:RegisterEvents()
  self:RegisterEvent("PLAYER_LOGIN", "OnLogin")
  self:RegisterEvent("PLAYER_LOGOUT", "OnLogout")
  self:RegisterEvent("PLAYER_REGEN_DISABLED", "OnEnterCombat")
  self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnExitCombat")
  self:RegisterEvent("PLAYER_DEAD", "OnPlayerDied")
  self:RegisterEvent("PLAYER_LEVEL_UP", "OnPlayerLevelUp")
  self:RegisterEvent("GROUP_ROSTER_UPDATE", "OnRosterChanged")
  self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED", "OnSpecializationChanged")
  self:RegisterEvent("TRAIT_CONFIG_UPDATED", "OnTraitsChanged")
end

function addon:OnLogin()
end

function addon:OnLogout()
end

function addon:OnEnterCombat()
  self:Diagf("OnEnterCombat")
  self.state.in_combat = true
end

function addon:OnExitCombat()
  self:Diagf("OnExitCombat")
  self.state.in_combat = false
end

function addon:OnPlayerDied()
  self:Diagf("OnPlayerDied")
end

function addon:OnRosterChanged()
  self:Diagf("OnRosterChanged")
  self:UpdateGroupState()
end

function addon:OnPlayerLevelUp()
  self:Diagf("OnPlayerLevelUp")
  self:UpdatePlayerLevel()
end

function addon:OnSpecializationChanged()
  self:Diagf("OnSpecializationChanged")
  self:UpdateTalentSpec()
end

function addon:OnTraitsChanged()
  self:Diagf("OnTraitsChanged")
  self:UpdateTalentSpec()
end

function addon:UpdatePlayerLevel()
  self.state.player_level = UnitLevel("player")
end

function addon:UpdateGroupState()
  self.state.in_party = IsInGroup()
  self.state.in_raid = IsInRaid()
  self.state.solo = not (self.state.in_party or self.state.in_raid)
end

function addon:UpdateTalentSpec()
  local currentSpec = GetSpecialization()
	local id, name, description, icon, role, primaryStat = GetSpecializationInfo(currentSpec)
  self.state.player_spec = id
end