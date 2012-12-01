class TMusic
{
    mixer                =    0
    music_channel        =    -1
	music_filename 		= ""
	music_sample		=	0
	is_wav_file			= false

    constructor()
    {
    	print("TMusic::constructor()")
        mixer    =    EngineGetMixer(g_engine)
    }


	function Create(fname)
	{
		this.music_filename = fname
		print("TMusic::Create() File = " + music_filename)

		if ((music_filename.slice(music_filename.len() - 4, music_filename.len())) == ".ogg")
		{
			is_wav_file = false
			print("TMusic::Create() File is in OGG format.")
		}
		else
		{
			is_wav_file = true
			print("TMusic::Create() File is in WAV format.")
		}
	}
 
    function PlayMusic(music_loop_mode = LoopRepeat)
    {
        if (music_channel == -1) music_channel = MixerChannelLock(mixer)
        
        if (is_wav_file)
        {
	        this.music_sample = EngineLoadSound(g_engine, this.music_filename)
			MixerChannelStart(mixer, music_channel, this.music_sample)
        }
        else
	        MixerChannelStartStream(mixer, music_channel, this.music_filename)
	        
        MixerChannelSetGain(mixer, music_channel, 0.5)
        MixerChannelSetLoopMode(mixer, music_channel, music_loop_mode)
        
        print("TMusic::PlayMusic('" + this.music_filename + "') playing on channel " + music_channel)
    }
    
    function	GetMusicDuration()
    {
		if (is_wav_file)
			return (SoundGetDuration(music_sample).tofloat() / 1000.0)
		else
			return (-1)
	}
    
    function	StopMusic()
    {
    	MixerChannelStop(mixer, music_channel)
    	MixerChannelUnlock(mixer, music_channel)
    	this.music_channel = -1
    	this.music_sample = 0
	}
    
}