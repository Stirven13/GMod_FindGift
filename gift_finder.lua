local exceptionEntity = { "holiday_gift" }

local is_gift = true
local sound_play = true

local function has_value(table, value)
	for index, item in pairs(table) do
		if item == value then
			return true
		end
	end
	
	return false
end

local function draw_entity_exception()
	is_gift = false

	for k, v in pairs(ents.GetAll()) do
		Line = v:GetClass()
		if string.find(Line, "holiday") and not has_value(exceptionEntity, Line) then
			is_gift = true
			
			Position = v:GetPos()
			PositionScreen = Position:ToScreen()
			draw.DrawText(Line, "DefaultFixed", PositionScreen.x, PositionScreen.y, Color(255, 255, 255, 255), 1)
		end
	end
	
	if is_gift then
		draw.DrawText("Gift spawned!", "ChatFont", 5, 20, Color(255, 255, 255, 255))
		if sound_play then
			surface.PlaySound("buttons/button11.wav")
			sound_play = false
		end
	else
		draw.DrawText("no gift", "DefaultFixed", 5, 20, Color(255, 255, 255, 255))
		sound_play = true
	end

end

local function shutdown()
	print("Gift Finder was shutdown...\nType `clear` to clear console.")
	hook.Remove("HUDPaint", "FindGift", draw_entity_exception)
end

hook.Add("HUDPaint", "FindGift", draw_entity_exception)
concommand.Add( "giftoff", shutdown )
concommand.Add( "offgift", shutdown )