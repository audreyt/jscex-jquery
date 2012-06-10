(function(){
  var $, say, fetch;
  $ = require('./jscex-jquery');
  say = function(it){
    console.log(it);
    console.log('');
  };
  fetch = eval($.async(function(url){
    var it, a, title, text;
    it = $await($.get(url));
    a = $(it).find('h2:first a');
    title = a.text();
    it = $await($.get(url + "/" + a.attr('href')));
    text = $(it).find('.post p:last').text();
    return {
      title: title,
      text: text
    };
  }));
  say('[Demo: Fetching invalid host, expecting ENOENT...]');
  fetch('http://blog.zhaojie.error').fail(function(){
    return say(this.responseText);
  }).always(function(){
    say('[Demo: Fetching valid host, expecting snippet...]');
    return fetch('http://blog.zhaojie.me').always(say);
  });
}).call(this);
