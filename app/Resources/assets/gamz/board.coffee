class gamz.board.Matrix
    constructor: (@width, @height) -> @empty()
    empty:                      -> @cells = {}
    length:                     -> length = 0 ; (if not cell.empty() then length += 1) for cell of @cells ; length
    id: (x, y)                  -> x+','+y
    available: (x, y)           -> @get(x, y).available()
    get: (x, y)                 -> id = @id x, y ; if @cells[id]? then @cells[id] else if @inside x, y then new gamz.board.Cell x, y, @ else new gamz.board.InvalidCell(x, y, @)
    set: (cell, x, y)           -> cell.x = x ; cell.y = y ; @cells[@id x, y] = cell
    add: (cell)                 -> if @available cell.x, cell.y then @set cell, cell.x, cell.y ; true else false
    pop: (x, y)                 -> cell = @get x, y ; @remove x, y ; cell
    remove: (x, y)              -> delete @cells[@id x, y]
    move: (cell, x, y)          -> if @available x, y then @set @pop(cell.x, cell.y), x, y
    inside: (x, y)              -> 0 <= x < @width and 0 <= y < @height

class gamz.board.AbstractCell
    constructor: (@x, @y, matrix) -> if matrix? then @bind matrix
    bind: (matrix)              -> if matrix.add @ then @matrix = matrix ; true else false
    unbind:                     -> (if @bound() then @matrix.remove @x, @y) ; @matrix = null
    bound:                      -> @matrix?
    neighbor: (dx, dy)          -> @matrix?.get @x+dx, @y+dy
    remove:                     -> @matrix?.remove @x, @y
    test: (dx, dy)              -> @matrix?.available @x+dx, @y+dy

class gamz.board.InvalidCell extends gamz.board.AbstractCell
    available:                  -> false
    empty:                      -> true

class gamz.board.Cell extends gamz.board.AbstractCell
    available:                  -> @empty()
    empty:                      -> not @content?
    move: (dx, dy)              -> @matrix?.move @, @x+dx, @y+dy
    push: (@content)            ->
    pop:                        -> content = @content ; @remove() ; content

class gamz.board.Group
    constructor: (root)         -> @cells = [] ; @add root
    add: (cell)                 -> if not @has cell then (@cells.push cell ; true) else false
    has: (cell)                 -> cell in @cells
    size:                       -> @cells.length

class gamz.board.ContentGroup extends gamz.board.Group
    add: (cell)                 -> if super(cell) then (if @match cell, neighbor then @add neighbor) for neighbor in @neighborhood cell
    neighborhood: (cell)        -> [cell.neighbor(0, 1), cell.neighbor(0, -1), cell.neighbor(1, 0), cell.neighbor(-1, 0)]
    match: (cell, neighbor)     -> neighbor?.content?
