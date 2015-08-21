define [

	"site/utilities/EntityProperty"

] , (

	EntityProperty

) ->

	class Materials extends EntityProperty

		init: ->

			# this is just a threejs material def for now,
			# want to eventually load in a .mat file
			@.src()

			# convert back to buffer geometry to make it faster
			@.entity.mesh?.geometry = new THREE.BufferGeometry().fromGeometry @.entity.mesh.geometry

		destroy: ( duration ) =>

			# get the duration of the fade out and save it
			currently = new Date().getTime()
			if duration isnt undefined
				@.eliminateAt = currently + duration
				@.startAt = currently

			# calc the opacity
			total = @.eliminateAt - @.startAt
			progress = 1 - (( currently - @.startAt ) / total )

			# apply the opacity to the mesh & update it
			@.entity.model.mesh?.material.opacity = progress
			@.entity.model.mesh?.material.needsUpdate = true

			# only loop when needed
			if progress > 0 and @.entity.model.mesh?
				setTimeout =>
					@.destroy()
				, 1000 / 60



