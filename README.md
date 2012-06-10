jscex-jquery
============

# Synopsis

```javascript
// Drop-in replacement to require('jquery')
var $ = require('jscex-jquery');

// Define an Async function with a special $await keyword in it
var fetch = eval($.async(function(url) {
    // $await takes anything that returns a Promise
    var html = $await( $.get(url) );
    // ...pauses one second...
    $await( $.async.sleep(1000) );
    // ...do something with the returned html...
    return html;
}));

// Return value of the Async function is always a Promise
fetch('http://.../').done(...).fail(...).always(...);
```
    
# Description

This module exports a jQuery root object (`$`) containing an
`$.async` helper; it compiles a regular function into one
that returns a Promise object.

Functions defined with `$.async` has access to an extra `$await`
keyword, which implicitly waits for other Promise objects.

In addition to jQuery's built-in Promise functions (`$.ajax`, etc),
we also provide `$.async.sleep` for delaying execution in a
synchronous fashion.

Please see `example.js` for a sample usage, and type `make demo`
to see it in action.

The source code is in `src` directory and written in LiveScript.
Note that LiveScript is _not_ a runtime dependency of this module;
it's only used for development.

For use in client-side browser environments, please see examples
in the `samples` directory.

The underlying JIT compiler is available as the `$.Jscex` object.

# See Also

* Jscex: http://jscex.info/
* jQuery.Deferred: http://api.jquery.com/category/deferred-object/
* LiveScript: https://gkz.github.com/LiveScript
* jQuery adapter for Q promises: https://github.com/audreyt/q-jscex/

# CC0 1.0 Universal

To the extent possible under law, 唐鳳 has waived all copyright
and related or neighboring rights to jscex-jquery.

This work is published from Taiwan.

http://creativecommons.org/publicdomain/zero/1.0
