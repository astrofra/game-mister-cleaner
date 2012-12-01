class	BuiltinCharacterController
{
/*<
	<Script =
		<Name = "1st Person Camera">
		<Author = "Emmanuel Julien">
		<Description = "Typical controls for a movable character.">
		<Category = "Game/Camera">
		<Compatibility = <Camera>>
	>
	<Parameter =
		<height = <Name = "Height (m)"> <Type = "Float"> <Default = 1.80>>
		<radius = <Name = "Width (m)"> <Type = "Float"> <Default = 0.7>>
		<mass = <Name = "Mass (Kg)"> <Type = "Float"> <Default = 5>>
		<speed = <Name = "Speed (m/s)"> <Type = "Float"> <Default = 0.35>>
		<boxshape = <Name = "Use a Sphere as collision."> <Type = "Bool"> <Default = False>>
	>
>*/
	height		=	1.8
	radius		=	0.7
	mass		=	1
	speed		=	0.35
	boxshape	=	false

	body		=	0

	mx			=	0
	my			=	0
	old_mx		=	0
	old_my		=	0
	acc			=	0
	euler		=	0

	function	CreateBody(item)
	{
		// Create the body object.
		body = item.scene().addObject("Body")
		body.setPosition(item.worldPosition())

		// Create the body capsule collision shape.
		local	shape = body.addCollisionShape()

		if (!boxshape)
			shape.setCapsule(radius, height)
		else	
			ShapeSetSphere(shape, Max(radius, height))

		shape.setRotation(Vector(Deg(90), 0, 0))
		shape.setPosition(Vector(0, 0, 0))
		shape.setMass(mass)
		shape.setStaticFriction(0.2)
		shape.setDynamicFriction(0.2)
		shape.setRestitution(0)

		body.setPhysicsMode(PhysicModeDynamic)
		body.setAngularFactor(Vector(0, 0, 0))

		// Parent this to the body object and move to 90% of the total height.
		item.setNoTarget()
		item.setParent(body)
		item.setPosition(Vector(0, height * 0.9, 0))
	}

	function	OnSetup(item)
	{
		CreateBody(item)
		acc = Vector(0, 0, 0)
		euler = Vector(0, 0, 0)
	}

	function	OnUpdate(item)
	{
		KeyboardUpdate()
		MouseUpdate()

		old_mx = mx
		old_my = my
		mx = MousePoolFunction(DeviceAxisX)
		my = MousePoolFunction(DeviceAxisY)

		acc = Vector(0, 0, 0)
		euler = item.rotation() + Vector(my - old_my, mx - old_mx, 0) * Deg(0.006)

		if	(euler.x < Deg(-30))
			euler.x = Deg(-30)
		if	(euler.x > Deg(35))
			euler.x = Deg(35)
		item.setRotation(euler)

		if	(KeyboardSeekFunction(DeviceKeyPress, KeySpace))
			body.applyLinearImpulse(item.matrix().GetRow(1).MulReal(1.5 * speed))

		if	(KeyboardSeekFunction(DeviceKeyPress, KeyUpArrow))
			acc = Vector(0, 0, 1)
		if	(KeyboardSeekFunction(DeviceKeyPress, KeyDownArrow))
			acc = Vector(0, 0, -1)
		if	(KeyboardSeekFunction(DeviceKeyPress, KeyLeftArrow))
			acc = Vector(-1, 0, 0)
		if	(KeyboardSeekFunction(DeviceKeyPress, KeyRightArrow))
			acc = Vector(1, 0, 0)

		body.applyLinearImpulse(acc * RotationMatrixY(euler.y) * speed)

		// FIXME this is framerate dependent.
		body.setLinearVelocity(body.linearVelocity() * Vector(0.94, 1.0, 0.94))	
	}
}
