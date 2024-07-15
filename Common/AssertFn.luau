--!strict
--@module AssertFn

local function AssertFn<T>(condition: T, messageGenerator: () -> string): T
	if not condition then
		error(messageGenerator(), 2)
	end
	return condition
end

return AssertFn
