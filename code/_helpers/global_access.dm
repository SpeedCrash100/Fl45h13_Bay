// THIS FILE IS AUTOMATICALLY CREATED BY tools/gen_globals.py
/proc/readglobal(which)
	switch(which)
		if("GLOB")
			return global.GLOB;
		if("Master")
			return global.Master;
		if("SSantagonists")
			return global.SSantagonists;
		if("SSatoms")
			return global.SSatoms;
		if("SScharacter_setup")
			return global.SScharacter_setup;
		if("SSgarbage")
			return global.SSgarbage;
		if("SSmaterials")
			return global.SSmaterials;
		if("_all_globals")
			return global._all_globals;
		if("forum_activated_group")
			return global.forum_activated_group;
		if("forum_authenticated_group")
			return global.forum_authenticated_group;
		if("forumsqladdress")
			return global.forumsqladdress;
		if("forumsqldb")
			return global.forumsqldb;
		if("forumsqllogin")
			return global.forumsqllogin;
		if("forumsqlpass")
			return global.forumsqlpass;
		if("forumsqlport")
			return global.forumsqlport;
		if("init")
			return global.init;
		if("sqladdress")
			return global.sqladdress;
		if("sqldb")
			return global.sqldb;
		if("sqlfdbkdb")
			return global.sqlfdbkdb;
		if("sqlfdbklogin")
			return global.sqlfdbklogin;
		if("sqlfdbkpass")
			return global.sqlfdbkpass;
		if("sqllogging")
			return global.sqllogging;
		if("sqllogin")
			return global.sqllogin;
		if("sqlpass")
			return global.sqlpass;
		if("sqlport")
			return global.sqlport;
		
/proc/writeglobal(which, newval)
	switch(which)
		if("GLOB")
			global.GLOB=newval;
		if("Master")
			global.Master=newval;
		if("SSantagonists")
			global.SSantagonists=newval;
		if("SSatoms")
			global.SSatoms=newval;
		if("SScharacter_setup")
			global.SScharacter_setup=newval;
		if("SSgarbage")
			global.SSgarbage=newval;
		if("SSmaterials")
			global.SSmaterials=newval;
		if("_all_globals")
			global._all_globals=newval;
		if("forum_activated_group")
			global.forum_activated_group=newval;
		if("forum_authenticated_group")
			global.forum_authenticated_group=newval;
		if("forumsqladdress")
			global.forumsqladdress=newval;
		if("forumsqldb")
			global.forumsqldb=newval;
		if("forumsqllogin")
			global.forumsqllogin=newval;
		if("forumsqlpass")
			global.forumsqlpass=newval;
		if("forumsqlport")
			global.forumsqlport=newval;
		if("init")
			global.init=newval;
		if("sqladdress")
			global.sqladdress=newval;
		if("sqldb")
			global.sqldb=newval;
		if("sqlfdbkdb")
			global.sqlfdbkdb=newval;
		if("sqlfdbklogin")
			global.sqlfdbklogin=newval;
		if("sqlfdbkpass")
			global.sqlfdbkpass=newval;
		if("sqllogging")
			global.sqllogging=newval;
		if("sqllogin")
			global.sqllogin=newval;
		if("sqlpass")
			global.sqlpass=newval;
		if("sqlport")
			global.sqlport=newval;
		
/var/list/_all_globals=list(
	"GLOB",
	"Master",
	"SSantagonists",
	"SSatoms",
	"SScharacter_setup",
	"SSgarbage",
	"SSmaterials",
	"_all_globals",
	"forum_activated_group",
	"forum_authenticated_group",
	"forumsqladdress",
	"forumsqldb",
	"forumsqllogin",
	"forumsqlpass",
	"forumsqlport",
	"init",
	"sqladdress",
	"sqldb",
	"sqlfdbkdb",
	"sqlfdbklogin",
	"sqlfdbkpass",
	"sqllogging",
	"sqllogin",
	"sqlpass",
	"sqlport")
