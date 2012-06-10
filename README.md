jscex-jquery
============

# Synopsis

```javascript
$ = require('./jscex-jquery');

// Define an Async function with a special $await keyword in it
var fetch = $.async(function(url) {
    // $await takes anything that returns a Promise
    var it = $await( $.get(url) );
    // ...do something with it...
    return it;
});

// Return value of the $.async() call is always a Promise
fetch('http://.../').done(...).fail(...).always(...);
```
    
# Description

This module exports Jscex as a jQuery plugin, providing a `$.Jscex`
root object along with a `$.async` helper that runs a function under
Jscex, providing an extra `$await` keyword that implicitly waits for
jQuery promises.

Please see `example.js` for a sample usage, and type `make demo`
to see it in action.

The source code is in `src` directory and written in LiveScript.
Note that LiveScript is _not_ a runtime dependency of this module;
it's only used for development.

# Caveats

At the moment, this module only runs under Node.js.  Pull requests
welcome for porting to other runtime environments!

# See Also

* Jscex: http://jscex.info/
* jQuery.Deferred: http://api.jquery.com/category/deferred-object/
* LiveScript: https://gkz.github.com/LiveScript

# CC0 1.0 Universal

To the extent possible under law, 唐鳳 has waived all copyright
and related or neighboring rights to jscex-jquery.

This work is published from Taiwan.

http://creativecommons.org/publicdomain/zero/1.0
