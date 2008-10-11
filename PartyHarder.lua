local modName = "PartyHarder"
local dictator = LibStub("AceAddon-3.0"):GetAddon("Dictator")
local mod = dictator:NewModule(modName, {}, "AceEvent-3.0")
local player = UnitName("player")

function mod:OnEnable()
	self:RegisterEvent("PARTY_INVITE_REQUEST")
end

function mod:OnDisable()
	self:UnregisterEvent("PARTY_INVITE_REQUEST")
end

-- main addon takes care of any saved variables (what needs to be saved?)
function mod:OnInitialize()
end

-- don't cache the leader, the user might opt to change leaders
function mod:PARTY_INVITE_REQUEST(sender)
	-- jump out if we are the leader
	if (player == Dictator.db.leader) then return end
	if (sender == Dictator.db.leader) then
		AcceptGroup()
	end
end
