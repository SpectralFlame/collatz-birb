You can change some of the settings yourself if you like, here is a short description for each of the settings

value | description
--------|----------------
iterative | If it's animated or not (bad naming, this should've been "animate")
N | The maximum value of n (if iterative is true, this is multiplied by 10 to get a similar looking image)
L | length of a single line
W | width of the lines which is a multiple of L, so changing L has the effect of scaling the image
segperloop | how fast the animation goes (if you want to try N=5000000, set this to about 1000)
rmin | minimum value of red (gmin and bmin for green and blue)
rmax | maximum value of red (gmax and bmax for green and blue)
rvar | how fast the value of red changes (gvar and bvar for green and blue)
useSeed | if true, uses the value of seed so that you get the same result every time
seed | the value of the random seed (currently set to the Battle of Hastings)
