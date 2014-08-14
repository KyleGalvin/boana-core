--combat.lua
local combat = {}

local clock = os.clock
function sleep(n)  -- seconds
  local t0 = clock()
  while clock() - t0 <= n do end
end

-- Print anything - including nested tables
function table_print(tt, indent, done)
  done = done or {}
  indent = indent or 0
  if type(tt) == "table" then
    for key, value in pairs (tt) do
      io.write(string.rep (" ", indent)) -- indent it
      if type (value) == "table" and not done [value] then
        done [value] = true
        io.write(string.format("[%s] => table\n", tostring (key)));
        io.write(string.rep (" ", indent+4)) -- indent it
        io.write("(\n");
        table_print (value, indent + 7, done)
        io.write(string.rep (" ", indent+4)) -- indent it
        io.write(")\n");
      else
        io.write(string.format("[%s] => %s\n",
            tostring (key), tostring(value)))
      end
    end
  else
    io.write(tt .. "\n")
  end
end

combat.encounter = function(character1,action1,character2,action2)

	if character2.status["dead"] == true then
		print("OH GOD WHY ARE YOU MUTILATING HIM?!")
	end

	local attackerRoll = character1[action1]()
	local defenderRoll = character2[action2]()
	print("Attack Roll:")
	table_print(attackerRoll)
	print("Defend Roll:")
	table_print(defenderRoll)

	local minRoll = math.min(#attackerRoll,#defenderRoll)
	local hit=0

	for i=0,minRoll-1 do
		local attack = attackerRoll[#attackerRoll-i]
		local defense = defenderRoll[#defenderRoll-i]
		if attack > defense then
			hit = hit +1
		end
	end

	--attackers extra dice carry over to deal damage
	if #attackerRoll > #defenderRoll then
		local carryOver = #attackerRoll - #defenderRoll
		local attribute = character1.skills[action1].attribute
		--print("major attribute:",attribute)
		local attributeStat = character1.numDice[attribute]
		--print("attribute value: ",attributeStat)
		for i=1, carryOver do
			if attackerRoll[i] > (10-attributeStat) then
				hit = hit + 1
			end
		end
	end

	local maxHitpoints = character2.numDice.body + character2.skills.endurance.rollMod
	print("damage dealt:",hit)
	character2.damage = character2.damage + hit
	print("HP: ".. maxHitpoints - character2.damage.." of "..maxHitpoints)	
	

	if character2.damage >= maxHitpoints + character2.numDice.body then
		print("Defender is dead!")
		character2.status["dead"] = true
	elseif character2.damage >= maxHitpoints then
		print("Defender is disabled!")
		character2.status["disabled"] = true
	end



end

return combat