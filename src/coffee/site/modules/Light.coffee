define [

	"site/utilities/SubClass"

] , (

	SubClass

) ->

	class Light extends SubClass

		# light options
		cast: true
		color: 0xFDFFE2
		background: 0xFFFBBF
		onlyShadow: false
		shadowDarkness: 0.05
		debug: false
		mapSize: 2048

		init: ->

			@.make()
			@.preferences()
			@.place()

		make: ->

			# make the lights
			@.spot = new THREE.DirectionalLight @.background , 0.1
			@.ambient = new THREE.HemisphereLight @.background , @.background , 0.75

		preferences: ->

			# set preferences
			@.spot.castShadow = @.cast
			@.spot.onlyShadow = @.onlyShadow

			# shadows
			@.spot.shadowDarkness = @.shadowDarkness
			@.spot.shadowCameraVisible = @.debug
			@.spot.shadowCameraNear = 0
			@.spot.shadowCameraFar = 275
			@.spot.shadowCameraLeft = -100
			@.spot.shadowCameraRight = 100
			@.spot.shadowCameraTop = 100
			@.spot.shadowCameraBottom = -100
			@.spot.shadowMapWidth = @.mapSize
			@.spot.shadowMapHeight = @.mapSize

		place: ->

			# put the lights on the stage
			@.root.stage.scene.add @.spot
			@.root.stage.scene.add @.ambient