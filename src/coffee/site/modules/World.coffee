define [

	"site/utilities/SubClass"

] , (

	SubClass

) ->

	# handles the physics of the world
	class World extends SubClass

		# world preferences
		preferences:
			debugging: true
			tolerance: 0.001
			gravity: 
				x: 0
				y: -9.81 / 4
				z: 0

		init: ->

			# make the world if it doesn't already exist
			if @.w is undefined then @.w = new CANNON.World()

			# create the debug display
			@.debug = new THREE.CannonDebugRenderer @.root.stage.scene , @.w

			# preferences
			@.w.broadphase = new CANNON.NaiveBroadphase()
			@.w.solver.tolerance = @.preferences.tolerance
			g = @.preferences.gravity
			@.w.gravity.set( g.x , g.y , g.z )

		loop: ( delta ) ->

			# update the debug view and step the world
			if @.preferences.debugging is true then @.debug.update()
			@.w.step 1/60 , delta , 3

		add: ( item ) =>

			@.w.addBody item

		remove: ( item ) =>

			@.w.removeBody item
