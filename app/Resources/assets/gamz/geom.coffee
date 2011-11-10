class gamz.geom.Coords
    constructor: (@x, @y)       ->
    clone:                      -> new gamz.geom.Coords @x, @y
    add: (coords)               -> @x += coords.x ; @y += coords.y ; (@)
    sub: (coords)               -> @x -= coords.x ; @y -= coords.y ; (@)
    mul: (coords)               -> @x *= coords.x ; @y *= coords.y ; (@)

class gamz.geom.Point extends gamz.geom.Coords
    clone:                      -> new gamz.geom.Point @x, @y
    vector: (point)             -> new gamz.geom.Vector point.x-@x, point.y-@y
    line: (point)               -> @vector(point).line point
    box: (point)                -> new gamz.geom.Box Math.min(@x, point.x), Math.min(@y, point.y), Math.abs(@x-point.x), Math.abs(@y-point.y)
    dist: (point)               -> @vector(point).norm()
    translate: (vector)         -> @add vector
    rotate: (angle, point)      -> @translate(@vector point).translate(point.vector(@).rotate angle)

class gamz.geom.Vector extends gamz.geom.Coords
    clone:                      -> new gamz.geom.Vector @x, @y
    reverse:                    -> @x  = -@x ; @y = -@y ; (@)
    rotate: (angle)             -> @angle @angle+angle
    opposite:                   -> @clone().reverse()
    norm: (norm)                -> if norm? then @mult norm/@norm() else Math.sqrt Math.pow(@x, 2)+Math.pow(@y, 2)
    angle: (angle)              -> norm = @norm() ; (if angle? then @x = norm*Math.cos angle ; @y = norm*Math.sin angle else angle = Math.acos @x/norm ; (if @y < 0 then angle += Math.PI)) ; (@)
    isnull:                     -> @x is 0 and @y is 0
    line: (point)               ->
        if @isnull() then return null
        if @x is 0 then return new gamz.geom.HorizontalLine point.y
        if @y is 0 then return new gamz.geom.VerticalLine point.x
        a = @x/@y ; new gamz.geom.ObliqueLine a, point.y-a*point.x

class gamz.geom.Box
    constructor: (@x, @y, @w, @h) ->
    clone:                      -> new gamz.geom.Box @x, @y, w, h
    contains: (point)           -> (@x <= point.x <= @x+@w) and (@y <= point.y <= @y+@h)

class gamz.geom.ObliqueLine
    constructor: (@a, @b)       ->
    clone:                      -> new gamz.geom.ObliqueLine @a, @b
    slope:                      -> @a
    parallel: (line)            -> line instanceof gamz.geom.ObliqueLine and @a is line.a
    cross: (line)               ->
        if @parallel line then return null
        if line instanceof gamz.geom.ObliqueLine then new gamz.geom.Vector (line.b-@b)/ @a-line.a, (@a*(line.b-@b)/ @a-line.a)+@b
        else line.cross @

class gamz.geom.HorizontalLine
    constructor: (@y)           ->
    clone:                      -> new gamz.geom.HorizontalLine @y
    slope:                      -> 0
    parallel: (line)            -> line instanceof gamz.geom.HorizontalLine
    cross: (line)               ->
        if @parallel line then return null
        if line instanceof gamz.geom.ObliqueLine then new gamz.geom.Vector (@y-line.b)/ line.a, @y
        else new gamz.geom.Vector @x, line.y

class gamz.geom.VerticalLine
    constructor: (@x)           ->
    clone:                      -> new gamz.geom.VerticalLine @x
    slope:                      -> Infinity
    parallel: (line)            -> line instanceof gamz.geom.VerticalLine
    cross: (line)               ->
        if @parallel line then return null
        if line instanceof gamz.geom.ObliqueLine then new gamz.geom.Vector @x, line.a*@x+line.b
        else line.cross @

class gamz.geom.Segment
    constructor: (@p1, @p2)     ->
    clone:                      -> new gamz.geom.Segment @p1.clone(), @p2.clone()
    length:                     -> Math.sqrt Math.pow(@width(), 2)+Math.pow(@height(), 2)
    vector:                     -> p1.vector p2
    line:                       -> p1.line p2
    box:                        -> p1.box p2
