//This file was auto-corrected by findeclaration.exe on 29/05/2012 15:03:04

#define BOOK_VERSION_MIN	1
#define BOOK_VERSION_MAX	2
#define BOOK_PATH			"data/books/"
#define BOOKS_USE_SQL		0				// no guarentee for this branch to work right with sql

GLOBAL_DATUM_INIT(book_mgr, /datum/book_manager, new)

datum/book_manager/proc/path(id)
	if(isnum(id)) // kill any path exploits
		return "[BOOK_PATH][id].sav"

datum/book_manager/proc/getall()
	var/list/paths = flist(BOOK_PATH)
	var/list/books = new()

	for(var/path in paths)
		var/datum/archived_book/B = new(BOOK_PATH + path)
		books += B

	return books

datum/book_manager/proc/freeid()
	var/list/paths = flist(BOOK_PATH)
	var/id = paths.len + 101

	// start at 101+number of books, which will be correct id if none have been deleted, etc
	// otherwise, keep moving forward until we find an open id
	while(fexists(path(id)))
		id++

	return id

/client/proc/delbook()
	set name = "Delete Book"
	set desc = "Permamently deletes a book from the database."
	set category = "Admin"
	if(!src.holder)
		to_chat(src, "Only administrators may use this command.")
		return

	var/isbn = input("ISBN number?", "Delete Book") as num | null
	if(!isbn)
		return

	if(BOOKS_USE_SQL && GLOB.config.sql_enabled)
		var/DBConnection/dbcon = new()
		dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
		if(!GLOB.dbcon.IsConnected())
			alert("Connection to Archive has been severed. Aborting.")
		else
			var/DBQuery/query = GLOB.dbcon.NewQuery("DELETE FROM library WHERE id=[isbn]")
			if(!query.Execute())
				to_chat(usr, query.ErrorMsg())
			dbcon.Disconnect()
	else
		book_mgr.remove(isbn)
	log_admin("[usr.key] has deleted the book [isbn]")

// delete a book
datum/book_manager/proc/remove(var/id)
	fdel(path(id))

datum/archived_book
	var/author		 // Who wrote the thing, can be changed by pen or PC. It is not automatically assigned
	var/title		 // The real name of the book.
	var/category	 // The category/genre of the book
	var/id			 // the id of the book (like an isbn number)
	var/dat			 // Actual page content

	var/author_real	 // author's real_name
	var/author_key	 // author's byond key
	var/list/icon/photos	 // in-game photos used

// loads the book corresponding by the specified id
datum/archived_book/New(var/path)
	if(isnull(path))
		return

	var/savefile/F = new(path)

	var/version
	from_save(F["version"], version)

	if (isnull(version) || version < BOOK_VERSION_MIN || version > BOOK_VERSION_MAX)
		fdel(path)
		to_chat(usr, "What book?")
		return 0

	from_save(F["author"], author)
	from_save(F["title"], title)
	from_save(F["category"], category)
	from_save(F["id"], id)
	from_save(F["dat"], dat)

	from_save(F["author_real"], author_real)
	from_save(F["author_key"], author_key)
	from_save(F["photos"], photos)
	if(!photos)
		photos = new()

	// let's sanitize it here too!
	for(var/tag in paper_blacklist)
		if(findtext(dat,"<"+tag))
			dat = ""
			return


datum/archived_book/proc/save()
	var/savefile/F = new(book_mgr.path(id))

	to_save(F["version"], BOOK_VERSION_MAX)
	to_save(F["author"], author)
	to_save(F["title"], title)
	to_save(F["category"], category)
	to_save(F["id"], id)
	to_save(F["dat"], dat)

	to_save(F["author_real"], author_real)
	to_save(F["author_key"], author_key)
	to_save(F["photos"], photos)

#undef BOOK_VERSION_MIN
#undef BOOK_VERSION_MAX
#undef BOOK_PATH
