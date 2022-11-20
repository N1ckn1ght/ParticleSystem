require "vector"
require "particle"
require "square"

function love.load()
    math.randomseed(os.time())
    Width = love.graphics.getWidth()
    Height = love.graphics.getHeight()

    Squares = {}
    -- Length of every square side
    Size = 50
    -- Maximum aount of squares on screen
    Count = 10
    -- Frames before new square will be created after destruction of previous one
    STime = 100

    for i = 1, Count do
        Squares[i] = MakeRandomSquare(Size)
    end
end

function love.update(dt)
    for i = 1, Count do
        if (Squares[i].time < 1) then
            Squares[i] = MakeRandomSquare(Size)
        end
        Squares[i]:update()
    end
end

function love.draw()
    for i = 1, Count do
        Squares[i]:draw()
    end
end

function love.mousepressed(x, y, button)
    if button == 1 then
        for i = 1, Count do
            if Collides(Squares[i], x, y) then
               Squares[i]:kill()
            end
        end
    end
end

function MakeRandomSquare(radius)
    return Square:create(Vector:create(math.random() * (Width - radius * 2) + radius, math.random() * (Height - radius * 2) + radius), Particle, radius)
end

function Collides(square, x, y)
    return square.body and not ((square.origin.x - square.radius / 2) > x or (square.origin.x + square.radius / 2) < x or (square.origin.y - square.radius / 2) > y or (square.origin.y + square.radius / 2) < y)
end