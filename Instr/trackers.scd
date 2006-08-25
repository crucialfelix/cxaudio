
/*
	take audio input
	track the pitch or amplitude
	add synths, efx
	and return
*/

//these were all tuned to voice, so a bit quiet for other things

// make them stereo again !

Instr([\trackers,\tri],{ arg audio;

	var in, amp, freq, hasFreq, out,mul=0.4;
	in = Mix.ar(audio);
	amp = Amplitude.kr(in, mul: mul);
	# freq, hasFreq = Pitch.kr(in);
	freq = freq.cpsmidi.round(1.0).midicps;
	out = Mix.ar( LFTri.ar(freq * [0.5, 1, 2]) ) * amp;
	6.do({ 
		out = AllpassN.ar(out, 0.040, [Rand(0.001,0.040),Rand(0.001,0.040)], 2) 
	});
	out
},
	[
		\audio
	],
	\audioEffect
);



Instr([\trackers,\triscale],{ arg audio,mul=0.4,root=80;

	var in, amp, freq, hasFreq, out,degree;
	in = Mix.ar(audio);
	amp = Amplitude.kr(in, mul: mul);
	# freq, hasFreq = Pitch.kr(in);
	degree = freq.cpsmidi.round(1.0); //treat it like a degree
	freq = DegreeToKey.kr(FloatArray[ 1, 2, 3, 7, 8, 9, 10 ],degree,12,1,root);
	out = Mix.ar( SinOsc.ar(freq  +  LFNoise1.kr([3,3,3], 0.04)) ) * amp;
	6.do({ 
		out = AllpassN.ar(out, 0.040, [Rand(0.001,0.040),Rand(0.001,0.040)], 2) 
	});
	out
},[
	\audio,
	[0.0,3.0],
	[0.0,120,\linear,1]
],
	\audioEffect
);

/*  needs the scale
Instr([\trackers,\triscaleq],{ arg audio,mul=0.4,root=80,trig;

	var in, amp, freq, hasFreq, out,degree;
	in = Mix.ar(audio);
	amp = Amplitude.kr(in, mul: mul);
	# freq, hasFreq = Pitch.kr(in);
	degree = freq.cpsmidi.round(1.0); //treat it like a degree
	freq = DegreeToKey.kr(FloatArray[ 1, 2, 3, 7, 8, 9, 10 ],degree,12,1,root);
	freq = Latch.kr(freq,trig);
	out = Mix.ar( SinOsc.ar(freq +  LFNoise1.kr([3,3,3], 0.04)  )) * amp;
	6.do({ 
		out = AllpassN.ar(out, 0.040, [Rand(0.001,0.040),Rand(0.001,0.040)], 2) 
	});
	out
},[
	\audio,
	[0.0,3.0],
	[0.0,120,\linear,1]
]);
*/


Instr([\trackers,\formant],{ arg audio,formfreq=1087,bwfreq=160,mul=0.4;

	var in, amp, freq, hasFreq, out;
	in = Mix.ar(audio);
	# freq, hasFreq = Pitch.kr(in,median: 3);
	amp = Amplitude.kr(in, mul: mul * hasFreq);
	//freq = freq.cpsmidi.round(1.0).midicps;
	out = Mix.ar( Formant.ar(freq * [ 1, 2, 4],formfreq,bwfreq) ) * amp;
//	6.do({ 
//		out = AllpassN.ar(out, 0.040, [Rand(0.001,0.040),Rand(0.001,0.040)], 2) 
//	});
	out
},[
	\audio,\freq,\freq
],
	\audioEffect
);



Instr([\trackers,\reztrail],{ arg audio,rq=0.01,mul=1.0;

	var in, amp, freq, hasFreq, out,exc;
	in = Mix.ar(audio);
	# freq, hasFreq = Pitch.kr(in,median: 3);
	amp = Amplitude.kr(in,mul: mul);
	freq = freq.cpsmidi.round(1.0).midicps;
	exc = PinkNoise.ar(amp);
	out = Mix.ar(
		Resonz.ar(exc,freq * [1,1.5,3],rq  * (amp * 0.1))
	);
	6.do({ 
		out = AllpassN.ar(out, 0.040, [Rand(0.001,0.040),Rand(0.001,0.040)], 2) 
	});
	out
},[
	\audio
],
	\audioEffect
);



Instr([\trackers,\pelogklanx],{ arg audio,mul=0.03;

	var in, amp, freq, hasFreq, out,exc;
	in = audio;//Mix.ar(audio);
	//# freq, hasFreq = Pitch.kr(in,median: 3);
	amp = Amplitude.kr(in,mul: mul );
	//freq = freq.cpsmidi.round(1.0).midicps;
	exc = PinkNoise.ar(amp);
	out = Klank.ar(`[
				([0, 1, 3, 7, 8] + 80).midicps
			],exc
			);
			
//	out = Mix.ar(
//		Resonz.ar(exc,freq * [1,1.5,3],rq  * (amp * 0.1))
//	);
//	6.do({ 
//		out = AllpassN.ar(out, 0.040, [Rand(0.001,0.040),Rand(0.001,0.040)], 2) 
//	});
	out
},[
	\audio
],
	\audioEffect
);



Instr([\trackers,\snowdout],{ arg audio,note=40,mul=0.03,rq=0.01;

	var in, amp, freq, hasFreq, out,exc,degree;
	in = audio;//Mix.ar(audio);
	# freq, hasFreq = Pitch.kr(in,median: 1);
	amp = Amplitude.kr(in,mul: mul * hasFreq);
	amp = Decay2.kr(amp);
	degree = freq.cpsmidi.round(1.0);
	degree = (degree + [0, 1, 3, 7, 8] + note);
	exc = WhiteNoise.ar(amp);
	out = Resonz.ar( exc, 
					degree.midicps,
					rq
				);
	Mix.ar(out)

},[
	\audio,[0,80,\linear,1]
],
	\audioEffect
);



Instr([\trackers,\crackld],{ arg audio,note=40,chaosParam=1.5,mul=0.03,rq=0.01,decay=3.0;

	var in, amp, freq, hasFreq, out,exc,degree;
	in = Mix.ar(audio);
	# freq, hasFreq = Pitch.kr(in,median: 1);
	amp = Amplitude.kr(in,mul: mul * hasFreq);
	amp = Decay2.kr(amp,decayTime: decay);
	degree = freq.cpsmidi.round(1.0);
	degree = (degree + [0, 1, 3, 7, 8] + note);
	exc = Crackle.ar(chaosParam,mul:amp);
	out = Resonz.ar( exc,
					degree.midicps,
					rq
				);
	Mix.ar(out)

},[
	\audio,
	[0,80,\linear,1],
	[0.9,2.0]
],
	\audioEffect
);


// this is an effect, won't make sound unless patched with something
Instr([\trackers,\crossRez],{ arg audio2,audio, note=40,mul=0.03,rq=0.01,decay=3.0;

	var in, amp, freq, hasFreq, out,exc,degree;
	in = Mix.ar(audio);
	# freq, hasFreq = Pitch.kr(in,median: 1);
	amp = Amplitude.kr(in,mul: mul * hasFreq);
	amp = Decay2.kr(amp,decayTime: decay);
	degree = freq.cpsmidi.round(1.0);
	degree = (degree + [0, 1, 3, 7, 8] + note);

	exc = audio2;
	
	out = Resonz.ar( exc,
					degree.midicps,
					rq
				);
	Mix.ar(out)

},[
	\audio,
	\audio, 
	[0,80,\linear,1]
],
	\audioEffect
);



//Instr.at(\trackers).values.do({ arg instr;
//	Patch(instr.name,[nil]).topGui;
//});
//
//
//
//
