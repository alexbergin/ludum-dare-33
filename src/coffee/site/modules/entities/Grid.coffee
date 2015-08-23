define [

	"site/utilities/Entity"
	"site/modules/models/Grid"
	"site/modules/materials/Grid"

] , (

	Entity
	Model
	Material

) ->

	class Grid extends Entity

		init: ->

			# set up properties and pass the context
			@.material = new Material @
			@.model = new Model @