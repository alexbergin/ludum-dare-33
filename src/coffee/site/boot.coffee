define [

	# modules
	"site/modules/Camera"
	"site/modules/Interface"
	"site/modules/Light"
	"site/modules/Particles"
	"site/modules/Stage"
	"site/modules/Game"
	"site/modules/World"

	# utilities
	"site/utilities/MathUtils"

	# libs
	"requestAnimationFrame"
	"classlist"
	"THREE"
	"CANNON"

	# plugins
	"OBJLoader"
	"CannonDebugRenderer"

] , (

	# modules
	Camera
	Interface
	Light
	Particles
	Stage
	Game
	World

	# utilities
	MathUtils

) ->

	# setup utilities we'll use in the app first
	new MathUtils()

	# set up the app
	class App

		# used to get the delta
		past: new Date().getTime()

		# turn the loop on and off
		paused: false

		width: window.innerWidth
		height: window.innerHeight

		constructor: ->

			# set up subclasses & pass the root context
			# order of declaration is important
			@.stage = new Stage @
			@.world = new World @

			@.camera = new Camera @
			@.interface = new Interface @
			@.light = new Light @
			@.particles = new Particles @

			@.game = new Game @

			# start looping
			@.loop()

		loop: =>

			# call another loop
			requestAnimationFrame @.loop

			# get the delta
			present = new Date().getTime()
			delta = present - @.past
			@.past = present

			# call the loop function on subclasses
			if not @.paused

				tasks = [
					"camera"
					"stage"
					"world"
					"particles"
					"light"
					"game"
					"interface"
				]
				
				for task in tasks
					@[ task ].loop? delta