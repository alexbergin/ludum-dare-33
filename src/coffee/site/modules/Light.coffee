define [

	"site/utilities/SubClass"

] , (

	SubClass

) ->

	class Light extends SubClass

		# light options
		cast: true
		color: 0xffffff
		background: 0xEDFFFE
		onlyShadow: false
		shadowDarkness: 0.1
		debug: false
		mapSize: 2048

		init: ->

			@.make()
			@.preferences()
			@.place()

		make: ->

			# make the lights
			@.light = new THREE.DirectionalLight @.background , 0.1
			@.ambient = new THREE.HemisphereLight @.background , @.background , 0.75

		preferences: ->

			# set preferences
			@.light.castShadow = @.cast
			@.light.onlyShadow = @.onlyShadow

			# shadows
			@.light.shadowDarkness = @.shadowDarkness
			@.light.shadowCameraVisible = @.debug
			@.light.shadowCameraNear = 0
			@.light.shadowCameraFar = 175
			@.light.shadowCameraLeft = -50
			@.light.shadowCameraRight = 50
			@.light.shadowCameraTop = 50
			@.light.shadowCameraBottom = -50
			@.light.shadowMapWidth = @.mapSize
			@.light.shadowMapHeight = @.mapSize

		place: ->

			# put the lights on the stage
			@.root.stage.scene.add @.light
			@.root.stage.scene.add @.ambient

			# position the light source
			@.light.position.set -30 , 30 , 30
			@.light.lookAt x: 0 , y: 0 , z: 0