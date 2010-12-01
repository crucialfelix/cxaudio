
// see sampler
// synth stays open and retrigs the sample multiple times

Instr([\samplerf,\rlpf,\rq],{ arg sample,trig,envpercshort,fenv,rq=0.5,pchRatio=1.0,
		beatStart=0.0,ffreqMul=2000.0,ffreqAdd=40.0;

		Enveloper2.ar(

			RLPF.ar(
				PlayBuf.ar(
					sample.numChannels,
					sample.bufnumKr,
					sample.bufRateScaleKr * pchRatio,
		 		  	trig,
		 		  	// offset
		 		  	beatStart * sample.beatsizeIr,
		 		  	0.0
		 		  ),
		 		  EnvGen.kr(fenv,trig,ffreqMul,ffreqAdd),
		 		  rq)

	 	,trig,envpercshort)

},nil,\audio);


Instr([\samplerf,\rlpf,\rqenv],{ arg sample,trig,envpercshort,fenv,rqenv,pchRatio=1.0,
		beatStart=0.0,ffreqMul=2000.0,ffreqAdd=40.0;

		Enveloper2.ar(
			RLPF.ar(
				PlayBuf.ar(
		 		 	sample.numChannels,
		 		  	sample.bufnumKr,
		 		  	// pitch
					sample.bufRateScaleKr * pchRatio,
					trig,
		 		  	// offset
		 		  	beatStart * sample.beatsize,
					0.0 // no loop
		 		  ),
		 		  EnvGen.kr(fenv,trig,ffreqMul,ffreqAdd),
		 		  EnvGen.kr(rqenv,trig)
	 		 )
	 	,trig,envpercshort)
},nil,\audio);



Instr([\samplerf,\rlpf4,\rq],{ arg sample,trig,envpercshort,envlinen,rq=0.5,pchRatio=1.0,
		beatStart=0.0,ffreq4Mul=0.8,ffreq4Add=0.0;

		Enveloper2.ar(
			RLPF.ar(
			PlayBuf.ar(
	 		 	sample.numChannels,
	 		  	sample.bufnumKr,
	 		  	// pitch
				sample.bufRateScaleKr * pchRatio,
				trig,
	 		  	// offset
	 		  	beatStart * sample.beatsize,
				0.0 // no loop
	 		  ),
	 		  EnvGen.kr(envlinen,trig,\freq.asSpec.map(ffreq4Mul),\freq.asSpec.map(ffreq4Add)),
	 		  rq)
	 	,trig,envpercshort)

},[
//	nil,nil,nil,nil,nil,nil,nil,
//	StaticSpec(0.0,1.0),
//	StaticSpec(0.0,1.0)
],\audio);

Instr([\samplerf,\rlpf4,\rqenv],{ arg sample,trig,envpercshort,envlinen,rqenv,pchRatio=1.0,
		beatStart=0.0,ffreq4Mul=0.8,ffreq4Add=0.0;

		Enveloper2.ar(
			RLPF.ar(
				PlayBuf.ar(
		 		 	sample.numChannels,
		 		  	sample.bufnumKr,
		 		  	// pitch
					sample.bufRateScaleKr * pchRatio,
					trig,
		 		  	// offset
		 		  	beatStart * sample.beatsize,
					0.0 // no loop
		 		  ),
		 		  EnvGen.kr(envlinen,trig,\freq.asSpec.map(ffreq4Mul),
		 		  							\freq.asSpec.map(ffreq4Add)),
		 		  EnvGen.kr(rqenv,trig)
	 		 )
	 	,trig,envpercshort)
},[
//	nil,nil,nil,nil,nil,nil,nil,
//	StaticSpec(0.0,1.0),
//	StaticSpec(0.0,1.0)
],\audio);





Instr([\samplerf,\lpf],{ arg sample,trig,envpercshort,fenv,pchRatio=1.0,
		beatStart=0.0,ffreqMul=2000.0,ffreqAdd=40.0;

		Enveloper2.ar(
			LPF.ar(
				PlayBuf.ar(
		 		 	sample.numChannels,
		 		  	sample.bufnumKr,
		 		  	// pitch
					sample.bufRateScaleKr * pchRatio,
					trig,
		 		  	// offset
		 		  	beatStart * sample.beatsize,
					0.0 // no loop
		 		  ),
		 		  EnvGen.kr(fenv,trig, ffreqMul,ffreqAdd)
		 	),
		trig,envpercshort)

},nil,\audio);



Instr([\samplerf,\hpf],{ arg sample,trig,envpercshort,fenv,pchRatio=1.0,
		beatStart=0.0,ffreqMul=2000.0,ffreqAdd=40.0;

		Enveloper2.ar(
			HPF.ar(
				PlayBuf.ar(
		 		 	sample.numChannels,
		 		  	sample.bufnumKr,
		 		  	// pitch
					sample.bufRateScaleKr * pchRatio,
					trig,
		 		  	// offset
		 		  	beatStart * sample.beatsize,
					0.0 // no loop
		 		  ),
		 		  EnvGen.kr(fenv,trig, ffreqMul,ffreqAdd)
		 	)
	 	,trig,envpercshort)

},nil,\audio);

Instr([\samplerf,\rhpf,\rq],{ arg sample,trig,envpercshort,fenv,rq=0.5,pchRatio=1.0,
		beatStart=0.0,ffreqMul=2000.0,ffreqAdd=40.0;


		Enveloper2.ar(
			RHPF.ar(
				PlayBuf.ar(
		 		 	sample.numChannels,
		 		  	sample.bufnumKr,
		 		  	// pitch
					sample.bufRateScaleKr * pchRatio,
					trig,
		 		  	// offset
		 		  	beatStart * sample.beatsize,
					0.0 // no loop
		 		  ),
		 		  EnvGen.kr(fenv,trig, ffreqMul,ffreqAdd),
		 		  rq
		 	)
	 	,trig,envpercshort)

},nil,\audio);



Instr([\samplerf,\rhpf,\rqenv],{ arg sample,trig,envpercshort,fenv,rqenv,pchRatio=1.0,
		beatStart=0.0,ffreqMul=2000.0,ffreqAdd=40.0;

		Enveloper2.ar(
			RHPF.ar(
				PlayBuf.ar(
		 		 	sample.numChannels,
		 		  	sample.bufnumKr,
		 		  	// pitch
					sample.bufRateScaleKr * pchRatio,
					trig,
		 		  	// offset
		 		  	beatStart * sample.beatsize,
					0.0 // no loop
		 		  ),
		 		  EnvGen.kr(fenv,trig, ffreqMul,ffreqAdd),
		 		  EnvGen.kr(rqenv,trig)
		 	)
	 	,trig,envpercshort)

},nil,\audio);


