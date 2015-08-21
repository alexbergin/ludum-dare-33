define ->

	# holds an entity's model, material, and collisions
	class Entity

		constructor: ( context , options ) ->

			# save the root context
			@.root = context.root

			# apply the defaults
			@.options = options
			@.parseOptions()

			# run the module's setup
			@.init?()

		parseOptions: ->

			# set the defaults
			@.shadows  = casts: true , receives: true
			@.position = x: 0 , y: 0 , z: 0
			@.rotation = x: 0 , y: 0 , z: 0
			@.scale    = x: 1 , y: 1 , z: 1

			# loop through and apply data if provided
			run = [ "position" , "rotation" , "scale" , "shadows" ]
			vertices = [ "x" , "y" , "z" , "casts" , "receives" ]

			# update the defaults
			for process in run
				for vertex in vertices
					if @.options?[ process ]?[ vertex ]?
						@[ process ][ vertex ] = @.options[ process ][ vertex ]

		destroy: ->

			@.collision?.destroy()
			@.model?.destroy()