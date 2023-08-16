# Do points matter

"The point distributon of a hull effect the likelihood of the hull participating in a wining team"

While I don't think anyone would disagree with this on the face value, as you need to spend points to buy guns/missiles/etc to shoot ships, I did wonder if there were optimal amounts of points to spend on a hull. 

For example, if I seriously kit out two gun Vauxhalls, is this more effective than have three less kitted Vaux's, or two Vaux's and several escorts? Is there a point where we can see in the data that spending too much, and putting too many eggs in one basket is more likely to be detrimental? 

Now a bit of a note on this and the conclusions I'm going to make here. This isn't to say that your build is bad because you're spending too much points on a Vauxhall. The great thing about Nebulous is that the meta is still growing and developing, and none of the hulls exhibit a huge win loss difference, meaning that people also can win with hulls that cost that much. It just happens less, which makes it less **viable**. 

While points are somewhat crude, as they don't take into account the difference between missiles and guns and lasers, there did seem to be some insight that you can take away from them.  
Anyway, without further ado, lets get to it!

### Quick word on how to read these charts:

For each Hull, there are two charts. The top is a histogram of the win/loss by point value. I've done this for every hull I have stats on, so there are naturally higher values for smaller ships. 

Then there is measure I have tried to derive from the top chart of point viability. This is a normalised (between -1 to 1) measure of how viable a hull is at for each band of cost. Positive values are mean the hull is more viable, while negative values mean the hull is less viable. These values are scaled by the win rate and the size of the sample to prevent outliers were there are 3 wins and no losses from dominating the chart. 

Becasue they are normalised to the hull, you shouldn't compare these across hulls. This is designed to be a measure of how viable each hull is in the unknown soup of whatever else is brought to the battlefield. 

Finally, in the header, there is a winrate. I'm unsure if I should keep this in, as it is biased against the win rate with a slight tilt to OSP. I'm also unsure if it applies equally to smaller ships and bigger ships. I've put it in now, but I have mixed feelings and may take it out if I feel its misleading.  

### Point viability formula
The formula I've used to calculate point viability is described below

```Julia
#For each point band of 100 points

# Get the Win/Loss weights from the histogram
# These are the values we see in the top chart
winH = fit(Histogram, w.pointCost, start:step:finish).weights
lossH = fit(Histogram, l.pointCost, start:step:finish).weights

# Get the difference between wins and losses
# Multiply it by the sum of the square roots of the W/L rates, and squareRoot it again  
# This visually gave reasonable looking values, else the count of ships in larger buckets dominated 
rate = (winH .- lossH ) .* sqrt.(sqrt.(winH) .+ sqrt.(lossH) )

# And normalise it to -1 and 1 by finding the max extreme value. 
# We still want to keep the default at zero, so not a min/max normalization
rateN = rate ./ max(maximum(rate),abs(minimum(rate)))

```

I hope this makes some sense! I've got no mathematical  justification for why I chose the transformation I did, except it seems to look reasonable useful. 

## ANS Hulls

### Sprinter Corvette

![alt text](assets/pointEffectiveness/Sprinter_Corvette.png "Sprinter Point Viability")

#### Thoughts and musings
Sprinters seem to be very effective hulls. Most prominent in the 200-400 point bands, they excel as support ships, PD escorts, spotters and jamboats. I suspect they have such a high win rate because they are very effective support ships. The more scouts you have, the more you can plan and premept your oppositions actions. 

Also sprinter swarms can get very close to you undetected, ( I'm not a radar expert but I think about ~4k before you can detect them ), can all mount a 250 cannon, a jammer/bullseye with ample PD on the side mounts. I don't think there are any fleets that wouldn't be made better by adding an additional sprinter into the mix.  

I'm unsure of how viable the Sprinter is for missiles from this, but it seems like the sweet spot for a Sprinter is between 200-400 pts. While you can go higher, it appears that the viability diminishes. Why have a single 600 pt Sprinter when you could have twice the scouting power with 2x 300 pt Sprinters?

### Raines Frigate

![alt text](assets/pointEffectiveness/Raines_Frigate.png "Raines Point Viability")

#### Thoughts and musings

While the Raines frigate seems to operate in a similar space as the Sprinter, it seems like you do have to put some points into a Raines for it to become viable. Raines under 300 points are not as effective as they are over 300 points but this extra investment seems well woth it. Over 500 points they seem to become less viable, though not by a huge amount. 

I suspect this is where the 4x Jammers/Sarissa builds come in, and they become quite costly to get the power requirements for the 4th item.

while I'm pretty sure that sweet spot for jammers is 4(?) I don't know if putting them all on a raines is the most effective









### Sprinter Corvette

![alt text](assets/pointEffectiveness//Sprinter_Corvette.png "Sprinter Point Viability")

#### Thoughts and musings
