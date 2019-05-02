# PartyZone - Grupp Hallon
  
  
  
  
  
[![](https://img.shields.io/badge/pub-v0.0.8-brightgreen.svg)](https://pub.dartlang.org/packages/spotify_playback) [![](https://img.shields.io/badge/licence-MIT-blue.svg)](https://github.com/uu-os-2019/dsp-hallon/blob/master/LICENSE)
   
  
  Projektarbete på kursen Datorsystem med projekt (1DT003) våren 2019, Uppsala universitet.

Spotify Playback Plugin.
 
**This project utilizes the following frameworks and APIs and we would like to thank them**
[spotify-playback-flutter](https://github.com/qreate/spotify-playback-flutter/)  
[spotify-app-remote-release](https://github.com/spotify/android-sdk/releases/tag/v0.6.1-appremote_v1.1.0-auth)  
[spotify-auth-release](https://github.com/spotify/android-sdk/releases/tag/v0.6.1-appremote_v1.1.0-auth)   
  

  

## Features
* Play (track / album / playlist)
* Resume / pause
* Queue
* Playback position
* Seek
* Seek to relative position
* Play Next
* Play Previous
* Repeat 
* Shuffle 
* Get image
* Image link to URI

## Installation
**`IMPORTANT:` Make sure you have the Spotify app installed and that you are logged in or your test device!**

First, add `spotify_playback` as a dependency in your `pubspec.yaml` file. 

Afterwards, download the Spotify Android SDK [here](https://github.com/spotify/android-sdk/releases/tag/v0.6.1-appremote_v1.1.0-auth) and move the spotify-app-remote-release-x.x.x.aar file to `android/app/libs/` in your project.

Then initialize the spotify playback sdk like this 

```dart
@override
  void initState() {
    super.initState();
    initConnector();
  }

  /// Initialize the spotify playback sdk, by calling spotifyConnect
  Future<void> initConnector() async {
    try {
      await SpotifyPlayback.spotifyConnect(clientId: "", redirectUrl: "").then(
          (connected) {
        if (!mounted) return;
        // If the method call is successful, update the state to reflect this change
        setState(() {
          _connectedToSpotify = connected;
        });
      }, onError: (error) {
        // If the method call trows an error, print the error to see what went wrong
        print(error);
      });
    } on PlatformException {
      print('Failed to connect.');
    }
  }
``` 

After this you can use all the available methods

## Available methods 
| Method        | description           | parameters  | notes |
| ------------- |:-------------:| -----:|-----:|
| spotifyConnect      | Initilizes the spotify playback sdk | clientId, redirectUrl ||
| play      | Play's an spotify track, album or playlist | spotify uri ||
| pause      | Pause's the currently playing track      |    ||
| resume |  Resumes the currently paused track      |     ||
| queue |  Adds an track / playlist / album to the queue     |   spotify uri  ||
| skipNext      | Play's the next track | ||
| skipPrevious      | Play's the previous track |  ||
| seekTo |  Seeks to the passed time     |  time(mS)   ||
|seekToRelativePosition|Seeks to relative position|+-time(mS)||
| toggleShuffle | Toggle shuffle options    |     ||
| toggleShuffle | Toggle Repeat options    |     ||
| getPlaybackPosition | Get's the current tracks playback position       |    ||
| getImage | Gets a Uint8List encoded image(memoryImage)       |  imageUri, quality, size  | [![](https://img.shields.io/badge/WARNING-23-orange.svg)](https://github.com/qreate/spotify-playback-flutter/issues/23)
| imageLinkToURi | Takes an image url and returns image uri(for get image)    |  imageLink  ||
| getAuthToken | Gets the authToken by using the redirect url, client id       |  clientId, redirectUrl | [![](https://img.shields.io/badge/WARNING-WIP-orange.svg)](https://github.com/qreate/spotify-playback-flutter/pull/28)

## Example

Demonstrates how to use the spotify_playback plugin.

See the [example documentation](example/README.md) for more information.


## Function examples
### GetImage   
[![](https://img.shields.io/badge/WARNING-23-orange.svg)](https://github.com/qreate/spotify-playback-flutter/issues/23)
Get image accepts the following parameters:
* URI, the spotify image uri - string
* Quality, the quality the image should be provided in - int 0-100
* Size, the spotify image size can be one of the following
  * ImageDimension.THUMBNAIL = 144px
  * ImageDimension.X_SMALL = 240px
  * ImageDimension.SMALL = 360px
  * ImageDimension.MEDIUM = 480px
  * ImageDimension.LARGE = 720px
```dart
//You can provide an image uri
SpotifyPlayback.getImage(uri: "spotify:image:3269971d34d3f17f16efc2dfa95e302cc961a36c", quality: 100, size: 360);

//Or you can provide an url returned webAPI
SpotifyPlayback.getImage(uri: SpotifyPlayback.imageLinkToURi("https://i.scdn.co/image/3269971d34d3f17f16efc2dfa95e302cc961a36c"), quality: 100, size:360);

//Theese both return a Uint8List encoded image.
//You can then use the Image.memory() to display the image
Image.memory(yourUint8ListImageHere)

```

## Changelog

See [CHANGELOG.md](CHANGELOG.md).

## Special Thanks
 - Alexander Méhes | [BMXsanko](https://github.com/BMXsanko)

## Contributing

Feel free to contribute by opening issues and/or pull requests. Your feedback is very welcome!

## License

MIT License

Copyright (c) [2019] [Joran Dob]
Copyright (c) [2019] [QREATE]




















## Katalogstruktur

**TODO:** 
**AwesomeProject**
- Huvud-applikationen 

**meta**
- gruppkontrakt
- presentation av gruppens medlemmar

## Färdigställ 

- Färdigställ dokumentet [meta/gruppkontrakt.md](./meta/gruppkontrakt.md).
- Färdigställ dokumentet [meta/medlemmar.md](./meta/medlemmar.md).
- Allt eftersom projektet fortskrider kan ni lägga till fler rubriker i detta
  dokument med kompletterande information.
- Tag bort alla stycken markerade med **TODO** och **INFO**.
- Tag bort hela detta avsnitt, dvs tag bort avsnittet **Färdigställ**.
