# PartyZone - Grupp Hallon
  
  
  
  
  
[![](https://img.shields.io/badge/licence-MIT-blue.svg)](https://github.com/uu-os-2019/dsp-hallon/blob/master/LICENSE)
   
  
  Projektarbete på kursen Datorsystem med projekt (1DT003) våren 2019, Uppsala universitet.

Spotify Playback Plugin.
 
**Det här projektet använder sig av följande frameworks och APIer**   

[spotify-playback-flutter](https://github.com/qreate/spotify-playback-flutter/)  [![](https://img.shields.io/badge/pub-v0.0.8-brightgreen.svg)](https://pub.dartlang.org/packages/spotify_playback)    
[spotify-app-remote-release](https://github.com/spotify/android-sdk/releases/tag/v0.6.1-appremote_v1.1.0-auth)   
[spotify-auth-release](https://github.com/spotify/android-sdk/releases/tag/v0.6.1-appremote_v1.1.0-auth)   
  

  

## Implimenterade funktioner
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
**`Viktigt:` Följande delar krävs för att bygga och köra projektet!**
* [Android studio med installerad android telefon och Google Playstore](https://developer.android.com/studio/)
* Alternativt en Android telefon 
* [Flutter installerad på datorn och med terminalkommandon](https://flutter.dev/docs/get-started/install) 
* (Så länge som produkten är i utvecklingsläge):
   I Terminalen på Mac/Linux datorer, skriv:  
     keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
     Kopiera ID:t efter SHA1    
     Exempel:    SHA1: 8E:EC:8E:15:4B:2A:9D:3F:1F:9D:96:95:F9:87:69:F2:D9:33:9C:D6
* Ha SHA1-ID:t insprivet till Spotifys API
* Ha Spotify installerad på telefonen


## Bygga och köra 
**Se till att stegen för `Installation` följts!**
- ``` gitclone https://github.com/uu-os-2019/dsp-hallon.git ``` 
- ``` cd dsp-hallon/spotify-playback-flutter/example/ ```
- Koppla in telefonen i utvecklarläge eller starta en emulerad Android telefon med Spotify installerad
- ``` flutter doctor ``` För att kolla att Flutter hittar telefonen och att allt funkar 
- ```flutter run ```


[comment]: <> (hej)



















## Katalogstruktur

**TODO:** 
**AwesomeProject**
- Huvudapplikationen 

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
