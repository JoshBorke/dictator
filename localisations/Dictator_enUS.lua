local debug = false
DictatorStrings = setmetatable({
}, {__index = function(self, key)
	if debug then DEFAULT_CHAT_FRAME:AddMessage('Please localize: '..tostring(key)) end
	rawset(self, key, key)
	return key
end })
