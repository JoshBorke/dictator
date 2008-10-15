local modName = "Looter"
local dictator = LibStub("AceAddon-3.0"):GetAddon("Dictator")
local mod = dictator:NewModule(modName, {}, "AceEvent-3.0")
local player = UnitName("player")

function mod:OnEnable()
	self:RegisterEvent("PARTY_MEMBERS_CHANGED")
end

function mod:OnDisable()
	self:UnregisterEvent("PARTY_MEMBERS_CHANGED")
end

function mod:OnInitialize()
	self:UpdateLeader()
end

function mod:UpdateLeader()
	if (IsPartyLeader()) then
		SetLootMethod("master", dictator.db.leader)
	end
end

function mod:PARTY_MEMBERS_CHANGED()
	for i=1,GetNumPartyMembers() do
		if (UnitName("party"..i) == dictator.db.leader) then
			self:UpdateLeader()
		end
	end
end
