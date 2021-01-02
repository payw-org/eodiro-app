import { StatusBar } from 'expo-status-bar'
import React, { useRef, useState } from 'react'
import { StyleSheet, View, TouchableOpacity } from 'react-native'
import { WebView, WebViewNavigation } from 'react-native-webview'
import Constants from 'expo-constants'
import { AppearanceProvider, useColorScheme } from 'react-native-appearance'
import { Feather } from '@expo/vector-icons'
import * as Linking from 'expo-linking'
import { getBottomSpace } from 'react-native-iphone-x-helper'

function App() {
  const colorScheme = useColorScheme()
  const webView = useRef<WebView | null>()
  const [
    navigationState,
    setNavigationState,
  ] = useState<WebViewNavigation | null>(null)

  return (
    <View style={styles.container}>
      <StatusBar style="auto" />
      <View
        style={{
          height: Constants.statusBarHeight,
          backgroundColor: colorScheme === 'light' ? '#f0f2f3' : '#000000',
        }}
      />
      <WebView
        source={{ uri: 'https://eodiro.com' }}
        decelerationRate="normal"
        style={styles.webView}
        ref={(wv) => (webView.current = wv)}
        onNavigationStateChange={(navigation) => {
          setNavigationState(navigation)

          if (!navigation.url.startsWith('https://eodiro.com')) {
            webView.current?.stopLoading()
            Linking.openURL(navigation.url)
          }
        }}
      />
      <View
        style={{
          display: 'flex',
          flexDirection: 'row',
          backgroundColor: colorScheme === 'light' ? '#f0f2f3' : '#000000',
          paddingBottom: getBottomSpace()
        }}
      >
        <TouchableOpacity
          style={{ ...styles.navigationButton, paddingLeft: 10 }}
          onPress={() => {
            webView.current?.goBack()
          }}
        >
          <Feather
            name="chevron-left"
            size={30}
            color={colorScheme === 'light' ? '#000' : '#fff'}
            style={{
              opacity: navigationState?.canGoBack ? 1 : 0.2,
            }}
          />
        </TouchableOpacity>
        <TouchableOpacity
          style={{ ...styles.navigationButton, marginLeft: 10 }}
          onPress={() => {
            webView.current?.goForward()
          }}
        >
          <Feather
            name="chevron-right"
            size={30}
            color={colorScheme === 'light' ? '#000' : '#fff'}
            style={{
              opacity: navigationState?.canGoForward ? 1 : 0.2,
            }}
          />
        </TouchableOpacity>
      </View>
    </View>
  )
}

const styles = StyleSheet.create({
  container: {
    width: '100%',
    height: '100%',
  },
  webView: {},
  navigationButton: {
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    width: 50,
    height: 50,
  },
})

export default function Main() {
  return (
    <AppearanceProvider>
      <App />
    </AppearanceProvider>
  )
}
