define ->

	class Poof

		options:
			scaleMin: 0.75
			scaleMax: 1.75
			minVel: -0.075
			maxVel: 0.075
			lifeMin: 550
			lifeMax: 1200
			countMin: 20
			countMax: 40

		constructor: ( root , color , position , velocity ) ->

			p = position or new CANNON.Vec3 0 , 0 , 0
			v = velocity or new CANNON.Vec3 0 , 0 , 0
			o = @.options
			c = Math.floor( Math.randomBetween( o.countMin , o.countMax ))
			i = 0

			while i < c

				life = Math.randomBetween o.lifeMin , o.lifeMax
				scale = Math.randomBetween o.scaleMin , o.scaleMax

				options =
					color: 0xE1E4EA
					scale: scale
					life: life
					position: 
						x: position.x + Math.randomBetween o.minVel , o.maxVel
						y: position.y + Math.randomBetween o.minVel , o.maxVel
						z: position.z + Math.randomBetween o.minVel , o.maxVel
					velocity: 
						x: ( v.x * 0.75 ) + 2 * Math.randomBetween o.minVel , o.maxVel
						y: ( v.y * 0.02 ) + Math.randomBetween o.minVel , o.maxVel
						z: ( v.z * 0.75 ) + 2 * Math.randomBetween o.minVel , o.maxVel
					gravity:
						x: 0 , y: 0 , z: 0

				root.particles.create options
				i++
