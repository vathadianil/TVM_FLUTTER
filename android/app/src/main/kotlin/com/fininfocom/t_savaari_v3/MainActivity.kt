package com.fininfocom.tSavaari

import android.os.Bundle
import android.view.MotionEvent
import android.view.InputDevice

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "touch_events"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // Register Method Channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "simulateTouch") {
                val x = call.argument<Int>("x") ?: 0
                val y = call.argument<Int>("y") ?: 0
                simulateTouch(x, y)
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun simulateTouch(x: Int, y: Int) {
        val now = System.currentTimeMillis()

        val touchDown = MotionEvent.obtain(now, now, MotionEvent.ACTION_DOWN, x.toFloat(), y.toFloat(), 0)
        val touchUp = MotionEvent.obtain(now, now, MotionEvent.ACTION_UP, x.toFloat(), y.toFloat(), 0)

        touchDown.source = InputDevice.SOURCE_TOUCHSCREEN
        touchUp.source = InputDevice.SOURCE_TOUCHSCREEN

        window.decorView.dispatchTouchEvent(touchDown)
        window.decorView.dispatchTouchEvent(touchUp)

        touchDown.recycle()
        touchUp.recycle()
    }
}
