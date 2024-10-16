--[=[
	Utility for Roblox character objects that involve promises.
	@class CharacterUtils
]=]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Promise = require(ReplicatedStorage.Packages.Promise)
local Trove = require(ReplicatedStorage.Packages.Trove)

local PromiseTypes = require(ReplicatedStorage.Game.PromiseTypes)

local CharacterUtils = {}

--[=[
	Returns a promise that will resolve once a character exists.

	@param player Player
	@return Promise<Model>
]=]
function CharacterUtils.promiseCharacter(player: Player): PromiseTypes.TypedPromise<Model>
	local trove = Trove.new()
	
	local promise: PromiseTypes.Promise = Promise.new(function (resolve, reject)
		if player.Character then
			return resolve(player.Character)
		end
		
		trove:Connect(player.CharacterAdded, function(character: Model)
			return resolve(character)
		end)
	end)
	
	promise:finally(function ()
		trove:Destroy()
	end)
	
	return promise
end

return CharacterUtils
