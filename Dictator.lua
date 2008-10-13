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
	if (prefix == "DIC" and sender == self.db.leader) then
		local command, args = string.split(" ", message, 2)
		if (command == "newleader") then
			self.db.leader = string.split(" ", args, 2)
			self:NewLeader()
		end
	end
end

function Dictator:Log(modName, message)
end

function Dictator:Warn(modName, message)
	DEFAULT_CHAT_FRAME:AddMessage("Dictator: "..string.format("%s: %s", modName, message))
end

function Dictator:NewLeader()
	for name, module in self:IterateModules() do
		if (type(module.NewLeader) == "func") then
			module:NewLeader()
		end
	end
end
