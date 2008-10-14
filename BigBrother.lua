local modName = "BigBrother"
local dictator = LibStub("AceAddon-3.0"):GetAddon("Dictator")
local mod = dictator:NewModule(modName, {}, "AceEvent-3.0", "AceComm-3.0")
local player = UnitName("player")

function mod:OnEnable()
	self:RegisterEvent("PLAYER_XP_UPDATE")
end

function mod:OnDisable()
	self:UnregisterEvent("PLAYER_XP_UPDATE")
end

function mod:OnInitialize()
end

function mod:PLAYER_XP_UPDATE()
	local xp, maxXP = UnitXP("player"), UnitXPMax("player")
	self:SendCommMessage("DIC", ("%s: xp %d %d"):format(modName, xp, maxXP), "PARTY")
end
