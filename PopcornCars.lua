--[[
======================================================
    PopcornCars by CoreLogic v1.0  1:43 PM 9/26/2015
======================================================
	
	Inspired by the work of 'MoMadenU'. During one of his training videos for his Native WorkBench he was testing some code and was having fun with open doors and flying cars.
	
	It reminded me of popcorn a bit, and wanted to completed the look as best I could. I find the mod fun and I hope you do too ;-)
	
	Big thanks for NoMadenU and his great Native-WorkBench mod. Check out here:https://www.gta5-mods.com/tools/native-workbench

	--------------------------------------------
	
  	This code is free to use and share, but please give credit and use in good will. (CoreLogic http://www.developer-me.com/forums/member.php?action=profile&uid=29)

	Github: https://github.com/adestefa/PopcornCars.git

	Installation:
	 1. Install Script Hook https://www.gta5-mods.com/tools/script-hook-v
	 2. Install the LUA script plugin for Scripthook https://www.gta5-mods.com/tools/lua-plugin-for-script-hook-v
	 3. Download the PopcornCars.zip file
	 4. Put the <b>PopcornCars.lua</b> file in your <install dir>\Grand Theft Auto V\scripts\addins folder.
	 5. Text will appear above the mini-map when installed correctly

 -------------------------------
 version 1.0 1:43 PM 9/26/2015
  - base version
]]--

local PopcornCars = {};
PopcornCars.settings = {};


PopcornCars.settings["height_force"] = 30;     -- higher number, the higher the cars will fly uppward


function PopcornCars.draw_text(text, x, y, scale)
	UI.SET_TEXT_FONT(0);
	UI.SET_TEXT_SCALE(scale, scale);
	UI.SET_TEXT_COLOUR(255, 255, 255, 255);
	UI.SET_TEXT_WRAP(0.0, 1.0);
	UI.SET_TEXT_CENTRE(false);
	UI.SET_TEXT_DROPSHADOW(2, 2, 0, 0, 0);
	UI.SET_TEXT_EDGE(1, 0, 0, 0, 205);
	UI._SET_TEXT_ENTRY("STRING");
	UI._ADD_TEXT_COMPONENT_STRING(text);
	UI._DRAW_TEXT(y, x);
end


function PopcornCars.tick()

	if(get_key_pressed(75)) then -- 'K'
			
		local player = PLAYER.PLAYER_PED_ID()
		local Table,Count = PED.GET_PED_NEARBY_VEHICLES(player, 1)
		local playerVehicle = PLAYER.GET_PLAYERS_LAST_VEHICLE()
		local inVehicle=PED.IS_PED_IN_VEHICLE(player,playerVehicle,true)
		local flop = 0;
		for k,v in ipairs(Table) do
			if(not inVehicle or playerVehicle ~= v) then
			    -- make it look hot
				VEHICLE.SET_VEHICLE_COLOURS(v, 33, 150);
				-- open all doors
				for i=0, 8 do
					VEHICLE.SET_VEHICLE_DOOR_OPEN(v, i, false, true);
				end
				wait(500);
				-- sound horn
				VEHICLE.START_VEHICLE_HORN(v, 200, GAMEPLAY.GET_HASH_KEY("NORMAL"),  true);
				-- open top if convertable
				if (VEHICLE.IS_VEHICLE_A_CONVERTIBLE(v, false)) then
					VEHICLE.RAISE_CONVERTIBLE_ROOF(v, true);
				end
				-- randomize the direction the cars pop in some what
				local xd = 10;
				local yd = 10;
				if (flop) then 
					xd = 10;
					yd = -10;
					flop = 0;
				else 
					xd = -10;
					yd = 10;
					flop = 1;
				end
				ENTITY.SET_ENTITY_VELOCITY(v, xd, yd, PopcornCars.settings["height_force"]);
				VEHICLE._DETACH_VEHICLE_WINDSCREEN(v);
				VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(v, 1.0);
					
				
			end
		
		end
	end	
	
	PopcornCars.draw_text("[k] Popcorn Cars v1.0 - by CoreLogic 2015", 0.8, 0.0005, 0.3);
end		


function PopcornCars.unload()

end
function PopcornCars.onload()

end

return PopcornCars;