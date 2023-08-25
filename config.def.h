/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "nobody";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "black",     /* during input */
	[FAILED] = "#ad2a4b",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;
