class TSoundFX
{
	sound_files = 0 //[] Never define/declare an array inside a class definition
	sound_steam = 0 //[] See why here : http://gamestart3d.com/content/note-c-developers ("Inline Class Members Initialization")	
	sound_count = 0;//   The only variable type you can declare here is integer, float or boolean (and string, maybe ?)
	sound_mixer = 0;// What happened before is that the latest sfx loaded by you class overwrite the previously loaded one.
	volume = 100
	
	
	
	constructor()
	{
		this.sound_count=0;	
		sound_files = [] // This is where you have to create your array 
		sound_steam = [] // ... or vector, or table ...
	}
	
	function Create(sound_list)
	{
		
		this.sound_files = split(sound_list, "|");		
		this.sound_count = this.sound_files.len()
		//this.sound_mixer = MixerChannelLock(g_mixer)
		// Do not lock too much channels, you won't have any of them free after a few iterations
		// If you want to lock a channel for a specific FX, pay attention to unlock all the channels 
		// when the player ends a level, for example.
		
		for (local i=0;i<this.sound_count;i++)
		{
			print(this.sound_files[i]);
			this.sound_steam.append(EngineLoadSound(g_engine,this.sound_files[i]))
			
		}
		
	}
	
	
	function Play()
	{
		local id = Irand(0,this.sound_count)
		local	sfx_channel = MixerSoundStart(g_mixer, this.sound_steam[id]) // This instruction doesn't need a locked channel
		// but then you can't tweak the volume or pitch.
		//MixerChannelStart(g_mixer, this.sound_mixer, this.sound_steam[id])
		MixerChannelSetGain(g_mixer, sfx_channel, this.volume) 
		MixerChannelSetPanning(g_mixer, sfx_channel, 1.0)
		MixerChannelSetLoopMode(g_mixer, sfx_channel, LoopNone)
	}
}