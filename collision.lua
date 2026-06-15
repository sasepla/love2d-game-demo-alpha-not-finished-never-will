local collision = {}

function collision.distance(x1, y1, x2, y2)
return math.sqrt((x1 - x2)^2 + (y1 - y2)^2)
end

function collision.circlesCollide(x1, y1, r1, x2, y2, r2)
return collision.distance(x1, y1, x2, y2) < (r1 + r2)
end

return collision
