animationManager = {}
animationManager.animations = {}

function animationManager.newAnimation(animationIndex, xPos, yPos)
    table.insert(animationManager.animations, newStillAnimation(animationIndex, xPos, yPos))
end

function animationManager.update(dt)
    for i, anim in ipairs(animationManager.animations) do
        anim.animationTimer = anim.animationTimer + dt
        if anim.animationTimer > anim.frame_time then
            anim.animationTimer = 0
            anim.pos_frame = anim.pos_frame + 1
            if anim.pos_frame > anim.num_frames then
                if anim.loop then
                    anim.pos_frame = 1
                else
                    table.remove(animationManager.animations, i)
                end
            end
        end
    end
end

function animationManager.draw(dt)
    for i, anim in ipairs(animationManager.animations) do
        love.graphics.draw(anim.img, anim.frames[anim.pos_frame],
                           anim.x-anim.pivot.x, anim.y-anim.pivot.y)
    end
end

return animationManager
