--dice.lua

require 'math'
local dice = {}

math.randomseed(os.time())
dice.roll = function(die,count)


	local results = {}
	for i=1, count do
		--math.randomseed(os.time())
		local value = math.random(1,die)
		table.insert(results,value)
	end
	table.sort(results,function(a,b) return a > b end)
	
	return results
end

dice.total = function(values)
	local total = 0
	for i,v in ipairs(values) do
		total = total + v
	end

	return total

end

dice.keep = function(values,num)
	local results = {}
	for i=0,num-1 do
		table.insert(results,values[#values - i])
	end
	return results
end

return dice