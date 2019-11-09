The angles are different. The version of Numberphile uses an angle of `PI/13` to the right and `PI/20` to the left, I assume to get a nice visual. Also, on their version they have these long lines with bumps on the underside of them, I believe these bumps actually are values higher than 10000, again for a nice visual effect. The image I shared was limited to 10000 which is why it doesn't show these bumps.

For the animation I use the reverseCollatz method instead of calculating the whole chain and then reversing it. For the static image I calculate the whole chain and then sort them so the shortest gets drawn first.

I played around some more and got this colorful artwork (I've also got some nice pink ones)
[made with N=5000000, changed the color pallet to include all colors and moved the starting height to be in the center](https://i.imgur.com/ljFudmp.png)

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

I don't have variables for changing the starting point, but it can be changed by changing the values in translate found in the draw method (for animation) and in the drawChains method (for static).
