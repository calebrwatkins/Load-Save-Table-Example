-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local json = require("json")


-- This is the data we want to save, all in a table.
local userData = {
	userName = "Jill",
	level = 2,
	volume = 70,
	topScores = { 300, 500, 600 },
}

-- Just for curiosity, see what the JSON format looks like.
local str = json.encode(userData)
print(str)

-- Getting from JSON string to table data is easy too.
local t = json.decode(str)
print(t.userName, t.level, t.volume, t.topScores[2])


-- Save the string str to a data file with the given path name. 
-- Return true if successful, false if failure.
function writeDataFile(str, pathName)
	local file = io.open(pathName, "w")
	if file then
		file:write(str)
		io.close(file)
		print("Saved to: " .. pathName)
		return true
	end
	return false
end

-- Load the contents of a data file with the given path name.
-- Return the contents as a string or nil if failure (e.g. file does not exist).
function readDataFile(pathName)
	local str = nil
	local file = io.open(pathName, "r")
	if file then
		str = file:read("*a")  -- read entire file as a single string
		io.close(file)
		if str then
			print("Loaded from: " .. pathName)
		end
	end
	return str
end

-- Demo of saving a table to a file
function saveTable()
	local path = system.pathForFile( "userSettings.txt", system.DocumentsDirectory )
	local str = json.encode(userData)
	writeDataFile(str, path)
end

-- Demo of loading a table from a file
function loadTable()
	-- Read the data file and restore the table from it
	local path = system.pathForFile( "userSettings.txt", system.DocumentsDirectory )
	str = readDataFile(path)
	local loadedTable = json.decode(str)
	print(loadedTable.userName)  -- should be "Jill"
end

-- Save the table then load it back again
saveTable()
loadTable()