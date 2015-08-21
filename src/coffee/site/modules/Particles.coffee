define [

	"site/utilities/SubClass"

] , (

	SubClass

) ->

	class Particles extends SubClass

		# the individual elements
		spots: []

		loop: ->

			# loop through backwards so we can
			# remove at will
			i = @.spots.length - 1
			while i >= 0
				@.update i
				i -= 1

		create: ( options ) ->

			# apply default settings
			options.totalLife = options.life
			spot = options

			# define material and geometry
			geometry = new THREE.Geometry()
			material = new THREE.PointCloudMaterial
				transparent: true
				opacity: 1
				color: spot.color
				size: spot.scale

			geometry.vertices.push( new THREE.Vector3( 0 , 0 , 0 ))

			# define the mesh
			spot.mesh = new THREE.PointCloud geometry , material

			spot.mesh.position = spot.position

			# append to the stage and save the particle
			@.root.stage.add spot.mesh
			@.spots.push spot

		update: ( i ) ->

			@.position i
			@.decay i

		position: ( i ) =>

			# get the spot to update
			spot = @.spots[ i ]

			# vertex array
			vertices = [ "x" , "y" , "z" ]

			# update each position property
			for vertex in vertices
				spot.velocity[ vertex ] += spot.gravity[ vertex ]
				spot.position[ vertex ] += spot.velocity[ vertex ]
				spot.mesh.position[ vertex ] = spot.position[ vertex ]

		decay: ( i ) ->

			# subtract the frame rate from the life
			spot = @.spots[ i ]
			spot.life -= 1000 / 60

			percent = spot.life / spot.totalLife
			spot.mesh.material.opacity = percent
			spot.mesh.material.needsUpdate = true

			# update the scale
			spot.scale = percent
			spot.mesh.scale.x = spot.mesh.scale.y = spot.mesh.scale.z = spot.scale

			# if we're under 0 then kill it
			if spot.life <= 0
				@.destroy i

		destroy: ( i ) ->

			spot = @.spots[ i ]

			# remove from the stage and the array here
			@.root.stage.remove spot.mesh
			@.spots.splice i , 1
