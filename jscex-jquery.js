(function(){
  var Jscex, XMLHttpRequest, $;
  Jscex = require('jscex');
  require('jscex-jit').init(Jscex);
  require('jscex-async').init(Jscex);
  require('jscex-async-powerpack').init(Jscex);
  XMLHttpRequest = require('xmlhttprequest').XMLHttpRequest;
  $ = require('jquery');
  $.support.cors = true;
  $.ajaxSettings.xhr = function(){
    return new XMLHttpRequest;
  };
  /* Convert a Promise (Q, jQuery, Dojo) object into a Task */
  Jscex.Async.Binding.fromPromise = function(p){
    return Jscex.Async.Task.create(function(t){
      return p.then(function(it){
        return t.complete('success', it);
      }, function(it){
        return t.complete('failure', it);
      });
    });
  };
  /* Shorthand for fromPromise */
  $.async = Jscex.Async.Binding.fromPromise;
  /* Compile a function containing the special $await keyword.
  
     Once invoked, we implicitly start the task, and return a
     deferred Promise object representing its result.
  */
  $.evalAsync = function(cb){
    var runner;
    runner = eval(Jscex.compile('async', cb));
    return function(){
      var __;
      __ = $.Deferred();
      (function(){
        this.addEventListener('success', function(){
          return __.resolve(this.result);
        });
        this.addEventListener('failure', function(){
          return __.reject(this.error);
        });
        this.start();
      }.call(runner.apply(null, arguments)));
      return __;
    };
  };
  /* Turn off Jscex logging by default */
  Jscex.logger.level = 999;
  /* Export the $ object extended with $.Jscex */
  $.Jscex = Jscex;
  module.exports = $;
}).call(this);
