#define mob2unique(mob) "[mob ? mob.ckey : GLOB.NO_CLIENT_CKEY][ascii2text(7)][mob ? (mob.real_name ? mob.real_name : mob.name) : ""][ascii2text(7)][any2ref(mob)]"
