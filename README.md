# tldr_get_location

TLDR get location

## Getting Started


Update `MainActivity.kt` to extends `FlutterFragmentActivity` vs `FlutterActivity`. 
Otherwise you'll get an error.

```kotlin
//import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
}
```
