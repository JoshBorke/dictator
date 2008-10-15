local Dictator = LibStub("AceAddon-3.0"):GetAddon("Dictator")

local optGetter, optSetter
do
	function optGetter(info)
		local key = info[#info] 
		return Dictator.db.profile[key]
	end
	
	function optSetter(info, value)
		local key = info[#info]
		Dictator.db.profile[key] = value
		Dictator:Refresh()
	end
end

local function IsCharacterEnabled(info, char)
	return self.db.memberList[char]
end

local function ToggleCharacterEnabled(info, char, state)
	self.db.memberList[char] = state
end

local options, moduleOptions = nil, {}
local function getOptions()
	if not options then
		options = {
			type = "group",
			name = "Dictator",
			args = {
				general = {
					order = 1,
					type = "group",
					name = "Group Makeup",
					get = optGetter,
					set = optSetter,
					args = {
						intro = {
							order = 1,
							type = "description",
							name = L["Dictator is a mod to help with multi-boxing."],
						},
						secretdesc = {
							order = 2,
							type = "description",
							name = L["Secret is a shared secret between toons so that no one can take over your slaves"],
						},
						secret = {
							order = 3,
							name = L["Secret"],
							type = "input",
						},
						setMaster = {
							type = "select",
							name = L["Set Leader"],
							desc = L["Set the master character."],
							values = self.db.memberList,
							style = "dropdown",
							order = 1,
							cmdHidden = true,
						},
					|   memberList = {
							type = "multiselect",
							name = L["Team List"],
							desc = L["Characters in your 'group'; check to enable communication with them."],
							values = self.db.memberList,
							get = IsCharacterEnabled,
							set = ToggleCharacterEnabled,
							width = "full",
							order = 2,
							cmdHidden = true,
						},
						addMemberGui = {
							type = "input",
							name = L["Add Member"],
							desc = L["Add a new member to the member list."],
							order = 3,
						},
						removeMemberGui = {
							type = "execute",
							name = L["Remove"],
							desc = L["Remove selected members from the member list."],
							func = "RemoveSelectedMembersGui",
							width = "half",
							order = 4,
						},
					},
				},
			},
		}
		for k,v in pairs(moduleOptions) do
			options.args[k] = (type(v) == "function") and v() or v
		end
	end
	
	return options
end

function Dictator:SetupOptions()
	self.optionsFrames = {}
	
	-- setup options table
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("Dictator", getOptions)
	self.optionsFrames.Dictator = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Dictator", nil, nil, "general")
	
	self:RegisterModuleOptions("Profiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db), "Profiles")
end

function Dictator:RegisterModuleOptions(name, optionTbl, displayName)
	moduleOptions[name] = optionTbl
	self.optionsFrames[name] = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Dictator", displayName, "Dictator", name)
end
