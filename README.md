# for breathing disaster # 
Live visualizer for *BRIDGES IV - for breathing disaster* by Ægir Sindri Bjarnason.


<picture>
  <img alt="Example 1" src="images/vintage_litir2.png">
</picture>


<picture>
  <img alt="Example 2" src="images/bw.png">
</picture>


<picture>
  <img alt="Example 3" src="images/rautt_mikid_noise.png">
</picture>

<a href="http://www.youtube.com/watch?feature=player_embedded&v=Iujgjn5zlJ4
" target="_blank"><img src="http://img.youtube.com/vi/Iujgjn5zlJ4/0.jpg" 
alt="Demo" width="240" height="180" border="10" /></a>

## for breathing disaster ##

This is a partially audio-reactive live controllable visualizer we made in Godot for a specific live set.
It has multiple controllable elements that we mapped to a MIDI controller for live performance.

We developed it on the fly with very rapid changes so the code is as messy as can be. This is the entire codebase so you can inspect/steal/look down on every part of it.

It uses two separate screens (one projected on a large wall behind the performer, the other on a cloth screen in front of him).

The large back screen shows a thin orange horizon and a tiny planet sort of shape in the distance. The small screen has a top down view of the same planet and we see that its circles of latitude are affected by the sounds we hear.

### Controls ###
The audio is directly affecting the planet's shape. All other aspects are controlled live with some kind of controller. The first version had MIDI mapped controls for:
1. How thick/thin the horizon is. One control with a set minimum (so the horizon is always at least a small line) and another that can "turn it off" and make the entire sky black.
2. The brightness and color of the sky. One extreme is a black sky and the other is a dark-ish blue.
3. How fast the spectator moves toward the planet.
4. How fast the planet is spinning on its own.
5. Rotating the horizon line.
6. Saturation of the entire image (1 = all colors normal, 0 = everything is black and white)
7. Last but not least a destruction slider that adds grain and chromatic aberration that gets more and more intense until it starts strobing and turns into complete chaos



### ísl pælingar ###
1. Gera allt stærra (plánetan ekki "2m" og "500m" í burtu heldur pinu raunhæfari stærðir)
2. Hægt að fara inn í plánetuna á einhverjum tímapunkti. Þá væri svona núningur og hljóðið færi að kurlast og molna niður og þegar við brotnum gegnum skelina væri svona gasský væbs inní eða eitthvað? held hljóðið þá low passað og allt frekar svona muffled og nett. kannski lo pass + reverb?
3. Custom controller fyrir allt saman
4. Hægt að stjórna lika litla skjanum betur
5. DMX og tengja ljos inn í showið. t.d. hafa reyk á sviðinu og baklýsingu sem matchar horizonið (ef appelsinugult þa ljosið lika, ef s/h þá ljosið hvítt, ef feidar út þa feidar ljosið)
6. Láta sjóndeildarhringinn nötra - svipuð pæling og með camera shake ef fer yfir einhvern þröskuld
7. geta smá klippt á milli sena (t.d. vera alveg upp við plánetuna hun snyst a milljon og glitchið er á fullu en geta triggerað að allt í einu erum við lengst í burtu og allt serene eða eitthvað)
8. Kannski búa til þráðlausar stjórngræjur sem t.d. einhver í salnum gæti fokkað í einhverju a akveðnum timapunkti (einn pottur eða takki eða eikka í boxi, 2.4ghz tengt við venjulega controllerinn)
9. Mynstrið á plánetunni (hvíta/svarta materialið) morphar eins og rorschach í watchmen
10. prófa aftur sem eg gerði einhverntíma með alvöru myndir af jörðinni nema hún var 100% svört en svo voru svæði mis reflective og hrjúf þannig það voru hellaðir detailar sem lookuðu eins og lönd en hun leit ekki ut eins og jörðin samt


<!-- 
It starts with a 
weird planet kind of shape floating in space and rotating, way in the distance. Behind the planet is a thin orange
horizon The spectator (our point of view) moves closer and closer to the planet, as we approach it the horizon
line grows and the sky lightens and turns blue. We see the planet  -->
