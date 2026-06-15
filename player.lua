local player = {}

function player.update(dt, state)
local p = state.player
if state.gameState ~= "playing" then return end

    -- Velocidad según modo foco
    local speed = p.speed
    if love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") then
        speed = p.focusSpeed
        end

        -- Dirección de movimiento
        local dx, dy = 0, 0
        if love.keyboard.isDown("left") or love.keyboard.isDown("a") then dx = -1 end
            if love.keyboard.isDown("right") or love.keyboard.isDown("d") then dx = dx + 1 end
                if love.keyboard.isDown("up") or love.keyboard.isDown("w") then dy = -1 end
                    if love.keyboard.isDown("down") or love.keyboard.isDown("s") then dy = dy + 1 end

                        if dx ~= 0 or dy ~= 0 then
                            local len = math.sqrt(dx*dx + dy*dy)
                            dx, dy = dx/len, dy/len
                            p.x = p.x + dx * speed * dt
                            p.y = p.y + dy * speed * dt
                            end

                            -- Limitar a la pantalla
                            p.x = math.max(p.radius, math.min(state.W - p.radius, p.x))
                            p.y = math.max(p.radius, math.min(state.H - p.radius, p.y))

                            -- Temporizador de invulnerabilidad
                            if state.invulnerableTimer > 0 then
                                state.invulnerableTimer = state.invulnerableTimer - dt
                                end

                                -- Disparo
                                player.shoot(dt, state)
                                end

                                function player.shoot(dt, state)
                                local p = state.player
                                if p.shootCooldown > 0 then
                                    p.shootCooldown = p.shootCooldown - dt
                                    return
                                    end
                                    if love.keyboard.isDown("z") or love.keyboard.isDown("space") then
                                        table.insert(state.playerBullets, {
                                            x = p.x - 5,
                                            y = p.y - 10,
                                            speed = 400,
                                            radius = 2
                                        })
                                        table.insert(state.playerBullets, {
                                            x = p.x + 5,
                                            y = p.y - 10,
                                            speed = 400,
                                            radius = 2
                                        })
                                        p.shootCooldown = p.shootDelay
                                        end
                                        end

                                        function player.draw(state)
                                        local p = state.player
                                        local showingFocus = love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift")

                                        -- Hitbox en modo foco
                                        if showingFocus then
                                            love.graphics.setColor(1, 0.2, 0.2, 0.5)
                                            love.graphics.circle("fill", p.x, p.y, p.radius)
                                            end

                                            -- Parpadeo durante invulnerabilidad
                                            if state.invulnerableTimer > 0 and math.floor(state.invulnerableTimer * 10) % 2 == 0 then
                                                love.graphics.setColor(1, 1, 1, 0.4)
                                                else
                                                    love.graphics.setColor(1, 1, 1)
                                                    end

                                                    local sprite = state.sprites.player
                                                    local ox = sprite:getWidth() / 2
                                                    local oy = sprite:getHeight() / 2
                                                    love.graphics.draw(sprite, p.x, p.y, 0, 1, 1, ox, oy)
                                                    love.graphics.setColor(1, 1, 1)
                                                    end

                                                    return player
