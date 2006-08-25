

Instr("reverbs.reverberator3",{
		 arg input, //stereo or mono
		 	revBalance=0.0,// 0..1
		 	
		 	revTime=4,
		 	taps=10,
		 	combs=6,
		 	allpasses=4,
		 	tapsMin=0.01,
		 	tapsMax=0.07,
		 	combsMin=0.5,
		 	combsMax=0.3,
		 	allpassMin=0.01,
		 	allpassMax=0.05,
		 	allpassDecay=1.0;
		
		var 	tapsOut,out,tapsLevelMax,combinput,combLevelMax;

		if(taps > 0,{
			tapsLevelMax = taps.reciprocal;// divide by zero if you move this up
	
			tapsOut = 
				Mix.arFill(taps,{
					var delays;
					delays = rrand(tapsMin,tapsMax);
					DelayN.ar(input,delays,delays,tapsLevelMax.rand)
				}) + input
		},{
			tapsOut = input;
		});
		
		
		// 0 possible
		combs.do({ arg ci;
			var times;
			times = rrand(combsMin,combsMax);
			if(combinput.isNil, { //first time thru
				combLevelMax = combs.reciprocal; // first time, else possible div by 0
				combinput = tapsOut;
				out = CombC.ar(  
							combinput,times,times,
							revTime,combLevelMax.rand)
			},{
				out = out + CombC.ar( 
							combinput,times,times,
							revTime,combLevelMax.rand)
			})
		});
		
		// 0 possible
		allpasses.do({ arg i;
			var times;
			times = 	[rrand(allpassMin,allpassMax),rrand(allpassMin,allpassMax)];

			if(out.notNil,{
		 		out = AllpassC.ar(
			 			out,
					 	// first time thru its possibly still mono, 
		 				// then it expands to stereo and each subsequent is paired up to that expansion
		
			 			times,
			 			times,
			 			allpassDecay) 
			
		 	},{ // no taps or combs
		 		out = AllpassC.ar(
		 			input, 
					 	// first time thru its possibly still mono, 
		 				// then it expands to stereo and each subsequent is paired up to that expansion
		 			times,
			 		times,
		 			allpassDecay) 
		 	})
		 });
		XFader.ar(input,out,revBalance)
	},[
		\audio,
		\unipolar,
		StaticIntegerSpec(0,20),
		StaticIntegerSpec(0,20),
		StaticIntegerSpec(0,20),
		StaticSpec(0.0001,0.5),
		StaticSpec(0.0001,1.0),
		StaticSpec(0.0001,0.5),
		StaticSpec(0.0001,1.0),
		StaticSpec(0.0001,0.5),
		StaticSpec(0.0001,1.0),
		ControlSpec(0,10.0)
	],
		\stereoEffect
	);
	
	