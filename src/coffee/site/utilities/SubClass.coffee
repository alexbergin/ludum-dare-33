define ->

	# extend this class to pass the app context along to @.root
	# send any extra data needed when initializing in
	# the second parameter
	class SubClass

		constructor: ( root , data ) ->

			# save context
			@.root = root

			# tell the subclass to setup with init if this
			# funtion is available
			@.init? data