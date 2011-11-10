class gamz.event.Dispatcher
    constructor:                -> @listeners = {} ; @reflection = new gamz.utils.Reflection()
    dispatch: (event, args...)  -> if @listeners[event]? then listener[0].apply listener[1], args for listener in @listeners[event]
    bind: (event, func, subject=@) -> (if not @listeners[event]? then @listeners[event] = []) ; @listeners[event].push [func, subject]
    unbind: (func)              -> ((if listener[0] is func then listeners.splice(index, 1)) for listener, index in listeners) for event, listeners of @listeners
    subscribe: (obj)            -> @bind name, meth, obj for name, meth of @reflection.methods obj ; console.log @reflection.methods obj
    unsubscribe: (obj)          -> ((if listener[1] is obj then listeners.splice(index, 1)) for listener, index in listeners) for event, listeners of @listeners

class gamz.event.Pulsar
    constructor: (@dispatcher, start, stop, @time) ->
        @dispatcher.bind start, (args...)=> @start(args)
        @dispatcher.bind stop,  ()=> @stop()
        @pulsar = new gamz.utils.Pulsar (()=> @trigger()), @time
        @listeners = [] ; @sleeping = false
    start: (@args)              -> if not @sleeping then @args = args ; @pulsar.start(true) ; @sleep()
    stop:                       -> @pulsar.stop()
    bind: (func, subject=@)     -> @listeners.push [func, subject]
    trigger:                    -> listener[0].apply listener[1], @args for listener in @listeners
    sleep:                      -> @sleeping = true ; setTimeout (()=> @sleeping = false), @time
