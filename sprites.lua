local sprites = {}

function sprites.load(state)
state.sprites = {}  -- ← IMPORTANTE: inicializar la tabla
state.sprites.player = love.graphics.newImage("sprites/bombman.png")
state.sprites.enemy = love.graphics.newImage("sprites/Michiespacial.png")
state.sprites.player:setFilter("nearest", "nearest")
end

return sprites
