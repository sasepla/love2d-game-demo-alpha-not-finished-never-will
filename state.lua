local state = {}

-- Se asignan en main.lua, pero se declaran aquí para referencia
state.W = 600
state.H = 800

function state.reset()
state.gameState = "playing"
state.score = 0
state.lives = 3
state.bombs = 3
state.invulnerableTimer = 0
state.player = {
    x = state.W / 2,
    y = state.H - 100,
    speed = 200,
    focusSpeed = 80,
    radius = 3,
    shootCooldown = 0,
    shootDelay = 0.08
}
state.playerBullets = {}
state.enemyBullets = {}
state.enemies = {}
state.bombActive = false
state.bombTimer = 0
state.enemySpawnTimer = 0
state.gameTime = 0
state.enemySpawnInterval = 1.5
end

state.reset()
return state
