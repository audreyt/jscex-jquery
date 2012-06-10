Jscex = require \jscex
require \jscex-jit .init Jscex
require \jscex-async .init Jscex

if module?
    module.exports = $ = require \jquery
    { XMLHttpRequest } = require \xmlhttprequest
    $.support.cors = yes
    $.ajaxSettings.xhr = -> new XMLHttpRequest
else
    ($ ?= jQuery ? {}).Deferred ? throw new Error "$.Deferred not available -- Please include jQuery 1.5+"

/* Convert a Promise (Q, jQuery, Dojo) object into a Task */
Jscex.Async.@Binding.fromPromise = (p) ->
    t <- Jscex.Async.Task.create
    p.then(
        -> t.complete \success, it
        -> t.complete \failure, it
    )
    return t

/* Our own monad that runs on $.Deferred instead of Task */
class AsyncBuilder
    Start: (_this, step) ->
        __ = $.Deferred()
        step.next _this, !(type, value, target) ->
            switch type
            | \normal \return   => __.resolve value
            | \throw            => __.reject value
            | otherwise         => throw new Error "Unsupported type: #type"
        return __
    Bind: (promise, generator) ->
        return next: (_this, cb) -> promise.then(
            !(result) ->
                try step = generator.call _this, result
                catch return cb \throw, e
                step.next _this, cb
            !(error) -> cb \throw, error
        )

AsyncBuilder:: <<<< Jscex.BuilderBase::

Jscex.binders.\async-jquery = \$await
Jscex.builders.\async-jquery = new AsyncBuilder
Jscex.modules.\async-jquery = true

/* Compile a function containing the special $await keyword.

   Once invoked, we implicitly start the task, and return a
   deferred Promise object representing its result.
*/
$.async = (cb) -> eval Jscex.compile \async-jquery, cb

/* Turn off Jscex logging by default */
Jscex.logger.level = 999

/* Export the $ object extended with $.Jscex */
$.Jscex = Jscex
