local modName = "FollowTheLeader"
local dictator = LibStub("AceAddon-3.0"):GetAddon("Dictator")
local mod = dictator:NewModule(modName, {}, "AceEvent-3.0", "AceComm-3.0")
local player = UnitName("player")
local db = dictator.db

function mod:OnEnable()
	self:RegisterEvent("PARTY_MEMBERS_CHANGED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("AUTOFOLLOW_END")
end

function mod:OnDisable()
	self:UnregisterEvent("PARTY_MEMBERS_CHANGED")
	self:UnregisterEvent("PLAYER_REGEN_DISABLED")
	self:UnregisterEvent("AUTOFOLLOW_END")
end

-- main addon takes care of any saved variables (what needs to be saved?)
function mod:OnInitialize()
	self:PARTY_MEMBERS_CHANGED()
end

-- don't cache the leader, the user might opt to change leaders
function mod:PLAYER_REGEN_ENABLED()
	FollowUnit(db.leader, 1)
end

function mod:AUTOFOLLOW_BEGIN(following)
	dictator:Log(modName, "Following started again")
	self:SendCommMessage("DIC", modName..": started following", "WHISPER", dictator.db.leader)
end

function mod:AUTOFOLLOW_END()
	FollowUnit(db.leader, 1)
	dictator:Log(modName, "Following stopped, trying again")
	self:SendCommMessage("DIC", modName..": stopped following", "WHISPER", dictator.db.leader)
end

function mod:OnCommReceived(prefix, message, distribution, sender)
	if (prefix == "DIC" and distribution=="WHISPER" and player == dictator.db.leader) then
		dictator:Warn(modName, sender.." stopped following")
	end
end
