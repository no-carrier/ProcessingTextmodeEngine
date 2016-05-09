# Processing Textmode Engine
## Version 0.1 (initial release)

The Processing Textmode Engine renders output in Processing to a full color text display,
reminiscent of early computer or BBS graphics. I wrote it to use for realtime
visual performance, but can be used to create movies, still images, or even games.
It is free and open source.

Creating a textmode engine is something I've wanted to do for a long time. I
grew up using DOS and hanging out on BBSes, so I love textmode and ANSI art. I
used TheDraw as a kid and now use PabloDraw for creating ANSI art. And as far as
textmode converting goes, I've experimented with AALib, libcaca, and even TextFX.
I looked at the Textmode Demo Frameworks released by the TMDC folks, too. But I wanted
something I could use with Processing, something fast and fun. And that's what
this is. It may not be as accurate as the others, but I am hoping since it uses
Processing (rather than C) that it may be more accessible to a wide range of
artists and creative coders.

The code is well commented, but here's the tl;dr on how it works: you draw to a small
offscreen buffer and then convert the pixels in that buffer to text and draw to the
main screen. Brightness controls the glyphs and the average color of the pixel area
controls the color of that glyph. The background is always black, like conventional
ANSI art tools.

I hope you enjoy it as much as I do! For more info, pics, and video, please
visit http://www.no-carrier.com

Don Miller / NO CARRIER
May 2016
