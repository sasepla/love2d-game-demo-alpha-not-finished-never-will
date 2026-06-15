local enemy = {}
local collision = require("collision")

function enemy.spawn(state)
local e = {
    x = math.random(40, state.W - 40),
    y = -20,
    speed = 80 + math.random(0, 40),
    radius = 12,
    hp = 2,
    shootTimer = 0,
    shootInterval = 1.2,
    pattern = math.random(1, 2)   -- 1: apuntado, 2: circular
}
table.insert(state.enemies, e)
end

local function enemyShoot(e, state)
if e.pattern == 1 then
    local angle = math.atan2((state.player.y - e.y), (state.player.x - e.x))
    local speed = 250
    table.insert(state.enemyBullets, {
        x = e.x, y = e.y,
        vx = math.cos(angle) * speed,
                 vy = math.sin(angle) * speed,
                 radius = 4,
                 color = {1, 0.2, 0.2}
    })
    else
        local numBullets = 8
        local baseAngle = math.atan2((state.player.y - e.y), (state.player.x - e.x))
        local spread = math.pi / 3
        for i = 0, numBullets - 1 do
            local angle = baseAngle - spread/2 + (spread / (numBullets - 1)) * i
            local speed = 180
            table.insert(state.enemyBullets, {
                x = e.x, y = e.y,
                vx = math.cos(angle) * speed,
                         vy = math.sin(angle) * speed,
                         radius = 4,
                         color = {1, 0.5, 0}
            })
            end
            end
            end

            function enemy.update(dt, state)
            -- Spawn dinámico
            state.enemySpawnTimer = state.enemySpawnTimer + dt
            local currentInterval = math.max(0.4, state.enemySpawnInterval - state.gameTime * 0.02)
            if state.enemySpawnTimer >= currentInterval then
                state.enemySpawnTimer = state.enemySpawnTimer - currentInterval
                enemy.spawn(state)
                end

                -- Actualizar enemigos vivos
                for i = #state.enemies, 1, -1 do
                    local e = state.enemies[i]
                    e.y = e.y + e.speed * dt
                    if e.y > state.H + 50 then
                        table.remove(state.enemies, i)
                        else
                            -- Disparo enemigo
                            e.shootTimer = e.shootTimer + dt
                            if e.shootTimer >= e.shootInterval and not state.bombActive then
                                e.shootTimer = 0
                                enemyShoot(e, state)
                                end

                                -- Colisión con balas del jugador
                                for j = #state.playerBullets, 1, -1 do
                                    local b = state.playerBullets[j]
                                    if collision.circlesCollide(b.x, b.y, b.radius, e.x, e.y, e.radius) then
                                        table.remove(state.playerBullets, j)
                                        e.hp = e.hp - 1
                                        if e.hp <= 0 then
                                            state.score = state.score + 100
                                            table.remove(state.enemies, i)
                                            break
                                            end
                                            end
                                            end
                                            end
                                            end
                                            end

                                            function enemy.draw(state)
                                            for _, e in ipairs(state.enemies) do
                                                local sprite = state.sprites.enemy
                                                local ox = sprite:getWidth() / 2
                                                local oy = sprite:getHeight() / 2
                                                love.graphics.draw(sprite, e.x, e.y, 0, 1, 1, ox, oy)
                                                end
                                                end

                                                return enemy
