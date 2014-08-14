--character.lua

local dice = require 'dice'
local characterGen= {}

characterGen.buildrandom = function()
	local newCharacter = {}
	newCharacter.status = {}
	newCharacter.damage = 0
	newCharacter.numDice = {hand=0,body=0,leg=0,head=0,face=0}
	newCharacter.skills = {
		perception={attribute="head",rollMod=0},
		wits={attribute="head",rollMod=0},
		intelligence={attribute="head",rollMod=0},

		persuation={attribute="face",rollMod=0},
		deceit={attribute="face",rollMod=0},
		intimidate={attribute="face",rollMod=0},

		block={attribute="hand",rollMod= 0},
		punch={attribute="hand",rollMod=0},
		craft={attribute="hand",rollMod=0},

		dodge={attribute="legs",rollMod=0},
		kick={attribute="legs",rollMod=0},
		athletics={attribute="legs",rollMod=0},

		fitness={attribute="body",rollMod=0},
		endurance={attribute="body",rollMod=0},
		grapple={attribute="body",rollMod=0},

	}
	newCharacter.punch = function()
		rollDiceCount = ((newCharacter.numDice.hand)+(newCharacter.skills.punch.rollMod))
		local roll = dice.roll(10,rollDiceCount)
		roll = dice.keep(roll,newCharacter.numDice.hand)
		return roll
	end

	newCharacter.kick = function()
		rollDiceCount = ((newCharacter.numDice.foot)+(newCharacter.skills.kick.rollMod))
		local roll = dice.roll(10,rollDiceCount)
		roll = dice.keep(roll,newCharacter.numDice.foot)
		return roll
	end

	newCharacter.block = function()
		rollDiceCount = ((newCharacter.numDice.hand)+(newCharacter.skills.block.rollMod))
		local roll = dice.roll(10,rollDiceCount)
		roll = dice.keep(roll,newCharacter.numDice.hand)
		return roll
	end

	newCharacter.dodge = function()
		rollDiceCount = ((newCharacter.numDice.foot)+(newCharacter.skills.dodge.rollMod))
		local roll = dice.roll(10,rollDiceCount)
		roll = dice.keep(roll,newCharacter.numDice.foot)
		return roll
	end

	for i=1,5 do
		local numDice = dice.total(dice.roll(5,1))
		local dice = dice.roll(10,numDice)
		--print("rolled 5d10, sum was:", dice)

		if i == 1 then
			newCharacter.numDice.hand = numDice
		elseif i==2 then
			newCharacter.numDice.body = numDice
		elseif i==3 then
			newCharacter.numDice.leg = numDice
		elseif i==4 then
			newCharacter.numDice.head = numDice
		elseif i==5 then
			newCharacter.numDice.face = numDice
		end
	end

	return newCharacter
end

return characterGen