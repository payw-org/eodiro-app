import { Feather } from '@expo/vector-icons'
import { Subscription } from '@unimodules/core'
import Constants from 'expo-constants'
import * as Linking from 'expo-linking'
import * as Notifications from 'expo-notifications'
import * as Permissions from 'expo-permissions'
import { StatusBar } from 'expo-status-bar'
import React, { useEffect, useRef, useState } from 'react'
import {
  Animated,
  Image,
  Platform,
  StyleSheet,
  Text,
  TouchableOpacity,
  View,
} from 'react-native'
import { AppearanceProvider, useColorScheme } from 'react-native-appearance'
import { getBottomSpace } from 'react-native-iphone-x-helper'
import { WebView, WebViewNavigation } from 'react-native-webview'
import { env } from './env'

const isDev = process.env.NODE_ENV === 'development'
const eodiroUrl = isDev ? `http://${env.IP}:3020` : 'https://eodiro.com'

// Notifications
Notifications.setNotificationHandler({
  handleNotification: async () => ({
    shouldShowAlert: true,
    shouldPlaySound: true,
    shouldSetBadge: true,
  }),
})

async function askForNotificationsPermission() {
  if (Constants.isDevice) {
    const { status: existingStatus } = await Permissions.getAsync(
      Permissions.NOTIFICATIONS
    )

    let finalStatus = existingStatus
    if (existingStatus !== 'granted') {
      const { status } = await Permissions.askAsync(Permissions.NOTIFICATIONS)
      finalStatus = status
    }

    if (finalStatus !== 'granted') {
      return
    }
  } else {
    alert('Must use physical device for Push Notifications')
  }

  if (Platform.OS === 'android') {
    Notifications.setNotificationChannelAsync('default', {
      name: 'default',
      importance: Notifications.AndroidImportance.MAX,
      vibrationPattern: [0, 250, 250, 250],
      lightColor: '#FF231F7C',
    })
  }
}

function App() {
  const [expoPushToken, setExpoPushToken] = useState<string | undefined>('')
  const [
    notification,
    setNotification,
  ] = useState<Notifications.Notification | null>(null)
  const notificationListener = useRef<Subscription>({ remove: () => {} })
  const responseListener = useRef<Subscription>({ remove: () => {} })

  const [isLoaded, setIsLoaded] = useState(false)
  const [hasError, setHasError] = useState(false)

  const [webViewUrl, setWebViewUrl] = useState(eodiroUrl)

  const colorScheme = useColorScheme()
  const webView = useRef<WebView | null>()
  const [
    navigationState,
    setNavigationState,
  ] = useState<WebViewNavigation | null>(null)

  const fadeAnim = useRef(new Animated.Value(1)).current

  useEffect(() => {
    // This listener is fired whenever a notification is received
    // while the app is foregrounded
    notificationListener.current = Notifications.addNotificationReceivedListener(
      (notification) => {
        setNotification(notification)
      }
    )

    // This listener is fired whenever a user taps on or interacts
    // with a notification (works when app is foregrounded, backgrounded, or killed)
    responseListener.current = Notifications.addNotificationResponseReceivedListener(
      (response) => {
        const { data } = response.notification.request.content

        if (data.type === 'notice' && data.url) {
          Linking.openURL(data.url as string)
        } else if (data.type === 'comment') {
          setWebViewUrl(
            `${eodiroUrl}/community/board/${data.boardId}/post/${data.postId}`
          )
        }
      }
    )

    return () => {
      Notifications.removeNotificationSubscription(notificationListener.current)
      Notifications.removeNotificationSubscription(responseListener.current)
    }
  }, [])

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
        source={{
          uri: webViewUrl,
          headers: {
            'eodiro-agent': 'expo',
          },
        }}
        onError={() => {
          setHasError(true)
        }}
        onMessage={async (e) => {
          const { data } = e.nativeEvent
          const parsed = JSON.parse(data)

          if (parsed.isLoaded) {
            askForNotificationsPermission()

            Animated.timing(fadeAnim, {
              toValue: 0,
              duration: 300,
              useNativeDriver: true,
            }).start()

            setIsLoaded(true)
          } else if (parsed.requestExpoPushToken) {
            const expoPushToken = (await Notifications.getExpoPushTokenAsync())
              .data
            webView.current?.postMessage(expoPushToken)
          }
        }}
        decelerationRate="normal"
        style={styles.webView}
        ref={(wv) => (webView.current = wv)}
        onNavigationStateChange={(navigation) => {
          if (navigationState?.url !== navigation.url) {
            // Different page
            webView.current?.injectJavaScript(`
              window.expoPushToken = '${expoPushToken}';
              true;
            `)
          }

          setNavigationState(navigation)

          if (!navigation.url.startsWith(eodiroUrl)) {
            webView.current?.stopLoading()
            Linking.openURL(navigation.url)
          }
        }}
      />
      <View
        style={{
          display: 'flex',
          flexDirection: 'row',
          alignItems: 'center',
          justifyContent: 'center',
          backgroundColor: colorScheme === 'light' ? '#f0f2f3' : '#000000',
          paddingBottom: getBottomSpace(),
        }}
      >
        <TouchableOpacity
          style={{ ...styles.navigationButton }}
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
          style={{ ...styles.navigationButton, marginLeft: 30 }}
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
      <Animated.View
        pointerEvents="none"
        style={{
          position: 'absolute',
          top: 0,
          left: 0,
          width: '100%',
          height: '100%',
          backgroundColor: '#000000',
          opacity: fadeAnim,
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
        }}
      >
        {hasError && (
          <View
            style={{
              display: 'flex',
              flexDirection: 'column',
              alignItems: 'center',
            }}
          >
            <Image
              source={require('./assets/icon-arrow-only.png')}
              style={{
                width: 100,
                height: 100,
                marginBottom: 50,
              }}
            />
            <Text style={{ color: '#fff', lineHeight: 25, fontSize: 14 }}>
              서버에 접속하지 못했습니다.
            </Text>
            <Text style={{ color: '#fff', lineHeight: 25, fontSize: 14 }}>
              같은 문제가 지속될 시
            </Text>
            <Text style={{ color: '#fff', lineHeight: 25, fontSize: 14 }}>
              support@eodiro.com으로 문의해주세요.
            </Text>
          </View>
        )}
      </Animated.View>
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
