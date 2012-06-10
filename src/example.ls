$ = require './jscex-jquery'
say = !-> console.log it; console.log ''

fetch = eval $.async (url) ->
    it = $await $.get url
    a = $(it) .find 'h2:first a'
    title = a.text!
    it = $await $.get "#url/#{ a.attr \href }"
    text = $(it) .find '.post p:last' .text!
    return { title, text }

say '[Demo: Fetching invalid host, expecting ENOENT...]'

<- fetch \http://blog.zhaojie.error
    .fail -> say it.responseText
    .always

say '[Demo: Fetching valid host, expecting snippet...]'

<- fetch \http://blog.zhaojie.me
    .always say
