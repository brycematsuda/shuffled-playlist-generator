shuffled-playlist-generator
============================

The equivalent to shuffling any m3u playlist/library in a music player like iTunes or Banshee.
Except you are given the entire list, not just the next 10/20/30 songs in the list.
Because some people might want to know what the entire play order is to stop at and resume from a certain point in time.


Formats supported
============================
Only .m3u files are accepted right now. For now, the program assumes the m3u is already valid, formatted as shown:

```sh
#EXTM3U
#EXTINF:123, Sample artist - Sample title
C:\Documents and Settings\I\My Music\Sample.mp3
#EXTINF:321,Example Artist - Example title
C:\Documents and Settings\I\My Music\Greatest Hits\Example.ogg
...
...
```

Actual .m3u validation may be implemented at a later date.

Usage
===========================
In the command line:
`ruby playlistShuffler.rb <M3U to shuffle> <optional custom output name>`

Examples:

* `ruby playlistShuffler.rb myLibrary.m3u`

* `ruby playlistShuffler.rb myLibrary.m3u shuffledLibrary.m3u`

The default output file name if none is specified is "shuffled.m3u"

License
===========================
This script is licensed under the MIT License.