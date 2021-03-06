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

-- Fireboy blast
fireBlast = {}
fireBlast.img = love.graphics.newImage('assets/sprites/blast.png')
fireBlast.num_frames = 11
fireBlast.start_frame = 1
fireBlast.frame_time = 0.02
fireBlast.loop = false
fireBlast.pivot = { x = 100, y = 62 }
fireBlast.frame_width = fireBlast.img:getWidth() / fireBlast.num_frames
fireBlast.frame_height = fireBlast.img:getHeight()
fireBlast.frames = {
    love.graphics.newQuad(fireBlast.frame_width * 0, 0, fireBlast.frame_width, fireBlast.frame_height, fireBlast.img:getWidth(), fireBlast.img:getHeight()),
    love.graphics.newQuad(fireBlast.frame_width * 1, 0, fireBlast.frame_width, fireBlast.frame_height, fireBlast.img:getWidth(), fireBlast.img:getHeight()),
    love.graphics.newQuad(fireBlast.frame_width * 2, 0, fireBlast.frame_width, fireBlast.frame_height, fireBlast.img:getWidth(), fireBlast.img:getHeight()),
    love.graphics.newQuad(fireBlast.frame_width * 3, 0, fireBlast.frame_width, fireBlast.frame_height, fireBlast.img:getWidth(), fireBlast.img:getHeight()),
    love.graphics.newQuad(fireBlast.frame_width * 4, 0, fireBlast.frame_width, fireBlast.frame_height, fireBlast.img:getWidth(), fireBlast.img:getHeight()),
    love.graphics.newQuad(fireBlast.frame_width * 5, 0, fireBlast.frame_width, fireBlast.frame_height, fireBlast.img:getWidth(), fireBlast.img:getHeight()),
    love.graphics.newQuad(fireBlast.frame_width * 6, 0, fireBlast.frame_width, fireBlast.frame_height, fireBlast.img:getWidth(), fireBlast.img:getHeight()),
    love.graphics.newQuad(fireBlast.frame_width * 7, 0, fireBlast.frame_width, fireBlast.frame_height, fireBlast.img:getWidth(), fireBlast.img:getHeight()),
    love.graphics.newQuad(fireBlast.frame_width * 8, 0, fireBlast.frame_width, fireBlast.frame_height, fireBlast.img:getWidth(), fireBlast.img:getHeight()),
    love.graphics.newQuad(fireBlast.frame_width * 9, 0, fireBlast.frame_width, fireBlast.frame_height, fireBlast.img:getWidth(), fireBlast.img:getHeight()),
    love.graphics.newQuad(fireBlast.frame_width * 10, 0, fireBlast.frame_width, fireBlast.frame_height, fireBlast.img:getWidth(), fireBlast.img:getHeight()),
}
fireBlast.animIndex = animationIndex
animationIndex = animationIndex + 1

-- Fireboy death
fireboyDeath = {}
fireboyDeath.img = love.graphics.newImage('assets/sprites/fireboy_death.png')
fireboyDeath.num_frames = 8
fireboyDeath.start_frame = 1
fireboyDeath.frame_time = 0.05
fireboyDeath.loop = false
fireboyDeath.frame_width = fireboyDeath.img:getWidth() / fireboyDeath.num_frames
fireboyDeath.frame_height = fireboyDeath.img:getHeight()
fireboyDeath.pivot = { x = fireboyDeath.frame_width/2, y = fireboyDeath.frame_height }
fireboyDeath.frames = {
    love.graphics.newQuad(fireboyDeath.frame_width * 0, 0, fireboyDeath.frame_width, fireboyDeath.frame_height, fireboyDeath.img:getWidth(), fireboyDeath.img:getHeight()),
    love.graphics.newQuad(fireboyDeath.frame_width * 1, 0, fireboyDeath.frame_width, fireboyDeath.frame_height, fireboyDeath.img:getWidth(), fireboyDeath.img:getHeight()),
    love.graphics.newQuad(fireboyDeath.frame_width * 2, 0, fireboyDeath.frame_width, fireboyDeath.frame_height, fireboyDeath.img:getWidth(), fireboyDeath.img:getHeight()),
    love.graphics.newQuad(fireboyDeath.frame_width * 3, 0, fireboyDeath.frame_width, fireboyDeath.frame_height, fireboyDeath.img:getWidth(), fireboyDeath.img:getHeight()),
    love.graphics.newQuad(fireboyDeath.frame_width * 4, 0, fireboyDeath.frame_width, fireboyDeath.frame_height, fireboyDeath.img:getWidth(), fireboyDeath.img:getHeight()),
    love.graphics.newQuad(fireboyDeath.frame_width * 5, 0, fireboyDeath.frame_width, fireboyDeath.frame_height, fireboyDeath.img:getWidth(), fireboyDeath.img:getHeight()),
    love.graphics.newQuad(fireboyDeath.frame_width * 6, 0, fireboyDeath.frame_width, fireboyDeath.frame_height, fireboyDeath.img:getWidth(), fireboyDeath.img:getHeight()),
    love.graphics.newQuad(fireboyDeath.frame_width * 7, 0, fireboyDeath.frame_width, fireboyDeath.frame_height, fireboyDeath.img:getWidth(), fireboyDeath.img:getHeight()),
}
fireboyDeath.animIndex = animationIndex
animationIndex = animationIndex + 1

-- Still animation table
stillAnimation = {}
table.insert(stillAnimation, enemyDeath)
table.insert(stillAnimation, fireBlast)
table.insert(stillAnimation, fireboyDeath)

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
