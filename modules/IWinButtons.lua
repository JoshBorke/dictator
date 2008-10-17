local modName = "IWinButtons"
local dictator = LibStub("AceAddon-3.0"):GetAddon("Dictator")
local mod = dictator:NewModule(modName, {}, "AceEvent-3.0")
local player = UnitName("player")
local oldMaster

local db
local defaults = { profile = {} }

local optGetter, optSetter
do
	local mod = Coords
	function optGetter(info)
		local key = info[#info]
		return db[key]
	end

	function optSetter(info, value)
		local key = info[#info]
		db[key] = value
		mod:Refresh()
	end
end

local options
local function getOptions()
	if not options then
		options = {
			type = "group",
			name = L["IWinButtons"],
			arg = modName,
			get = optGetter,
			set = optSetter,
			args = {
				intro = {
					order = 1,
					type = "description",
					name = L["A module to maintain a set of macros across all toons"],
				},
				enabled = {
					order = 2,
					type = "toggle",
					name = L["Enable IWinButtons"],
					get = function() return dictator:GetModuleEnabled(modName) end,
					set = function(info, value) dictator:SetModuleEnabled(modName, value) end,
				},
			},
		}
	end
	
	return options
end

function mod:OnEnable()
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
end

function mod:OnDisable()
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
end

function mod:OnInitialize()
	self:UpdateLeader()
	self.db = dictator.db:RegisterNamespace(modName, defaults)
	
	self:Refresh()
	
	self:SetEnabledState(dictator:GetModuleEnabled(modName))
	dictator:RegisterModuleOptions(modName, getOptions, L["Coordinates"])
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
