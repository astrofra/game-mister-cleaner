class	BuiltinSceneCameraSlideShow
{
/*<
	<Script =
		<Name = "Camera Slide Show">
		<Author = "Emmanuel Julien">
		<Description = "Fade in/out between a set of cameras.">
		<Category = "Presentation">
		<Compatibility = <Scene>>
	>
	<Parameter =
		<camera_prefix = <Name = "Camera prefix"> <Description = "Camera name prefix."> <Type = "String"> <Default = "Camera">>
		<slide_duration = <Name = "Slide duration (s)"> <Type = "Float"> <Default = 10.0>>
		<fade_in_duration = <Name = "Fade-in duration (s)"> <Type = "Float"> <Default = 3.0>>
		<fade_out_duration = <Name = "Fade-out duration (s)"> <Type = "Float"> <Default = 2.0>>
	>
>*/
	clock				=	0

	camera_prefix		=	"Camera"
	slide_duration		=	10.0
	fade_in_duration	=	3.0
	fade_out_duration	=	2.0

	switch_camera		=	false
	current_camera		=	0

	function	OnUpdate(scene)
	{
		// No camera switch just wait for showcase end.
		if	(!switch_camera)
		{
			// On timeout trigger a fade out and reset.
			if	((g_clock - clock) > SecToTick(slide_duration))
			{
				scene.ui().setCommandList("globalfade " + fade_out_duration + ", 1;")
				switch_camera = true
				clock = g_clock
			}
		}
		else
			// At this point we just wait for the fade out command to complete.
			if	(scene.ui().isCommandListDone())
			{
				// Switch to the next camera.
				current_camera++
				local	camera = scene.findItem(camera_prefix + current_camera)

				if	(camera.isNull())
				{
					current_camera = 0;
					camera = scene.findItem(camera_prefix + current_camera)
				}
				if	(camera.isValid())
					scene.setCurrentCamera(camera)

				// Then fade back in.
				scene.ui().setCommandList("globalfade " + fade_in_duration + ", 0;")
				switch_camera = false
			}
	}

	function	OnSetup(scene)
	{
		clock = g_clock
		scene.ui().setGlobalFade(1)
		scene.ui().setCommandList("globalfade " + fade_in_duration + ", 0;")
	}
}
