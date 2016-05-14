# Processing Textmode Engine
## Version 0.1 (initial release) May 2016

The Processing Textmode Engine renders output in [Processing](http://www.processing.org) to a full color text display,
reminiscent of early computer or [BBS](https://en.wikipedia.org/wiki/Bulletin_board_system) graphics. I wrote it to use for realtime visual performance, but can be used to create movies, still images, or even games.
It is free and open source. :v:

Creating a textmode engine is something I've wanted to do for a long time. I
grew up using [DOS](https://en.wikipedia.org/wiki/MS-DOS) and hanging out on BBSes, so I love textmode and [ANSI art](https://www.google.com/search?tbm=isch&q=ansi+art&gws_rd=ssl). I
used [TheDraw](https://en.wikipedia.org/wiki/TheDraw) as a kid and now use [PabloDraw](http://picoe.ca/products/pablodraw/) for creating ANSI art. Even [Sixteen Colors](http://www.sixteencolors.net) has a [JS based textmode editor](http://draw.sixteencolors.net/). And as far as
textmode converting goes, I've experimented with [AALib](http://aa-project.sourceforge.net/aalib/), [libcaca](http://caca.zoy.org/), and even [TextFX](http://sol.gfxile.net/textfx/index.html).
I looked at the [Textmode Demo Framework](http://www.pouet.net/prod.php?which=64192) released by the [TMDC folks](http://tmdc.scene.org/), too. But I wanted
something I could use with Processing, something fast and fun. And that's what
this is. It may not be as accurate as the others, but I am hoping since it uses
Processing (rather than C) that it may be more accessible to a wide range of
artists and creative coders.

The code is well commented, but here's the tl;dr on how it works: you draw to a small
offscreen buffer and then convert the pixels in that buffer to text and draw to the
main screen. Brightness controls the glyphs and the average color of the pixel area
controls the color of that glyph. The background is always black, like conventional
ANSI art tools.

I hope you enjoy using it as much as I do! :pray: For more info, pics, and video, please
visit: http://www.no-carrier.com

Don Miller / NO CARRIER

Click on the image below to be taken to Vimeo to check out the engine in action:
[![Textmode Engine Demo Video](http://www.no-carrier.com/img/engineDemo.png)](https://vimeo.com/165805982)

And here's a link to a video from a Textmode Lightsynth I'm working on. More soon :smile:
[![Textmode Lightsynth Video](http://www.no-carrier.com/img/lightsynthVid.png)](https://vimeo.com/165815175)
