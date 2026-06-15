local ui = {}

function ui.draw(state)
love.graphics.setColor(1, 1, 1)
love.graphics.print("Puntos: " .. state.score, 10, 10)
love.graphics.print("Vidas: " .. state.lives, 10, 30)
love.graphics.print("Bombas: " .. state.bombs, 10, 50)

local showingFocus = love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift")
if showingFocus then
    love.graphics.print("FOCO", state.W - 80, 10)
    end
    end

    function ui.drawGameOver(state)
    love.graphics.setColor(1, 0.2, 0.2)
    love.graphics.printf(
        "GAME OVER\nPuntuación: " .. state.score .. "\nPresiona R para reiniciar",
        0, state.H / 2 - 40, state.W, "center")
    end

    return ui
