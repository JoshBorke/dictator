local modules = {}
Dictator = LibStub("AceAddon-3.0"):NewAddon("Dictator", "AceConsole-3.0", "AceEvent-3.0", "AceComm-3.0")

function Dictator:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("DictatorDB")
end

function Dictator:OnEnable()
	self:RegisterComm("DIC")
end

function Dictator:OnDisable()
end

function Dictator:OnCommReceived(prefix, message, distribution, sender)
end
