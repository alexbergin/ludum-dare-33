define [

	"site/utilities/EntityProperty"

] , (

	EntityProperty

) ->

	class Model extends EntityProperty

		init: ->

			# setup the model & the class
			@.onInit?()
			@.make()

		make: ->

			# get what the soruce is
			srcType = typeof( @.src )

			# load an obj if the src is a path
			if srcType is "string" then @.load @.src

			# otherwise let the src define itself as geometry
			else if srcType is "function" then @.src()

		load: ( src ) ->

			# load the mesh from the src
			loader = new THREE.OBJLoader()
			loader.load src , ( obj ) =>
				@.loaded obj

		loaded: ( obj ) =>

			# save the object & the mesh
			@.mesh = obj.children[ 0 ]

			# convert from buffer geometry to regular
			# consider doing this only when a vertex needs editing?
			@.mesh.geometry = new THREE.Geometry().fromBufferGeometry @.mesh.geometry

			# let the model know it's loaded
			@.onLoaded?()
			@.geometryReady()

		geometryReady: ->

			# set up shadows
			@.mesh.castShadow = @.entity.shadows.casts
			@.mesh.receiveShadow = @.entity.shadows.receives

			# vertex properties
			run = [ "position" , "rotation" , "scale" ]
			verticies = [ "x" , "y" , "z" ]

			# apply positioning
			for process in run
				for vertex in verticies
					@.mesh[ process ][ vertex ] = @.entity[ process ][ vertex ]

			# add the object to the scene
			@.entity.root.stage.add @.mesh

			# apply the material
			@.mesh.material = @.entity.material?.style
			@.mesh.material?.needsUpdate = true

		destroy: ->

			@.entity.root.stage.remove @.mesh