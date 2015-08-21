define [

	"site/utilities/SubClass"

] , (

	SubClass

) ->

	class Camera extends SubClass

		# where the camera is facing
		facing:
			x: 0
			y: -5
			z: 0

		# the camera's target position
		anchor:
			x: 9
			y: 5
			z: 9

		# the camera's actual position
		position:
			x: 9
			y: 5
			z: 9

		# camera setup preferences
		prefs:
			minDistance: 1
			maxDistance: 1000

		init: ->

			@.build()
			@.addListeners()

		build: ->

			@.main = new THREE.PerspectiveCamera 75 , @.root.width / @.root.height , @.minDistance , @.maxDistance

		addListeners: ->

			# listen for a resize to update the camera
			window.addEventListener "resize" , @.onResize

		onResize: =>

			# update the apsect ratio and camera
			@.main.aspect = @.root.width / @.root.height
			@.main.updateProjectionMatrix()

		loop: ->

			@.getTargetPosition()
			@.updatePosition()

		getTargetPosition: ->

			# position the camera relative to the anchor
			# based on the angle + distance
			x = @.anchor.x
			y = @.anchor.y
			z = @.anchor.z
			@.position =
				x: x , y: y , z: z

		updatePosition: ->

			# vertices the camera can move on
			vertices = [ "x" , "y" , "z" ]

			for vertex in vertices

				# handle positioning the camera
				@.main.position[ vertex ] = @.ease( @.main.position[ vertex ] , @.position[ vertex ] , 0.1 )

			# make the camera look at its target
			@.main.lookAt x: @.facing.x , y: @.facing.y , z: @.facing.z

		ease: ( prop , target , rate ) ->

			# get the difference
			diff = prop - target

			# ease to its new position 
			if Math.abs( diff ) > rate / 10000
				prop -= diff * rate

			# don't kill the memory
			else
				prop = target

			return prop