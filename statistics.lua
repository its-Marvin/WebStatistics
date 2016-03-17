require "defines"

-- Time in minutes between two broadcasts
timeToNextMessage = 5

lastMessageTick = 0
ttnm=timeToNextMessage*60*60

function formattime(ticks)
  local seconds = ticks / 60
  local hours = math.floor((seconds)/60/60)
  local minutes = math.floor((seconds - 60*60*hours)/60)
  local seconds = math.floor(seconds - (60*60*hours + 60*minutes))
  return string.format("%02d:%02d:%02d", minutes, seconds)
end

script.on_event(defines.events.on_tick, function(event)
	currentTick=game.tick
	if currentTick - lastMessageTick >= ttnm then
		for index, player in pairs(game.players) do
			if player.connected then
				player.print(formattime(currentTick))
			end
		end
		lastMessageTick = currentTick
	end
end)