define [ 

	"site/utilities/Model"

] , (

	Model

) ->

	class Combo extends Model

		scale: 2

		formations: [

			[ 
				x: 0
				y: 0
			,
				x: 1
				y: 0
			,
				x: 0
				y: 1
			,
				x: 1
				y: 1
			],

			[ 
				x: 0
				y: 0
			,
				x: 0
				y: 1
			,
				x: 0
				y: 2
			,
				x: 0
				y: 3
			],

			[ 
				x: 0
				y: 0
			,
				x: 1
				y: 0
			,
				x: 1
				y: -1
			,
				x: 2
				y: -1
			],

			[ 
				x: 0
				y: 0
			,
				x: 0
				y: 1
			,
				x: 0
				y: 2
			,
				x: 1
				y: 2
			],

			[ 
				x: 0
				y: 0
			,
				x: -1
				y: 1
			,
				x: 0
				y: 1
			,
				x: 1
				y: 1
			]
		]

		src: ->

			s = @.scale
			@.formation = @.formations[ Math.floor( Math.random() * @.formations.length  )]

			material = new THREE.MeshBasicMaterial
				color: 0x000000

			vertices = [ "x" , "y" ]
			boxes = []

			@.center =
				x: 0
				y: 0

			for pos in @.formation
				for vertex in vertices
					@.center[vertex] += pos[ vertex ] * s

			@.center.x = @.center.x / @.formation.length
			@.center.y = @.center.y / @.formation.length

			i = 0
			while i < @.formation.length
				geometry = new THREE.BoxGeometry s , s , s
				box = new THREE.Mesh geometry , material
				boxes.push box
				i++

			i = 0
			while i < @.formation.length
				box = boxes[i]
				position = @.formation[i]

				for vertex in vertices
					box.position[ vertex ] = position[ vertex ] * s - @.center[ vertex ]
				i++

			i = 0
			box = new THREE.Mesh new THREE.Geometry , material
			while i < @.formation.length
				box.geometry.mergeMesh boxes[i]
				i++

			@.mesh = box
			@.geometryReady()