(function(){
	//Create the events cache for 'listenFor'
	var eventsCache = _.clone(Backbone.Events);
	
	var eventsRouter = function(evt, name, callback, context){
		if(typeof name === 'object'){
			callback = callback || this;
		}
		
		eventsCache[evt](name, callback, context || this);
		return this;
	};
	
	//Back up the original Backbone.Events.trigger
	//so it can be called from the new version
	var _trigger = Backbone.Events.trigger;
	
	var newEvents = {
		//Call 'on' with the events cache as 'this'
		listenFor: function(name, callback, context){
			return eventsRouter.call(this, 'on', name, callback, context);
		},
		
		//Call 'once' with the events cache as 'this'
		listenForOnce: function(name, callback, context){
			return eventsRouter.call(this, 'once', name, callback, context);
		},
		
		//Call 'off' with the events cache as 'this'
		stopListeningFor: function(name, callback, context){
			return eventsRouter.call(this, 'off', name, callback, context);
		},
		
		//Call 'trigger' with the events cache as 'this', and
		//normally so the standard 'trigger' still works.
		//The object that fired the event will be the first argument,
		//unless you are listening for 'all', in which case it will
		//be the second argument after the event name
		trigger: function(){
			var args = Array.prototype.slice.call(arguments, 0);
			
			//Only add the triggering object if it is not already there
			//It will already be there on many "native" Backbone events
			//such as model change events
			if(arguments[1] !== this){
				args.splice(1, 0, this);	
			}
			
			_trigger.apply(eventsCache, args);
			_trigger.apply(this, arguments);
			return this;
		}
	};
	
	//Add 'listenFor' and its variants and the new version of 'trigger'
	//to the standard Backbone objects
	_.each(['Model', 'Collection', 'View', 'Router', 'History'], 
		function(bbObject){
			_.extend(Backbone[bbObject].prototype, newEvents);
		}
	);
	
	//Update Backbone.Events and Backbone with the new methods
	_.extend(Backbone.Events, newEvents);
	_.extend(Backbone, newEvents);
	
	//Modify 'remove' for views to call stopListeningFor
	var _remove = Backbone.View.prototype.remove;
	Backbone.View.prototype.remove = function(){
		this.stopListeningFor();
		return _remove.apply(this, arguments);
	};
}());