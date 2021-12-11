
local speed = 50.0        

local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }

local autopilotActive = false
local blipX = 0.0
local blipY = 0.0
local blipZ = 0.0
RegisterNetEvent("skillman_autopilot:main")
AddEventHandler("skillman_autopilot:main", function(source)
if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), false), GetHashKey("masina1")) or -- IN LOC DE "masina1" ITI PUI CODUL DE LA MASINA PE CARE VREI AUTOPILOT
   IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), false), GetHashKey("masina2")) or -- IN LOC DE "masina2" ITI PUI CODUL DE LA A DOUA MASINA PE CARE VREI AUTOPILOT
   IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), false), GetHashKey("masina3")) then -- IN LOC DE "masina3" ITI PUI CODUL DE LA A TREIA MASINA PE CARE VREI AUTOPILOT
	if autopilotActive then
			local players = GetPlayerPed(-1)
			local vehicles = GetVehiclePedIsIn(players,false)
			local coordss = GetEntityCoords(players)
		TaskVehicleDriveToCoordLongrange(players, vehicles, coordss.x, coordss.y, coordss.z, speed, 447, 2.0)
		ShowNotification("~p~[~w~AutoPilot~p~]~w~ Oprit")
			autopilotActive = false
	else 
	  local player = GetPlayerPed(-1)
	  local vehicle = GetVehiclePedIsIn(player,false)
	  local model = GetEntityModel(vehicle)
	  local displaytext = GetDisplayNameFromVehicleModel(model)
	  local blip = GetFirstBlipInfoId(8)
	  if (blip ~= nil and blip ~= 0) then
		  ShowNotification("~p~[~w~AutoPilot~p~]~w~ Pornit")
		  local coord = GetBlipCoords(blip)
		  blipX = coord.x
		  blipY = coord.y
		  blipZ = coord.z
		  autopilotActive = true
		  TaskVehicleDriveToCoordLongrange(player, vehicle, blipX, blipY, blipZ, speed, 447, 2.0)

	  else
		  ShowNotification("~p~[~w~AutoPilot~p~]~w~ Nu ai setat niciun punct pe GPS")
	  end
	end
else
    ShowNotification("~p~[~w~AutoPilot~p~]~w~ Acest autovehicul nu are autopilot!")
end
end)


function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(true, false)
end

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(200)
      if autopilotActive then
           local coords = GetEntityCoords(GetPlayerPed(-1))
           local blip = GetFirstBlipInfoId(8)
           local dist = Vdist(coords.x, coords.y, coords.z, blipX, blipY, coords.z)
           if dist <= 25 then
              local player = GetPlayerPed(-1)
              local vehicle = GetVehiclePedIsIn(player,false)
              ClearPedTasks(player)
              SetVehicleForwardSpeed(vehicle,19.0)
              Citizen.Wait(200)
              SetVehicleForwardSpeed(vehicle,15.0)
              Citizen.Wait(200)
              SetVehicleForwardSpeed(vehicle,11.0)
              Citizen.Wait(200)
              SetVehicleForwardSpeed(vehicle,6.0)
              Citizen.Wait(200)
              SetVehicleForwardSpeed(vehicle,0.0)
              ShowNotification("~p~[~w~AutoPilot~p~]~w~ Ai ajuns la destinatie!")
              autopilotActive = false
           end
           

      end
    end
end)