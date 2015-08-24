define [

	"site/utilities/Entity"
	"site/modules/models/MonsterEyeWhite"
	"site/modules/materials/MonsterEyeWhite"

] , (

	Entity
	Model
	Material

) ->

	class MonsterEyeWhite extends Entity

		init: ->

			# set up properties and pass the context
			@.material = new Material @
			@.model = new Model @