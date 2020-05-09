--Devious TACAN workaround script by Pikey 09 1500Z MAY 2020

--WHY?
--The Portable TACAN model in DCS cannot have the task "Activate TACAN". There is no way to use scripting to add a Beacon because that type is not accepting the Task Activate Tacan. 
--Only Ships and aircraft accept a TACAN task and you can't put them where you like. You could mod, but...
--For reasons of extreme workaround the TACAN is A-A mode ONLY. There is no other way, but you get your distance and bearing anyway.
--HOW TO
--Requires a reasonably up to date MOOSE.lua version https://github.com/FlightControl-Master/MOOSE_INCLUDE/blob/develop/Moose_Include_Static/Moose.lua
--Put a Harrier where you want a TACAN, set it LATE ACTIVATED, and make it start from Ground so it is on the floor. Call it's UNIT/PILOT name a three letter code for the TACAN
--Repeat for every new TACAN you want - e.g. 'PT1', 'PT2', 'PT3' etc
--Fill out the table "HarrierList" below, with all these Harrier unit names, they become the TACAN MORSE NAME
--Create a Portable Tacan unit model and call its UNIT 'tacanPortable', set this to "LATE ACTIVATED" 
--Load MOOSE.lua on mission start
--Put this script in DO SCRIPT or have it as part of an existing script
--Tune to your tacan, remembering A-A mode is required
--MP compatible. Any issues, make sure you READ YOUR DCS.log for errors, which will most likely be a naming issue siunce Lua is case sensitive

--EDITABLE
local tacanStartNumber = 50 --you need to work out Tacan channel conflicts yourself, the beacons start from this number and go up
local HarrierList = {'PT1', 'PT2', 'PT3' } --add the UNIT/PILOT NAME of the Harrier aircraft to this list. They will become the Tacan Morse names so keep it 3 letters
local tacanPortable = UNIT:FindByName('tacanPortable') -- This is the UNIT name of your single Late Activated Tacan object. You can change this here if you really find a need to.

--NOT EDITABLE
for i=1,#(HarrierList) do
local imposterUnit = UNIT:FindByName(HarrierList[i])
local position = imposterUnit:GetVec2() -- Gets the position of the invisible Harrier
local myBeacon = imposterUnit:GetBeacon() -- Creates the beacon
myBeacon:AATACAN(tacanStartNumber+i-1, imposterUnit:GetName(), true) -- Activate the beacon
SPAWN:NewWithAlias(tacanPortable:GetName(), imposterUnit:GetName()):SpawnFromVec2(position) -- Places a Portable Tacan model where the invisible Harrier is
end
