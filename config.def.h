/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "nobody";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "black",     /* during input */
	[FAILED] = "#ad2a4b",   /* wrong password */
};

/* opacity (accepts values from 0 to 1) */
static const float opacity = 0.7;

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;
