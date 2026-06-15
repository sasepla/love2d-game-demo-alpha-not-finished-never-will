local state = require("state")
local player = require("player")
local enemy = require("enemy")
local bullets = require("bullets")
local bomb = require("bomb")
local collision = require("collision")
local ui = require("ui")
local sprites = require("sprites")

function love.load()
love.window.setMode(state.W, state.H)
love.window.setTitle("Bullet Hell Demo")
math.randomseed(os.time())
sprites.load(state)
state.reset()
end

function love.keypressed(key)
if key == "x" then
    bomb.activate(state)
    end
    if key == "r" and state.gameState == "gameover" then
        state.reset()
        end
        end

        function love.update(dt)
        if state.gameState ~= "playing" then return end
            state.gameTime = state.gameTime + dt

            player.update(dt, state)
            bomb.update(dt, state)
            enemy.update(dt, state)
            bullets.updatePlayerBullets(dt, state)
            bullets.updateEnemyBullets(dt, state)

            -- Colisiones jugador ↔ balas enemigas
            if not state.bombActive and state.invulnerableTimer <= 0 then
                for i = #state.enemyBullets, 1, -1 do
                    local b = state.enemyBullets[i]
                    if collision.circlesCollide(state.player.x, state.player.y,
                        state.player.radius, b.x, b.y, b.radius) then
                        table.remove(state.enemyBullets, i)
                        state.lives = state.lives - 1
                        state.invulnerableTimer = 2.0
                        if state.lives <= 0 then
                            state.gameState = "gameover"
                            end
                            break
                            end
                            end
                            end

                            -- Colisiones jugador ↔ enemigos (cuerpo a cuerpo)
                            if not state.bombActive and state.invulnerableTimer <= 0 then
                                for i = #state.enemies, 1, -1 do
                                    local e = state.enemies[i]
                                    if collision.circlesCollide(state.player.x, state.player.y,
                                        state.player.radius, e.x, e.y, e.radius) then
                                        state.lives = state.lives - 1
                                        state.invulnerableTimer = 2.0
                                        if state.lives <= 0 then
                                            state.gameState = "gameover"
                                            end
                                            break
                                            end
                                            end
                                            end
                                            end

                                            function love.draw()
                                            love.graphics.clear(0.05, 0.05, 0.15)

                                            if state.gameState == "playing" then
                                                player.draw(state)
                                                bullets.draw(state)
                                                enemy.draw(state)
                                                bomb.draw(state)
                                                ui.draw(state)
                                                elseif state.gameState == "gameover" then
                                                    ui.drawGameOver(state)
                                                    end
                                                    end
