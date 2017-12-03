animationIndex = 1

-- Enemy death
enemyDeath = {}
enemyDeath.img = love.graphics.newImage('assets/sprites/enemy_death.png')
enemyDeath.num_frames = 7
enemyDeath.start_frame = 1
enemyDeath.frame_time = 0.05
enemyDeath.loop = false
enemyDeath.pivot = { x = 32, y = 24 }
enemyDeath.frame_width = enemyDeath.img:getWidth() / enemyDeath.num_frames
enemyDeath.frame_height = enemyDeath.img:getHeight()
enemyDeath.frames = {
    love.graphics.newQuad(enemyDeath.frame_width * 0, 0, enemyDeath.frame_width, enemyDeath.frame_height, enemyDeath.img:getWidth(), enemyDeath.img:getHeight()),
    love.graphics.newQuad(enemyDeath.frame_width * 1, 0, enemyDeath.frame_width, enemyDeath.frame_height, enemyDeath.img:getWidth(), enemyDeath.img:getHeight()),
    love.graphics.newQuad(enemyDeath.frame_width * 2, 0, enemyDeath.frame_width, enemyDeath.frame_height, enemyDeath.img:getWidth(), enemyDeath.img:getHeight()),
    love.graphics.newQuad(enemyDeath.frame_width * 3, 0, enemyDeath.frame_width, enemyDeath.frame_height, enemyDeath.img:getWidth(), enemyDeath.img:getHeight()),
    love.graphics.newQuad(enemyDeath.frame_width * 4, 0, enemyDeath.frame_width, enemyDeath.frame_height, enemyDeath.img:getWidth(), enemyDeath.img:getHeight()),
    love.graphics.newQuad(enemyDeath.frame_width * 5, 0, enemyDeath.frame_width, enemyDeath.frame_height, enemyDeath.img:getWidth(), enemyDeath.img:getHeight()),
    love.graphics.newQuad(enemyDeath.frame_width * 6, 0, enemyDeath.frame_width, enemyDeath.frame_height, enemyDeath.img:getWidth(), enemyDeath.img:getHeight()),
}
enemyDeath.animIndex = animationIndex
animationIndex = animationIndex + 1

-- Still animation table
stillAnimation = {}
table.insert(stillAnimation, enemyDeath)

function newStillAnimation(animationIndex, xPos, yPos)
    return {
        x = xPos,
        y = yPos,
        img = stillAnimation[animationIndex].img,
        num_frames = stillAnimation[animationIndex].num_frames,
        pos_frame = stillAnimation[animationIndex].start_frame,
        frame_time = stillAnimation[animationIndex].frame_time,
        loop = stillAnimation[animationIndex].loop,
        pivot = stillAnimation[animationIndex].pivot,
        frame_width = stillAnimation[animationIndex].frame_width,
        frame_height = stillAnimation[animationIndex].frame_height,
        frames = stillAnimation[animationIndex].frames,
        animationTimer = 0
    }
end
