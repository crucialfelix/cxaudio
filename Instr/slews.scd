
// using Slew for filter effects

// replace lost high end by more distortion
Instr("slews.slewhard",{ arg audio,drive=0.0,slewMax=12000,hardMax=7.0;

	var slope;
	slope = slewMax * (1.0 - drive); 	
	audio=Slew.ar(audio,slope,slope);
	HardShaper.ar(audio,drive * hardMax)
},#[
	\audio,
	[0.05,0.95],
	[1,12000,\exponential],
	[0.0,50.0]

],
	\audioEffect
);




Instr("slews.unslew",{ arg audio=0.0,freq=300;

	var slewed;
	slewed = Slew.ar(audio,freq,freq);
	audio - slewed
},[
	\audio,
	\ffreq
],
	\audioEffect
);


// yeah !!!!!! viscious !
Instr("slews.balance",{ arg audio=0.0,freq=300,slewv=1.0,restv=1.0;

	var slewed,rest;
	# slewed , rest = Instr.ar([\splits,\bySlew],[audio,freq]);
	if(restv != 1.0,{ rest = rest * restv });
	if(slewv != 1.0,{ slewed = slewed * slewv });
	
	Mix.ar([ rest,slewed])	
},#[
	\audio,
	\freq,
	[\drive],
	[\drive]
],
	\audioEffect
);



// delays everything
Instr("slews.backup",{ arg audio,slope=500,threshold=0.5,boost=0.3,drive=1.0;
	
	audio = Slew.ar(audio,slope,slope);
	Instr.ar([\dynamics,\upwardLim],[audio,threshold,boost,0.1,0.3,drive])
},#[
	\audio,
	[50,10000,\exponential]


]);


// aproximates
Instr("slews.backup2",{ arg audio,slope=500,invdrive=90;

	audio = Slew.ar(audio,slope,slope);
	audio * ( invdrive / slope)

},#[
	\audio,
	[50,10000,\exponential],
	\freq
],
	\audioEffect
);


// split by slew then slew limit each differently
// awesome !
Instr("slews.differentiate",{ arg audio=0.0,splitfreq=300,slewslope=12000,unslewslope=300,slewv=1.0,restv=1.0;

	var slewed,rest;
	# slewed , rest = Instr.ar([\splits,\bySlew],[audio,splitfreq]);
	slewed = Slew.ar(slewed,slewslope,slewslope);
	rest = Slew.ar(rest,unslewslope,unslewslope);
	
	if(restv != 1.0,{ rest = rest * restv });
	if(slewv != 1.0,{ slewed = slewed * slewv });
	
	Limiter.ar(
		Mix.ar([ rest,slewed])	
	)
},#[
	\audio,
	\freq,
	\ffreq,
	\ffreq,
	
	[0,2.0],
	[0,2.0]

],
	\audioEffect
);


