local modName = "LootPass"
local dictator = LibStub("AceAddon-3.0"):GetAddon("Dictator")
local mod = dictator:NewModule(modName, {}, "AceEvent-3.0")
local player = UnitName("player")

function mod:OnEnable()
end

function mod:OnDisable()
end

function mod:OnInitialize()
	if (player == dictator.db.leader) then
		SetOptOutOfLoot(false)
	else
		SetOptOutOfLoot(true)
	end
end
