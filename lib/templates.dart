part of 'supported_platform.dart';

/// Android-related templates
/// Below is generic template we inject to our project folders

///[Andriod SplashView.xml]
const String _androidSplashViewXml = '''
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <com.airbnb.lottie.LottieAnimationView
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toTopOf="parent"
        app:lottie_autoPlay="true"
        app:lottie_rawRes="@raw/splash_screen"
        app:lottie_loop="false"
        app:lottie_speed="1.00" />

</androidx.constraintlayout.widget.ConstraintLayout>
''';

///[Andriod MainActivity.kt]
String _androidMainActivity(String domain) => '''
package $domain

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.SplashScreen

class MainActivity: FlutterActivity() {

override fun provideSplashScreen(): SplashScreen? = SplashView()
}

''';

///[Andriod Mainfest.xml]
String _androidNewMainMinfest(
  String domain,
  String projectname,
) =>
    '''
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="$domain">
   <application
        android:label="$projectname"
        android:name="$applicationName"
        android:icon="@mipmap/ic_launcher">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <!-- Specifies an Android theme to apply to this Activity as soon as
                 the Android process has started. This theme is visible to the user
                 while the Flutter UI initializes. After that, this theme continues
                 to determine the Window background behind the Flutter UI. -->
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <!-- Don't delete the meta-data below.
             This is used by the Flutter tool to generate GeneratedPluginRegistrant.java -->
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
</manifest>
''';

///[Andriod SplashView.kt]
String _anroidSplashView(domain) => '''
package $domain

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import io.flutter.embedding.android.SplashScreen

class SplashView : SplashScreen {
    override fun createSplashView(context: Context, savedInstanceState: Bundle?): View? =
            LayoutInflater.from(context).inflate(R.layout.splash_view, null, false)

    override fun transitionToFlutter(onTransitionComplete: Runnable) {
        onTransitionComplete.run()
    }
}
''';

///[Andriod style]
String _androidStyle = '''
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <!-- Theme applied to the Android Window as soon as the process has started.
         This theme determines the color of the Android Window while your
         Flutter UI initializes, as well as behind your Flutter UI while its
         running.
         This Theme is only used starting with V2 of Flutter's Android embedding. -->
    <style name="NormalTheme" parent="@android:style/Theme.Light.NoTitleBar">
        <item name="android:windowBackground">?android:colorBackground</item>
    </style>
</resources>
''';

/// web
String styleTemplate({
  int fadeOutDuration = 3,
  String backgroundColor = "#ffffff",
}) =>
    '''
.preloader-container {
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow-x: auto;
	overflow-y: scroll;
	position: fixed;
	z-index: 9000;
	display: -webkit-box;
	display: -ms-flexbox;
	display: flex;
	background-color: $backgroundColor;
	-webkit-box-pack: center;
	-ms-flex-pack: center;
	justify-content: center;
	-webkit-box-align: center;
	-ms-flex-align: center;
	align-items: center;
	overflow: hidden;
	-webkit-transition: all ${fadeOutDuration}s linear;
	-o-transition: all ${fadeOutDuration}s linear;
	transition: all ${fadeOutDuration}s linear;
}

.preloader-container .animation {
	display: -webkit-box;
	display: -ms-flexbox;
	display: flex;
	-webkit-box-pack: center;
	-ms-flex-pack: center;
	justify-content: center;
	-webkit-box-align: center;
	-ms-flex-align: center;
	align-items: center;
	-webkit-box-orient: vertical;
	-webkit-box-direction: normal;
	-ms-flex-direction: column;
	flex-direction: column;
}

.preloader-container .animation #skip {
	color: #20495a;
	cursor: pointer;
	font-family: montserrat, sans-serif;
	font-size: 1.75em;
	position: absolute;
	margin: 0 auto;
	bottom: 20vh;
}

.hidden {
	display: none;
}

.visuallyhidden {
	opacity: 0;
}

''';

String indexTemplate({
  String? projectName,
  bool webLoop = true,
  bool webFadeOut = true,
  int height = 200,
  int width = 200,
}) =>
    '''
<!DOCTYPE html>
<html>
  <head>
    <!--
    If you are serving your web app in a path other than the root, change the
    href value below to reflect the base path you are serving from.

    The path provided below has to start and end with a slash "/" in order for
    it to work correctly.

    For more details:
    * https://developer.mozilla.org/en-US/docs/Web/HTML/Element/base

    This is a placeholder for base href that will be replaced by the value of
    the `--base-href` argument provided to `flutter build`.
  -->
    <base href="$_url" />

    <meta charset="UTF-8" />
    <meta content="IE=Edge" http-equiv="X-UA-Compatible" />
    <meta name="description" content="A new Flutter project." />

    <!-- iOS meta tags & icons -->
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="apple-mobile-web-app-title" content="example" />
    <link rel="apple-touch-icon" href="icons/Icon-192.png" />

    <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
    
    <!-- Favicon -->
    <link rel="icon" type="image/png" href="favicon.png" />

    <title>$projectName</title>
    <link rel="stylesheet" href="splash/style.css" />
    <link rel="manifest" href="manifest.json" />

    <script>
      // The value below is injected by flutter build, do not touch.
      const serviceWorkerVersion = null;
    </script>
    <!-- This script adds the flutter initialization JS code -->
    <script src="flutter.js" defer></script>
  </head>
  <body>
    <div id="preloader" class="preloader-container">
      <div class="animation">
        <div class="player">
          <lottie-player
            src="splash/splash.json"
            background="transparent"
            speed="1"
            style="width: ${width}px; height: ${height}px"${webLoop ? '\nloop' : ''}
            autoplay
          ></lottie-player>
        </div>
      </div>
    </div>
    <!-- This script installs service_worker.js to provide PWA functionality to
       application. For more information, see:
       https://developers.google.com/web/fundamentals/primers/service-workers -->
    <script>
      var isInitialized = false
      var isCompleted = false
      let box = document.querySelector("#preloader");
      const animation = document.querySelector("lottie-player");

      animation.addEventListener("complete", () => {
        isCompleted = true
        checkSplashAnimation()
      });
      animation.addEventListener("loop", () => {
        isCompleted = true
        checkSplashAnimation()
      });

      function fadeOutSplashAnimation() {
        box.classList.add("visuallyhidden");
        box.addEventListener(
          "transitionend",
          function (e) {
            box.classList.add("hidden");
          },
          {
            capture: false,
            once: true,
            passive: false,
          }
        );
      }

      function removeSplashAnimation() {
        box.classList.add("hidden");
      }

      function checkSplashAnimation() {
        if(!isCompleted) {
          return;
        }
        if(!isInitialized) {
          return;
        }
        ${webFadeOut ? 'fadeOutSplashAnimation();' : 'removeSplashAnimation();'} 
      }

      window.addEventListener('load', function(ev) {
      // Download main.dart.js
      _flutter.loader.loadEntrypoint({
        serviceWorker: {
          serviceWorkerVersion: serviceWorkerVersion,
        },
        onEntrypointLoaded: function(engineInitializer) {

          engineInitializer.initializeEngine().then(async function(appRunner) {
            await appRunner.runApp();
            isInitialized = true
            checkSplashAnimation();
          });
        }
      });
    });
    </script>
  </body>
</html>

''';
