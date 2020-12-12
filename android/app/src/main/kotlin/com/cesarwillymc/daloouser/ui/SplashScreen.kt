package com.cesarwillymc.daloouser.ui

import android.content.Context
import android.content.Intent
import com.thesummitdev.daloo.user.base.BaseActivity
import android.os.Bundle
import android.os.Handler
import androidx.constraintlayout.motion.widget.MotionLayout
import com.cesarwillymc.daloouser.MainActivity
import com.cesarwillymc.daloouser.R
import kotlinx.android.synthetic.main.activity_splash_screen.*

class SplashScreen : BaseActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        Handler().postDelayed({
            motion_scene.transitionToEnd()
        },700L)
        motion_scene.setTransitionListener(object: MotionLayout.TransitionListener{
            override fun onTransitionStarted(p0: MotionLayout?, p1: Int, p2: Int) {

            }

            override fun onTransitionChange(p0: MotionLayout?, p1: Int, p2: Int, p3: Float) {

            }

            override fun onTransitionCompleted(p0: MotionLayout?, p1: Int) {
                funcionObjetc()
            }

            override fun onTransitionTrigger(p0: MotionLayout?, p1: Int, p2: Boolean, p3: Float) {

            }

        })

    }

    private fun funcionObjetc() {
        val mainActivity = Intent(applicationContext, MainActivity::class.java)
        startActivity(mainActivity)
        finish()
        //navMainAdmin()
        // when this activity is about to be launch we need to check if its openened before or not
        /*if (!restorePrefData()) {
            val mainActivity = Intent(applicationContext, IntroActivity::class.java)
            startActivity(mainActivity)
            finish()
        }else{
            navMainAdmin()*/
            /* Handler().postDelayed({
                if (dato != null) {
                    if (getSomeBooleanValue(PREF_LOGEADO)!!) {
                        navMainAdmin()
                    } else {
                        navigationAuth()
                    }
                } else {
                    navigationAuth()
                }
            },500L)*/

     //   }
        
    }
    private fun restorePrefData(): Boolean {
        val pref = applicationContext.getSharedPreferences(
            "myPrefs",
            Context.MODE_PRIVATE
        )
        return pref.getBoolean("isIntroOpnend", false)
    }
    private fun navigationAuth() {
      //  navigateToActivity(Intent(this, AuthActivity::class.java))

    }

    private fun navMainAdmin() {

    }

    override fun getLayout(): Int = R.layout.activity_splash_screen
}
