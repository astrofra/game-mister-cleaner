/*
	File: C:/works/3d/games/svn_mr_cleaner/game_shiftbomber/Scripts/level_game_introduction.nut
	Author: Astrofra
*/

Include("Scripts/locale.nut") 

//-----------------------------------
function	IntroductionThreadWait(s)
{
	local	_timeout

	_timeout = g_clock
				
	while ((g_clock - _timeout) < SecToTick(Sec(s)))
		suspend()
}

	function CreateInfoText()
	{
		local txt_key = THUD_Text()
		txt_key.Create("HEMIHEAD")
		txt_key.SetFontColor(255,255,255,255)
		txt_key.SetFontSize(32)
		txt_key.SetText(locale.press_to_skip)
		txt_key.SetPosition(32,32)
		return txt_key
	}

	function	CreateSubtitle(ui, name, x, y, size = 32, w = 600, h = 64)
	{
		// Create UI window.
		local	window = UIAddWindow(ui, -1, x, y, w, h)

		// Center window pivot.
		WindowSetPivot(window, w / 2, h / 2)
		WindowSetBackgroundColor(window, 0x7f000000)

		// Create UI text widget and set as window base widget.
		local	widget = UIAddStaticTextWidget(ui, -1, name, "lvnmbd")
		WindowSetBaseWidget(window, widget)

		// Set text attributes.
		TextSetSize(widget, size)
		TextSetColor(widget, 255, 255, 255, 255)
		TextSetAlignment(widget, TextAlignCenter)

		// Return window.
		return [ window, widget ]
	}

function	SubtitlesThread(current_scene)
{
	local	_timeline		=	0,
			time_interval	=	0.0,
			prev_time		=	0.0

	_timeline	=	[
		{ t = 2.20, subtitle = locale.intro_sub_00 }
		{ t = 5.15, subtitle = locale.intro_sub_01 }
		{ t = 6.95, subtitle = "" }
		{ t = 8.25, subtitle = locale.intro_sub_02 }
		{ t = 11.0, subtitle = locale.intro_sub_03 }
		{ t = 15.3, subtitle = locale.intro_sub_04 }
		{ t = 17.7, subtitle = locale.intro_sub_05 }
		{ t = 21.45, subtitle = "" }
		{ t = 22.4, subtitle = locale.intro_sub_06 }
		{ t = 24.5, subtitle = locale.intro_sub_07 }
		{ t = 27.5, subtitle = locale.intro_sub_08 }
		{ t = 31.5, subtitle = locale.intro_sub_09 }
	]

	local txt_sub = CreateSubtitle(SceneGetUI(current_scene), "", 640, 900, 28, 2048, 80)
	local txt_skip = CreateInfoText()

	WindowSetOpacity(txt_skip.window, 0)
	WindowSetCommandList(txt_skip.window, "nop 1.5; toalpha 2, 1; nop 6; toalpha 2, 0;")

	foreach (idx, _keyframe in _timeline)
	{
/*		if (idx >= _timeline.len())
			time_interval = 0.0
		else
			time_interval = _timeline[idx + 1].t - _keyframe.t*/
		time_interval = _keyframe.t - prev_time

		IntroductionThreadWait(time_interval)
		TextSetText(txt_sub[1], _keyframe.subtitle)
		print("SubtitlesThread::Sub = " + _keyframe.subtitle)

		prev_time = _keyframe.t
	}
}

//-----------------------------
function	CameraThread(current_scene)
{
	local	camera_list 		=	[],
			camera_timeline		=	0

	for(local n = 0; n < 7; n++)
		camera_list.append(SceneFindItem(current_scene, "camera_" + n.tostring()))

	camera_timeline	=	[
		{ t = 0.0, cam = 1, direction = 1.0 }
		{ t = 4.65, cam = 3, direction = -1.0   } // Something gone wrong...
		{ t = 8.15, cam = 6, direction = 1.0   } // The boys here ...
		{ t = 10.65, cam = 2, direction = -1.0   } // They said it's not dangerous...
		{ t = 15.0, cam = 3, direction = 1.0  } // But still
		{ t = 22.0, cam = 1, direction = 1.0   }
//		{ t = 24.0, cam = 4, direction = -1.0   }
		{ t = 27.425, cam = 5, direction = 1.00   }
		{ t = 31.5, cam = 6, direction = 1.0   }
		{ t = 36.5, cam = 0, direction = 1.0   }
	]

	local	prev_cam = 0,
			time_interval = 0.0,
			angle_min, angle_max

	foreach (idx, camera_keyframe in camera_timeline)
	{
		if (idx >= camera_timeline.len())
			time_interval = 0.0
		else
			time_interval = camera_timeline[idx + 1].t - camera_keyframe.t

		//	Camera Animation
		{
			local	_timeout, t_norm, cam_pivot
				
			cam_pivot = SceneFindItem(current_scene, "cam_pivot")

			ItemSetPosition(cam_pivot, Vector(0,0,0))
			ItemSetRotation(cam_pivot, Vector(0,0,0))

			ItemSetParent(camera_list[camera_keyframe.cam], cam_pivot)

			angle_min = -15.0 / time_interval
			angle_max = 15.0 / time_interval

			_timeout = g_clock
			print("time_interval = " + time_interval)
	
			SceneSetCurrentCamera(current_scene, ItemCastToCamera(camera_list[camera_keyframe.cam]))

			while ((g_clock - _timeout) < SecToTick(Sec(time_interval)))
			{
				t_norm = (g_clock - _timeout) / SecToTick(Sec(time_interval))
				ItemSetRotation(cam_pivot, Vector(0, camera_keyframe.direction * DegreeToRadian(Lerp(t_norm, angle_min, angle_max)), 0))
				suspend()
			}
		}
		print("CameraThread() Set Camera #" + camera_keyframe.cam + " @ t = " + camera_keyframe.t)
	} 

	suspend()
}

//-----------------------------
function	LipsyncThread(current_scene)
{
	local	_timeline		=	0,
			_lips_light		=	0,
			mouth_material, _item_zentrum

	_timeline	=	[
{ t = 0.0, i = 0.0  }

{ t = 2.378, i = 1.0  }
{ t = 4.430, i = 0.0  }

{ t = 5.245, i = 1.0  }
{ t = 6.143, i = 0.0  }

{ t = 8.330, i = 1.0  }
{ t = 10.235, i = 0.0  }

{ t = 11.035, i = 1.0  }
{ t = 14.45, i = 0.0  }

{ t = 15.4, i = 1.0  }
{ t = 16.960, i = 0.0  }

{ t = 17.8, i = 1.0  }
{ t = 18.5, i = 0.0  }

{ t = 18.884, i = 1.0  }
{ t = 20.128, i = 0.0  }

{ t = 22.505, i = 1.0  }
{ t = 24.275, i = 0.0  }

{ t = 24.605, i = 1.0  }
{ t = 26.259, i = 0.0  }

{ t = 27.787, i = 1.0  }
{ t = 29.728, i = 0.0  }

{ t = 31.70, i = 1.0  }
{ t = 32.439, i = 0.0  }

{ t = 32.82, i = 1.0  }
{ t = 33.678, i = 0.0  }

{ t = 35.0, i = 0.0  }
	]

	_item_zentrum = SceneFindItem(current_scene, "zentrum_body_skinned")
	mouth_material = GeometryGetMaterialFromIndex(ItemGetGeometry(_item_zentrum), 1)

	local	prev_time = 0.0, 
			_prev_i = 0.0,
			time_interval
			
	_lips_light	=	ItemCastToLight(SceneFindItem(current_scene, "lips_light"))

	LightSetDiffuseIntensity(_lips_light, 0.0)

//	foreach (_keyframe in _timeline)
//		_keyframe.t -= Sec(1.0)

	foreach (_keyframe in _timeline)
	{
		LightSetDiffuseIntensity(_lips_light, 0.0 * _keyframe.i)
		local	_i = 1.0,
				_timeout, _i_rand = 1.0

		time_interval = _keyframe.t - prev_time
		_timeout = g_clock

		local	_mouth_switch = false

		while ((g_clock - _timeout) < SecToTick(Sec(time_interval)))
		{
			_i -= (g_dt_frame * 0.25)
			_i = Max(_i, 0.0)
			if (Rand(0.0, 100.0) > 80)
				_i_rand = Rand(0.75, 1.25)
			local	_voice_intensity, _voice_scroll
			_voice_intensity = _i * _i_rand * _prev_i
			_voice_scroll = (((_voice_intensity * 100.0).tointeger()).tofloat()) * 0.005
			LightSetDiffuseIntensity(_lips_light, _voice_intensity)

			if ((_mouth_switch) && (Rand(0.0,100.0) < 60.0))
				MaterialSetSelfIllum(mouth_material, Vector(1,1,1).Scale(_voice_scroll))

			_mouth_switch = !_mouth_switch
			suspend()
		}
		
		//IntroductionThreadWait(time_interval)
		print("LipsyncThread() Keyframe @ t = " + _keyframe.t)
		prev_time = _keyframe.t
		_prev_i = _keyframe.i
	}

	suspend()
}

function	PropsThread(current_scene)
{
		print("PropsThread()")
		local	core_list = [],
				main_light, red_light,
				player_item,
				_timeout,
				time_interval,
				time_norm,
				thread_timer,
				rings = [],
				v_ring

		thread_timer = g_clock

		local	ui = SceneGetUI(current_scene)
		UISetCommandList(ui, "globalfade 1, 0;")

		main_light = ItemCastToLight(SceneFindItem(current_scene, "mainlight"))
		red_light = ItemCastToLight(SceneFindItem(current_scene, "red_light"))
		player_item = SceneFindItem(current_scene, "player_item")
		for (local n = 0; n < 3; n++)
		{
			rings.append(SceneFindItem(current_scene, "alpha_ring_" + n.tostring()))
			ItemActivate(rings[n], false)
		}

		v_ring = SceneFindItem(current_scene, "alpha_circles")
		ItemActivate(v_ring, false)

		ItemActivate(LightGetItem(main_light), false)
		ItemActivate(LightGetItem(red_light), false)
		ItemActivate(player_item, false)
		
		//	Get all "nuclear core" items
		{
			local	_tmp_list
			_tmp_list = SceneGetItemList(current_scene)

			foreach(_item in _tmp_list)
				if (ItemGetName(_item) == "core_item")
					core_list.append(_item)
		}

		print("PropsThread() : found " + core_list.len() + " nuclear core items.")

		//	Hide items
		foreach(_item in core_list)
			ItemActivateHierarchy(_item, false)

		//	"Do you copy?"
		IntroductionThreadWait(Sec(2.5))

		local	_d_i, _s_i
		_d_i = LightGetDiffuseIntensity(main_light)
		_s_i = LightGetSpecularIntensity(main_light)

		LightSetDiffuseIntensity(main_light, 0.0)
		LightSetSpecularIntensity(main_light, 0.0)

		ItemSetOpacity(player_item, 0.0)

		ItemActivate(LightGetItem(main_light), true)
		ItemActivate(player_item, true)

		_timeout = g_clock
		time_interval = Sec(3.0)

		while ((g_clock - _timeout) < SecToTick(Sec(time_interval)))
		{
			time_norm = (g_clock - _timeout) / SecToTick(Sec(time_interval))
			LightSetDiffuseIntensity(main_light, _d_i * time_norm)
			LightSetSpecularIntensity(main_light, _s_i * time_norm)

			local	opacity_player
			opacity_player = RangeAdjustClamped(Pow(time_norm, 0.5), 0.05, 0.35, 0.0, 1.0)
			ItemSetOpacity(player_item, opacity_player)

			suspend()
		}

		ItemSetOpacity(player_item, 1.0)

		//	Something gone wrong
		while ((g_clock - thread_timer) < SecToTick(Sec(8.0)))
			suspend()


		ItemActivate(LightGetItem(red_light), true)

		local	_rand = 1.0
		while ((g_clock - thread_timer) < SecToTick(Sec(11.0)))
		{
			if (Rand(0.0, 100.0) > 80.0)
				LightSetDiffuseIntensity(main_light, _d_i + _rand * Rand(-0.3, 0.3))
			else
				LightSetDiffuseIntensity(main_light, _d_i)

			LightSetDiffuseIntensity(red_light, Clamp((1.0 - _rand), 0.0, 1.0) * 6.0)
			LightSetSpecularIntensity(red_light,  Clamp((1.0 - _rand), 0.0, 1.0) * 0.5)

			_rand *= 0.985
			
			suspend()
		}

		//	The boys here
		//	Show items
		foreach(_item in core_list)
		{
			ItemActivateHierarchy(_item, true)
			ItemSetCommandList(_item, "toscale 0,1,2.5,1;toalpha 0,0;toscale 0.2,1,1,1+toalpha 0.2,1.0;")
			IntroductionThreadWait(0.025 + Rand(0.025, 0.1))
		}

		while ((g_clock - thread_timer) < SecToTick(Sec(22.5)))
			suspend()

		//	We are sending you....
		//ItemSetOpacity(v_ring, 0.0)
		ItemActivate(v_ring, true)
		ItemSetCommandList(v_ring, "toscale 1,1,5,1+offsetposition 1,0,20,0+toalpha 1,0;")

		foreach (_ring in rings)
		{
			ItemSetOpacity(_ring, 0.0)
			ItemActivate(_ring, true)
			ItemSetCommandList(_ring, "toalpha 2,1+toscale 2,15,1,15;toalpha 2,0+toscale 2,30,1,30;")
			IntroductionThreadWait(0.1)
		}

		while ((g_clock - thread_timer) < SecToTick(Sec(27.5)))
			suspend()

		//	Hide items
		foreach(n, _item in core_list)
		{
			//ItemActivateHierarchy(_item, true)
			ItemSetCommandList(_item, "toscale 0.1,1,10,1+toalpha 0.2,0.0;")
			local light_i = (1.0 - (n.tofloat() / core_list.len().tofloat()))
			LightSetDiffuseIntensity(red_light, light_i * 6.0)
			LightSetSpecularIntensity(red_light, light_i * 0.5)
			IntroductionThreadWait(0.025)
		}

		ItemActivate(LightGetItem(red_light), false)


		while ((g_clock - thread_timer) < SecToTick(Sec(32)))
			suspend()

		UISetCommandList(ui, "globalfade 1, 1;")

		suspend()
		
}

/*!
	@short	GameIntroduction
	@author	Astrofra
*/
class	GameIntroduction
{
	project_instance 	=	0
	intro_duration		=	Sec(36)
	intro_timer			=	0
	InputKey 			=	0
	current_scene		=	0

	thread_list			=	0
	
	constructor()
	{

		InputKey = TKeyboard();
	}
	
	/*!
		@short	OnUpdate
		Called each frame.
	*/
	function	OnUpdate(scene)
	{
		//print("OnUpdate() : t = " + (TickToSec(g_clock - intro_timer)).tostring())
		if ((this.InputKey.IsUp(KeySpace)) || (g_clock - intro_timer > SecToTick(Sec(intro_duration))))
		{	
			print("EXIT from INTRODUCTION SCREEN")
			g_music_bkg.StopMusic()
			g_game_command = "START"
		}

		HandleThreadList()
	}

	function	OnSetup(scene)
	{
		current_scene	= scene
		thread_list		= []

		UISetGlobalFadeEffect(SceneGetUI(scene), 1)
	}

	/*!
		@short	OnSetupDone
	*/
	function	OnSetupDone(scene)
	{
		intro_timer = g_clock
		intro_duration = g_music_bkg.GetMusicDuration()
		if (intro_duration == -1)
			intro_duration = Sec(36)
		print("GameIntroduction::OnSetupDone() intro_duration = " + intro_duration)

		thread_list.append({name = CameraThread, handle = 0})
		thread_list.append({name = LipsyncThread, handle = 0})
		thread_list.append({name = SubtitlesThread, handle = 0})
		thread_list.append({name = PropsThread, handle = 0})
		StartThreadList()

		g_music_bkg.Create("Sounds/music/music_intro_mix.wav")		
		g_music_bkg.PlayMusic(LoopNone);
	}

	//---------------------------
	function	StartThreadList()
	//---------------------------
	{
		foreach (_thread in thread_list)
		{
			_thread.handle = newthread(_thread.name)
			_thread.handle.call(current_scene)
		}
	}
	
	//-------------------------------
	function	HandleThreadList()
	//-------------------------------
	{
		foreach (_thread in thread_list)
		{
			if (_thread.handle == 0)
				return

			if (_thread.handle.getstatus() == "suspended")
				_thread.handle.wakeup()
			else
				_thread.handle = 0
		}
	}
	
	//-------------------------------
	function	HandleLipsyncThread()
	//-------------------------------
	{
		if (lipsync_thread == 0)
			return

		if (lipsync_thread.getstatus() == "suspended")
			lipsync_thread.wakeup()
		else
			lipsync_thread = 0
	}
}
