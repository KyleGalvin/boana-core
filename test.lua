local dice = require 'dice'
local characterGen = require 'character'
local combat = require 'combat'



local sdl = require 'SDL2'

-- Print anything - including nested tables
function table_print (tt, indent, done)
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


local character = characterGen.buildrandom()
print("p1 arm:")
table_print(character.numDice.hand)
print("p1 body:")
table_print(character.numDice.body)
print("p1 head:")
table_print(character.numDice.head)
print("p1 leg:")
table_print(character.numDice.leg)
print("")
local character2 = characterGen.buildrandom()

print("p2 arm:")
table_print(character2.numDice.hand)
print("p2 body:")
table_print(character2.numDice.body)
print("p2 head:")
table_print(character2.numDice.head)
print("p2 leg:")
table_print(character2.numDice.leg)

while true do
  combat.encounter(character,"punch",character2,"block")
  sleep(1)
end


local hit = character.punch()


