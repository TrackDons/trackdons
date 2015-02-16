(function (context, factory){
  
  'use strict';
  factory(context.jQuery, context.Pikaday);

}(this, function ($, Pikaday) {
  
  'use strict';
  $.fn.pikaday = function() {
    var args = arguments;

    if (!args || !args.length) {
        args = [{ }];
    }

    return this.each(function() {
      var self   = $(this),
          plugin = self.data('pikaday');

      if (!(plugin instanceof Pikaday)) {
        if (typeof args[0] === 'object') {
          var options = $.extend({}, args[0]);
          options.field = self[0];
          self.data('pikaday', new Pikaday(options));
        }
      } else {
        if (typeof args[0] === 'string' && typeof plugin[args[0]] === 'function') {
          plugin[args[0]].apply(plugin, Array.prototype.slice.call(args,1));
        }
      }
    });
  };

}));

$(function(){
  $('[data-behaviour=datepicker]').pikaday();
});