Square = {}
Square.__index = Square

function Square:create(origin, cls, radius)
    local system = {}
    setmetatable(system, Square)
    system.origin = origin
    system.particles = {}
    system.cls = cls or Particle
    self.body = true
    self.radius = radius
    self.index = 1
    self.time = STime
    return system
end

function Square:update()
    if not self.body then
        self.time = self.time - 1
        for k,v in pairs(self.particles) do
            if not v:isDead() then
                v:update()
            end
        end
    end
end

function Square:draw()
    if self.body then
        love.graphics.rectangle("line", self.origin.x - self.radius / 2, self.origin.y - self.radius / 2, self.radius, self.radius)
    else
        -- print('?')
        for k, v in pairs(self.particles) do
            -- print('!')
            v:draw()
        end
    end
end

function Square:createParticles()
    local o = self.origin:copy()
    local r = self.radius / 2
    self.particles[1] = self.cls:create(Vector:create(o.x - r, o.y - r), Vector:create(o.x + r, o.y - r))
    self.particles[2] = self.cls:create(Vector:create(o.x + r, o.y - r), Vector:create(o.x + r, o.y + r))
    self.particles[3] = self.cls:create(Vector:create(o.x + r, o.y + r), Vector:create(o.x - r, o.y + r))
    self.particles[4] = self.cls:create(Vector:create(o.x - r, o.y + r), Vector:create(o.x - r, o.y - r))
end

function Square:applyForceOnParticles(force)
    for k, v in pairs(self.particles) do
        v:applyForce(force)
    end
end

function Square:kill()
    self.body = false
    self:createParticles()
end