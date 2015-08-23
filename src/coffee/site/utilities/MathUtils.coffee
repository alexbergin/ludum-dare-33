define ->

	# things I find myself wishing Math had
	class MathUtils

		constructor: ->
			
			Math.radians = ( n ) -> return n * ( Math.PI / 180 )
			Math.degrees = ( n ) -> return n * ( 180 / Math.PI )
			Math.constrain = ( n , min , max ) -> return Math.min( max , Math.max( min , n ))
			Math.randomBetween = ( min , max ) -> return min + ( Math.random() * ( max - min ))

			Math.euler = ( n ) ->
				e = new THREE.Euler
				e.setFromQuaternion new THREE.Quaternion n.x , n.y , n.z , n.w
				return e

			Math.quaternion = ( n ) ->
				q = new THREE.Quaternion
				q.setFromEuler new THREE.Euler n.x , n.y , n.z
				return q