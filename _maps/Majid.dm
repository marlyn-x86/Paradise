/*
You need to have 7 z-levels of the same size dimensions.
z-level order is important, the order you put them in inside this file will determine what z level number they are assigned ingame.
Names of z-level do not matter, but order does greatly, for instances such as checking alive status of revheads on z1
current as of 2015/05/11
z1 = Main facility
z2 = empty
z3 = telecommunications center
z4 = empty
z5 = empty
z6 = empty
z7 = empty
*/

#if !defined(MAP_FILE)

        #include "map_files\Majid\Majid main.dmm"
        #include "map_files\Majid\z2.dmm"
        #include "map_files\Majid\z3.dmm"
        #include "map_files\Majid\z4.dmm"
        #include "map_files\Majid\z5.dmm"
        #include "map_files\Majid\z6.dmm"
        #include "map_files\Majid\z7.dmm"

        #define MAP_FILE "Majid.dmm"
        #define MAP_NAME "NT mining operation Majid"

#elif !defined(MAP_OVERRIDE)

	#warn a map has already been included, ignoring Majid.

#endif