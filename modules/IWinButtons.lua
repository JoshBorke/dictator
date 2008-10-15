local modName = "IWinButtons"
local dictator = LibStub("AceAddon-3.0"):GetAddon("Dictator")
local mod = dictator:NewModule(modName, {}, "AceEvent-3.0")
local player = UnitName("player")
local oldMaster

function mod:OnEnable()
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
end

function mod:OnDisable()
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
end

function mod:OnInitialize()
	self:UpdateLeader()
end

function mod:UpdateLeader()
	dirty = true
	if not InCombatLockdown() then
		self:PLAYER_REGEN_ENABLED()
	end
end

function mod:PLAYER_REGEN_ENABLED()
	local leader = dictator.db.leader
	if dirty then
		for macroid=1,36 do
			local name, texture, body, isLocal = GetMacroInfo(macroid)
			if body then
				local bodyText = body:gsub(oldMaster, body, leader)
				EditMacro(macroid, name, texture, body:gsub(oldMaster, leader), isLocal, macroid < 18 and 0 or 1)
			end
		end
		dirty = false
	end
end
