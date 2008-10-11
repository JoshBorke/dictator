local modName = "WhisperRelay"
local dictator = LibStub("AceAddon-3.0"):GetAddon("Dictator")
local mod = dictator:NewModule(modName, {}, "AceEvent-3.0")
local player = UnitName("player")
local replyTarget
local replyMessage

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_WHISPER")
end

function mod:OnDisable()
	self:UnregisterEvent("CHAT_MSG_WHISPER")
end

-- main addon takes care of any saved variables (what needs to be saved?)
function mod:OnInitialize()
end

-- don't cache the leader, the user might opt to change leaders
function mod:CHAT_MSG_WHISPER(message, sender, language, channelstring, target)
	-- jump out if we are the leader
	if (player == Dictator.db.leader) then return end
	if (sender == Dictator.db.leader) then
		dictator:Log(modName, "Relaying message: "..tostring(message).." to "..replyTarget)
		SendChatMessage(message, "WHISPER", nil, replyTarget)
	else
		replyTarget = sender
		dictator:Log(modName, "Relaying message: "..tostring(message).." from "..replyTarget)
		SendChatMessage(message, "WHISPER", nil, Dictator.db.leader)
	end
end
