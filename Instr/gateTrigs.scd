
// trig inputs, gate outputs

Instr([\gateTrigs,\Decay2],{ arg trig,attack=0.05,decay=0.2,max=4.0;

	var out;
	out = Decay2.kr(trig,attack,decay);

	if(max != 4.0,{
		out = out.min(4.0);
	});
	out
	
},[
	nil,nil,nil,[0.1,4.0]
],\gate);




Instr([\gateTrigs,\extend],{ arg trig,dur=0.2;

	Trig.kr(trig,dur)
	
},nil,\gate);


Instr([\gateTrigs,\invert],{ arg trig;

	1.0 - trig
	
},nil,\gate);


Instr([\gateTrigs,\ToggleFF],{ arg trig;
	
	ToggleFF.kr(trig)
	
},nil,\gate);

Instr([\gateTrigs,\SetResetFF],{ arg trig,trig2;
	
	SetResetFF.kr(trig,trig2);
	
},[
	\trig,
	\trig
],\gate);

Instr([\gateTrigs,\dustySetResetFF],{ arg settiness=5.0,resettiness=5.0;
	var a,b;
	a = Dust.ar(settiness); // the set trigger
	b = Dust.ar(resettiness); // the reset trigger
	SetResetFF.kr(a,b)
},[
	\density,
	\density
],\gate);


Instr([\gateTrigs,\delayedTimer],{ arg trig;

	// every trigger is timed, sets the duration of the next gate
			
	Trig.kr( trig, Timer.kr(trig ) )
	
},nil,\gate);



//Instr([\gateTrigs,\peakSensor],{ arg bipolar,tempoFactor=4,tempo;
//	
//	var sensor;
//	sensor = Latch.kr(bipolar,
//		Impulse.kr(tempo * (tempoFactor * 0.25)) 
//		//Impulse.kr(10)
//		);
//		
//	//(Integrator.kr(sensor,0.6) > 0.0) * sensor
//	sensor > 0.0
//},nil,\gate);




