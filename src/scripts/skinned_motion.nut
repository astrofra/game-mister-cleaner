class	SkinnedMotion
{
/*<
	<Script =
		<Name = "Play Motion">
		<Author = "Emmanuel Julien">
		<Description = "Play a motion.">
		<Category = "Motion">
		<Compatibility = <Item>>
	>
	<Parameter =
		<motion = <Name = "Motion"> <Type = "ItemMotion">>
		<loop_motion = <Name = "Loop motion."> <Type = "Bool"> <Default = True>>
		<custom_loop = <Name = "Set loop point."> <Type = "Bool"> <Default = False>>
		<loop_start = <Name = "Loop Start"> <Type = "Float"> <Default = 0.0>>
		<loop_end = <Name = "Loop End"> <Type = "Float"> <Default = 0.0>>
	>
>*/

	motion			=	"motion"
	loop_motion		=	false
	custom_loop		=	false
	loop_start		=	0.0
	loop_end		=	0.0
	scene			=	0

	function	OnSetup(item)
	{

		print("SkinnedMotion::OnSetup() : GroupSetMotion('" + motion + "')")
		scene	= ItemGetScene(item)
		local	source = GroupSetMotion(SceneFindGroup(scene, "Biped"), motion, 0.0)

		if	(loop_motion)
			AnimationSourceSetLoopMode(source, AnimationRepeat)
		if	(custom_loop)
			AnimationSourceSetLoop(source, loop_start, loop_end)
	}
}
