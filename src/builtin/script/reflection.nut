class	BuiltinMaterialReflection
{
/*<
	<Script =
		<Name = "Mirror Reflection">
		<Author = "Emmanuel Julien">
		<Description = "Compute the reflexion texture for an item along a configurable axis.">
		<Category = "FX">
		<Compatibility = <Item>>
	>
	<Parameter =
		<material_name =	<Name = "Material name"> <Type = "String"> <Default = "material">>
		<apply_to_diffuse =	<Name = "Apply to diffuse."> <Description = "Apply texture to the material diffuse channel, use the reflection channel otherwise."> <Type = "Bool"> <Default = False>>
		<half_resolution =	<Name = "Half resolution."> <Type = "Bool"> <Default = True>>
		<affect_parent =	<Name = "Affect parent geometry."> <Description = "Search for the material to modify in the parent item geometry."> <Type = "Bool"> <Default = False>>
	>
>*/
	material_name		=	0
	apply_to_diffuse	=	false
	half_resolution		=	true
	affect_parent		=	false

	//-----------------------
	material			=	0
	texture				=	0

	function	OnSetup(item)
	{
		// Grab the first material on item geometry.
		material = GeometryGetMaterial(affect_parent ? ItemGetGeometry(ItemGetParent(item)) : ItemGetGeometry(item), material_name)

		// Create a new render target.
		texture = EngineCreateCanvasTexture(g_engine, (1024 * (half_resolution ? 0.5 : 1.0)).tointeger(), (512 * (half_resolution ? 0.5 : 1.0)).tointeger())

		MaterialChannelSetTexture(material, texture, (apply_to_diffuse?ChannelDiffuse:ChannelReflection))
		MaterialBuildShaderTreeFromFixedFunction(material)
	}

	/*
		Update the reflection texture.
	*/
	function	OnUpdate(item)
	{
		local	scene = ItemGetScene(item)

		// Compute aspect ratio.
		local	viewport = RendererGetViewport(g_render)
		local	ar = RendererSetGlobalAspectRatio(g_render, (viewport.w / viewport.z) * (2048.0 / 1024.0))

		// Grab camera and current settings.
		local	camera_item = CameraGetItem(SceneGetCurrentCamera(scene))

		local	camera_matrix = ItemGetMatrix(camera_item),
				camera_p = camera_matrix.GetRow(3),
				camera_f = camera_matrix.GetRow(2)

		local	prv_p = ItemGetPosition(camera_item),
				prv_r = ItemGetRotation(camera_item),
				prv_parent = ItemGetParent(camera_item),
				has_target = ItemHasTarget(camera_item),
				target = ItemGetTarget(camera_item)

		// Compute camera reflexion.

		local	item_matrix = ItemGetMatrix(item),
				item_n = item_matrix.GetRow(1).Normalize(),
				item_p = item_matrix.GetRow(3)
		local	d = item_n.Dot(camera_p - item_p)

		ItemSetParent(camera_item, NullItem)

		local	d = item_n.Dot(camera_p - item_p)
		local	mirror_p = camera_p - item_n * 2.0 * d

		if	(0)
		{
			ItemSetPosition(camera_item, mirror_p)
			ItemSetTarget(camera_item, camera_p - camera_f / (camera_f.Dot(item_n)) * d)
		}
		else
		{
			local	_d

			local	camera_l = camera_p + camera_matrix.GetRow(0)
					_d = item_n.Dot(camera_l - item_p)
			local	mirror_l = camera_l - item_n * 2.0 * _d

			local	camera_u = camera_p + camera_matrix.GetRow(1)
					_d = item_n.Dot(camera_u - item_p)
			local	mirror_u = camera_u - item_n * 2.0 * _d

			local	camera_f = camera_p + camera_matrix.GetRow(2)
					_d = item_n.Dot(camera_f - item_p)
			local	mirror_f = camera_f - item_n * 2.0 * _d

			local	mtx = Matrix4()

			mtx.SetRow(0, mirror_l - mirror_p)
			mtx.SetRow(1, (mirror_u - mirror_p).Reverse())
			mtx.SetRow(2, mirror_f - mirror_p)
//			mtx.SetRow(3, mirror_p)

			ItemSetNoTarget(camera_item)
			ItemSetMatrix(camera_item, mtx)
			ItemSetPosition(camera_item, mirror_p)
		}

		// Switch to output texture and render.
		RendererSetOutputTexture(g_render, texture)
		RendererClearFrame(g_render, 0, 0, 0)
		RendererSetViewport(g_render, 0.0, 0.0, 1.0, 1.0)
		RendererSetViewItemAndApplyView(g_render, camera_item)

		/*
			Offset the clipping plane to prevent a visible gap
			due to the resolution differences between the screen and the RT.
		*/
		RendererSetClippingPlane(g_render, item_p/* - item_n * 0.05*/, item_n.Reverse())

		SceneRenderToQueue(scene)	// Do not use SceneRender() for this, we only need the display list.
		RendererRenderQueue(g_render)
		RendererRenderQueueReset(g_render)

		RendererClearClippingPlane(g_render)

		// Restore camera, output buffer and viewport.	
		ItemSetPosition(camera_item, prv_p)
		ItemSetRotation(camera_item, prv_r)
		ItemSetParent(camera_item, prv_parent)
		if	(has_target)
				ItemSetTarget(camera_item, target)
		else	ItemSetNoTarget(camera_item)

		RendererSetOutputTexture(g_render, NullTexture)
		RendererSetViewport(g_render, 0.0, 0.0, 1.0, 1.0)
		RendererSetGlobalAspectRatio(g_render, ar)
	}
}
