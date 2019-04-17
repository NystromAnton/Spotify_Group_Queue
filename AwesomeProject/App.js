import React from 'react';
import { Platform, StatusBar, StyleSheet, View } from 'react-native';
import { Container, Header, Title, Thumbnail, Content, Input, InputGroup, Item, Footer, Text, FooterTab, Button, Left, Right, Body, Card, CardItem, Fonts } from 'native-base';
import { AppLoading, Asset, Font, Icon, AuthSession } from 'expo';
import AppNavigator from './navigation/AppNavigator';
import Login from './components/Login'
//import Profile from './components/Profile'
/*import HomeScreen from './screens/HomeScreen'
import LinksScreen from './screens/LinksScreen'
import SettingsScreen from './screens/SettingsScreen'
*/
export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      userInfo: null,
      isReady: false
    };
    this.handleSubmit = this.handleSubmit.bind(this);
  }



  handleSubmit = async () => {
    let redirectUrl = AuthSession.getRedirectUrl();
    console.log(redirectUrl);

    let result = await AuthSession.startAsync({
      authUrl: "http://130.243.237.11:8888/auth/spotify"
    });

    if (result.type !== "success") {
      alert("Uh oh, something went wrong");
      return;
    }

    let userInfoResponse = await fetch(
      `http://130.243.237.11:8888/callback?code=${result.params.code}`
    );
    const userInfo = await userInfoResponse.json();
    //console.log(userInfo)
    this.setState({
      user: userInfo.user._json
    });
  };

  render() {
    if (!this.state.isReady) {
        return (
            <AppLoading
      startAsync={this._loadResourcesAsync}
      onError={this._handleLoadingError}
      onFinish={()  => this.setState({isReady: true})}
    />)
    }
    else {
        return (
          <Container>
          {!this.state.user ? (
            <Login
            press={this.handleSubmit.bind(this)}
            />
          ) : (
              <View style={styles.container}>
                {Platform.OS === 'ios' && <StatusBar barStyle="default" />}
                <AppNavigator />
              </View>
          )}
          </Container>
        );
    }
  }


// Det här kom från gamla filen.
_loadResourcesAsync = async () => {
  return Promise.all([
    Asset.loadAsync([
      require('./assets/images/robot-dev.png'),
      require('./assets/images/robot-prod.png'),
    ]),
    Font.loadAsync({
      // This is the font that we are using for our tab bar
      ...Icon.Ionicons.font,
      // We include SpaceMono because we use it in HomeScreen.js. Feel free
      // to remove this if you are not using it in your app
      'space-mono': require('./assets/fonts/SpaceMono-Regular.ttf'),
      'Roboto_medium': require('native-base/Fonts/Roboto_medium.ttf'),
      'Roboto': require('native-base/Fonts/Roboto.ttf'),
    }),
  ]);
};

_handleLoadingError = error => {
  // In this case, you might want to report the error to your error
  // reporting service, for example Sentry
  console.warn(error);
};
}

const styles = StyleSheet.create({
container: {
  flex: 1,
  backgroundColor: '#fff',
},
});
// slut på gammalt skit.
