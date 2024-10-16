--!strict
-- @module createLogger

local fmt = require(script.fmt)
local LOG_FORMAT = "[%s] [%s] [%s] %s"

local function createLogger(key: string)
	local function logWithLevel(level: string, callback: (string) -> ())
		return function(...)
			callback(LOG_FORMAT:format(os.date("%H:%M:%S"), key, level, fmt.fmt(...)))
		end
	end

	return {
		debug = logWithLevel("DEBUG", print),
		error = logWithLevel("ERROR", print),
		info = logWithLevel("INFO", print),
		warn = logWithLevel("WARN", warn),
	}
end

return createLogger
