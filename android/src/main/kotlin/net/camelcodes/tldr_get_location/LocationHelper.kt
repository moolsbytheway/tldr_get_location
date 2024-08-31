package net.camelcodes.tldr_get_location

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.location.Location
import android.location.LocationManager
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.fragment.app.FragmentActivity
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationServices
import com.google.android.gms.tasks.Task

class LocationHelper(private val context: Context, private val activity: FragmentActivity) {

    companion object {
        const val ERROR_LOCATION_PERMISSION_DENIED = 1
        const val ERROR_LOCATION_SERVICE_DISABLED = 2
        const val ERROR_CANNOT_GET_LOCATION = 3
        const val REQUEST_LOCATION_PERMISSION = 100
    }

    private val fusedLocationClient: FusedLocationProviderClient = LocationServices.getFusedLocationProviderClient(context)

    fun getCurrentLocation(onLocationResult: (location: Location?, errorCode: Int?) -> Unit) {
        if (ContextCompat.checkSelfPermission(context, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(activity, arrayOf(Manifest.permission.ACCESS_FINE_LOCATION), REQUEST_LOCATION_PERMISSION)
            onLocationResult(null, ERROR_LOCATION_PERMISSION_DENIED)
            return
        }

        val locationManager = context.getSystemService(Context.LOCATION_SERVICE) as LocationManager
        if (!locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)) {
            onLocationResult(null, ERROR_LOCATION_SERVICE_DISABLED)
            return
        }

        fusedLocationClient.lastLocation.addOnCompleteListener { task: Task<Location> ->
            if (task.isSuccessful && task.result != null) {
                onLocationResult(task.result, null)
            } else {
                onLocationResult(null, ERROR_CANNOT_GET_LOCATION)
            }
        }
    }
}
