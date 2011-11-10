class gamz.utils.Reflection
    filter: (obj, func)         -> map = {} ; (if key isnt 'constructor' and func(key, val) then map[key] = val) for key, val of obj ; map
    values: (obj, filter)       -> obj[key] for key, val of (if filter? then @filter(obj, filter) else obj)
    keys: (obj, filter)         -> key for key, val of (if filter? then @filter(obj, filter) else obj)
    types: (obj, type)          -> @filter obj, (key, val)-> typeof val is type
    methods: (obj)              -> @types obj, 'function'
    scalars: (obj)              -> @filter obj, (key, val)-> typeof val not in ['function', 'object', 'array']

class gamz.utils.Pulsar
    constructor: (@func, @time) ->
    start: (call=false)         -> if not @started then @started = true ; (if call then @call() else @schedule()) ; true else false
    stop:                       -> if @started then @unschedule() ; @started = false ; true else false
    reset:                      -> started = @started ; @stop() ; @start() ; started
    schedule:                   -> @timer = setTimeout (()=> @call()), @time
    unschedule:                 -> clearTimeout(@timer)
    call:                       -> @schedule() ; if @started then @func.call @
