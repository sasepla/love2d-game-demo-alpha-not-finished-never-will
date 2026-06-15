local bullets = {}

function bullets.updatePlayerBullets(dt, state)
for i = #state.playerBullets, 1, -1 do
    local b = state.playerBullets[i]
    b.y = b.y - b.speed * dt
    if b.y < -10 then
        table.remove(state.playerBullets, i)
        end
        end
        end

        function bullets.updateEnemyBullets(dt, state)
        if state.bombActive then return end
            for i = #state.enemyBullets, 1, -1 do
                local b = state.enemyBullets[i]
                b.x = b.x + b.vx * dt
                b.y = b.y + b.vy * dt
                if b.x < -20 or b.x > state.W + 20 or b.y < -20 or b.y > state.H + 20 then
                    table.remove(state.enemyBullets, i)
                    end
                    end
                    end

                    function bullets.draw(state)
                    -- Balas del jugador
                    love.graphics.setColor(0.4, 0.8, 1)
                    for _, b in ipairs(state.playerBullets) do
                        love.graphics.circle("fill", b.x, b.y, b.radius)
                        end

                        -- Balas enemigas
                        for _, b in ipairs(state.enemyBullets) do
                            love.graphics.setColor(b.color)
                            love.graphics.circle("fill", b.x, b.y, b.radius)
                            love.graphics.setColor(1, 1, 1, 0.6)
                            love.graphics.circle("fill", b.x, b.y, b.radius * 0.5)
                            end
                            love.graphics.setColor(1, 1, 1)
                            end

                            return bullets
