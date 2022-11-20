Particle = {}
Particle.__index = Particle

function Particle:create(point1, point2)
    local particle = {}
    setmetatable(particle, Particle)
    particle.position = {point1, point2}
    particle.acceleration = Vector:create(0, 0.35)
    particle.velocity = Vector:create(math.random() * 8 - 4, math.random() * 4)
    particle.lifespan = math.random(30, 80)
    return particle
end

function Particle:update()
    self.velocity:add(self.acceleration)
    for _, point in pairs(self.position) do
        point:add(self.velocity)
    end
    self.lifespan = self.lifespan - 1
end

function Particle:isDead()
    if self.lifespan < 0 then
        return true
    end
    return false
end

function Particle:draw()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(255, 255, 255, self.lifespan / 100)
    love.graphics.line(self.position[1].x, self.position[1].y, self.position[2].x, self.position[2].y)
    love.graphics.setColor(r, g, b, a)
end

function Particle:applyForce(force)
    self.acceleration:add(force)
end