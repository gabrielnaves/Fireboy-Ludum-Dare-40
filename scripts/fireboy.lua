fireboy = {}

-- Movement data
fireboy.x = 180
fireboy.y = 608
fireboy.movSpeed = 10
fireboy.jumpSpeed = 25

-- Image data
fireboy.img = love.graphics.newImage('assets/sprites/fireboy.png')
fireboy.num_frames = 5
fireboy.pos_frame = 1
fireboy.frame_width = fireboy.img:getWidth() / fireboy.num_frames
fireboy.frame_height = fireboy.img:getHeight()
fireboy.frames = {
    love.graphics.newQuad(fireboy.frame_width * 0, 0, fireboy.frame_width, fireboy.frame_height, fireboy.img:getWidth(), fireboy.img:getHeight()),
    love.graphics.newQuad(fireboy.frame_width * 1, 0, fireboy.frame_width, fireboy.frame_height, fireboy.img:getWidth(), fireboy.img:getHeight()),
    love.graphics.newQuad(fireboy.frame_width * 2, 0, fireboy.frame_width, fireboy.frame_height, fireboy.img:getWidth(), fireboy.img:getHeight()),
    love.graphics.newQuad(fireboy.frame_width * 3, 0, fireboy.frame_width, fireboy.frame_height, fireboy.img:getWidth(), fireboy.img:getHeight()),
    love.graphics.newQuad(fireboy.frame_width * 4, 0, fireboy.frame_width, fireboy.frame_height, fireboy.img:getWidth(), fireboy.img:getHeight())
}

function fireboy.draw(dt)
    love.graphics.draw(fireboy.img, fireboy.frames[fireboy.pos_frame],
                       fireboy.x - fireboy.frame_width / 2, fireboy.y - fireboy.frame_height)
end

function fireboy.updateInitialState(dt, gamestate)

end

function fireboy.update(dt, gamestate)
    fireboy.updateFunction(dt, gamestate)
end

-- State data
fireboyStates = { initial = "Initial", ascend = "Ascend", float = "Float", fall = "Fall", ready = "Ready" }
fireboy.state = fireboyStates.initial
fireboy.updateFunction = fireboy.updateInitialState

return fireboy
