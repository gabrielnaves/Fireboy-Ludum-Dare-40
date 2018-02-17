firebar = {}

firebar.startingFire = 100
firebar.maxFire = 500
firebar.fire = firebar.startingFire
firebar.backImg = love.graphics.newImage('assets/sprites/fireBar_back.png')
firebar.frontImg = love.graphics.newImage('assets/sprites/fireBar_front.png')

function firebar.updateFire(fireAmount)
    firebar.fire = fireAmount
    if firebar.fire > firebar.maxFire then firebar.fire = firebar.maxFire end
    if firebar.fire < 0 then firebar.fire = 0 end
    firebar.fire = math.floor(firebar.fire)
end

function firebar.draw(dt)
    if gamestate.state ~= gamestate.states.begin then
        graphics.draw(firebar.backImg, 6 + camera.realX, 2 + camera.realY)
        graphics.draws(firebar.frontImg, 10 + camera.realX, 6 + camera.realY, 0, firebar.fire / firebar.maxFire, 1)
    end
end

return firebar
