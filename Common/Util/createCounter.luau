local function createCounter(): () -> number
	local counter = 0
	
	return function()
		counter += 1
		return counter
	end
end

return createCounter
