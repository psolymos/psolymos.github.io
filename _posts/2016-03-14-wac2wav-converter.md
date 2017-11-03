---
title: "wac2wav converter"
layout: default
published: true
category: Code
tags: [C, ARU, ABMI, bioacoustics]
disqus: petersolymos
promote: false
---

Automated acoustic monitoring is gaining momentum worldwide. Alberta is
stepping up to the game by implementing automated recording unit (ARU)
based monitoring programs. An improved command line tool is here to help
in the process.

The [Bioacoustic Unit](http://bioacoustic.abmi.ca/) of the
Alberta Biodiversity Monitoring Institute ([ABMI](hattp://www.abmi.ca))
and the [Bayne lab](https://uofa.ualberta.ca/biological-sciences/faculty-and-staff/academic-staff/erin-bayne)
at the [University of Alberta](http://www.ualberta.ca) collaborates on
best practices for using acoustic technology.
The amount of information collected each year by these organizations
is measured in dozens of terabytes, and is steadily increasing.
Efficient and secure storage for all these files is the most immediate
challenge, but the next one is closing the gap between data collection
and data processing.

Processing all the recordings from the field
requires significant computing resources.
The first step is converting the `wac` files to `wav`, so that a a wider
variety of software tools can be used to analyze the information in the files.
The `wac` format is a proprietary file format developed by
[Wildlife Acoustics](http://www.wildlifeacoustics.com/),
a company that specializes in bioacoustics monitoring systems.

The fact that the acoustic units manufactured by Wildlife Acoustics
are widely used in Alberta might represent a vendor lock-in.
Luckily for us, the pressure on the company
(see [here](http://research.coquipr.com/archives/747) and [here](http://research.coquipr.com/archives/840), thanks Luis J. Villanueva-Rivera)
led to the company releasing a command line tool under the [GPL](http://www.gnu.org/licenses/gpl-3.0.html) license
for facilitating
`wac`-to-`wav` file conversion (see source code [here](http://wildlifeacoustics.com/downloads/wac2wavcmd-1.0.zip), [here](https://sourceforge.net/projects/wac2wavcmd/files/), and [here](https://github.com/ljvillanueva/pumilio-extras/blob/master/wac2wav/install_wac2wav.sh)).

The story might have ended right there. But the `C` code worked with
standard input and output. It took some time and help (thanks John) to figure out exactly
how one should use the command line tool. Here is the solution:

```
cat input_file.wac | ./wac2wavcmd > output_file.wav
```

Isn't that ugly? One would expect something like:

```
./wac2wavcmd input_file.wac output_file.wav
```

The good news is that the modified version (also released under [GPL](http://www.gnu.org/licenses/gpl-3.0.html) license) does just that.
It has been tested on Linux, Mac OS X and Windows 10.
It also removes all the clutter the original program prints to the
terminal. The only difference is that the program is called `wac2wav`
instead of `wac2wawcmd`. See the description and source code on
[GitHub](https://github.com/psolymos/abmianalytics/tree/master/aru/wac2wav).
(Note: the leading `./` can be omitted if the program is added to the path.)

We are one step closer to a truly cloud based bioacoustic platform!
