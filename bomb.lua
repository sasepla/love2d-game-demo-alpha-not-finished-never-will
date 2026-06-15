local bomb = {}

function bomb.activate(state)
if state.bombs > 0 and not state.bombActive and state.gameState == "playing" then
    state.bombs = state.bombs - 1
    state.bombActive = true
    state.bombTimer = 0.5
    state.enemyBullets = {}               -- limpia todas las balas enemigas
    for _, e in ipairs(state.enemies) do
        e.hp = 0                          -- destruye todos los enemigos
        end
        end
        end

        function bomb.update(dt, state)
        if state.bombActive then
            state.bombTimer = state.bombTimer - dt
            if state.bombTimer <= 0 then
                state.bombActive = false
                state.bombTimer = 0
                end
                end
                end

                function bomb.draw(state)
                if state.bombActive then
                    love.graphics.setColor(1, 0.8, 0, 0.3 + state.bombTimer * 0.5)
                    love.graphics.circle("fill", state.player.x, state.player.y,
                                         150 * (1 - state.bombTimer / 0.5))
                    end
                    end

                    return bomb
