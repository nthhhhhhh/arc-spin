(

Server.default = Server.local;

s.waitForBoot({

    // create your arc object
    ~arc = Arc.new("/arc", 0);

    // choose your appropriate device
    ~arc.useDevice(0);

    // first argument is your arc object, second sets sensitivity
    ~arcKnobberInc = ArcKnobIncremental(~arc, 4);
    ~arcKnobberAbs = ArcKnobAbsolute(~arc, 6);

    OSCFunc.newMatching({ | message |

        var knob_n = message[1];  // reports which knob is rotating
        var delta = message[2];   // delta coming from rotating knob

        if(knob_n == 0){
            // will report position of led (0-63)
            "knob abs: % \n".postf(~arcKnobberAbs.spin(knob_n, delta));
        };

        if(knob_n == 1){
            // will report -1 if negative and 1 if positive
            "knob inc: % \n".postf(~arcKnobberInc.spin(knob_n, delta));
        };

    }, '/arc/enc/delta');

});

)

// turn off your device here if you'd like
~arc.darkness;
