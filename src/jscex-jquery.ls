Jscex = require \jscex
require \jscex-jit .init Jscex
require \jscex-async .init Jscex
require \jscex-async-powerpack .init Jscex

{ XMLHttpRequest } = require \xmlhttprequest

$ = require \jquery
$.support.cors = yes
$.ajaxSettings.xhr = -> new XMLHttpRequest

/* Convert a Promise (Q, jQuery, Dojo) object into a Task */
Jscex.Async.Binding.fromPromise = (p) ->
    t <- Jscex.Async.Task.create
    p.then(
        -> t.complete \success, it
        -> t.complete \failure, it
    )
    return t

/* Shorthand for fromPromise */
$.async = Jscex.Async.Binding.fromPromise

/* Compile a function containing the special $await keyword.

   Once invoked, we implicitly start the task, and return a
   deferred Promise object representing its result.
*/
$.evalAsync = (cb) ->
    runner = eval Jscex.compile \async, cb
    return ->
        __ = $.Deferred!
        with runner ...arguments
            @addEventListener \success, !-> __.resolve @result
            @addEventListener \failure, !-> __.reject @error
            @start!
        __

/* Turn off Jscex logging by default */
Jscex.logger.level = 999

/* Export the $ object extended with $.Jscex */
$.Jscex = Jscex
module.exports = $
