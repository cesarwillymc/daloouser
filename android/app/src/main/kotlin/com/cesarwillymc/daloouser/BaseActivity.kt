package com.thesummitdev.daloo.user.base

import android.content.ActivityNotFoundException
import android.content.Context
import android.content.DialogInterface
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.util.Log
import android.view.View
import android.view.Window
import android.view.WindowManager
import android.view.inputmethod.InputMethodManager
import android.widget.EditText
import android.widget.Toast
import androidx.annotation.LayoutRes
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.snackbar.Snackbar

abstract  class BaseActivity : AppCompatActivity(){
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(getLayout())
    }
    fun hideKeyboard(){
        try{
            val view = this.currentFocus
            view?.let { v ->
                val imm = getSystemService(Context.INPUT_METHOD_SERVICE) as? InputMethodManager
                imm?.hideSoftInputFromWindow(v.windowToken, 0)
            }
        }catch (e: Exception){

        }
    }


    fun EditText.showKeyboard(){
        try{
            val imm = getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
            imm.showSoftInput(this, InputMethodManager.SHOW_IMPLICIT)
        }catch (e: Exception){

        }
    }
    /*fun hideKeyboard(){
        try{
            val dato=   getSystemService(INPUT_METHOD_SERVICE) as InputMethodManager
            dato.toggleSoftInput(InputMethodManager.HIDE_IMPLICIT_ONLY, 0)
        }catch (e: Exception){

        }
    }*/
    fun View.show(){
        this.visibility=View.VISIBLE
    }
    fun View.hide(){
        this.visibility=View.GONE
    }
    @LayoutRes
    protected abstract fun getLayout():Int
    fun View.snackbar(message: String){
        Snackbar.make(this, message, Snackbar.LENGTH_LONG).also { snackbar ->
            snackbar.setAction("Ok"){
                snackbar.dismiss()
            }.show()
        }
    }
    fun navigateToActivity(intent: Intent) {
        Log.e("intent", intent.toString())
        intent.flags= Intent.FLAG_ACTIVITY_CLEAR_TASK
        intent.flags= Intent.FLAG_ACTIVITY_NEW_TASK
        startActivity(intent)
        finish()
    }
    fun showUpdateVersion(){
        val dialogBuilder= AlertDialog.Builder(this)
        dialogBuilder.setMessage("Existe una nueva actualizacion de esta aplicacion, por favor actualizala")
            .setCancelable(true)
            .setPositiveButton(
                "Actualizar ahora",
                DialogInterface.OnClickListener { dialog, which ->
                    openAppInPlayStore("com.thesummitdev.daloo.user")
                    dialog.dismiss()
                })
        val alertDialog= dialogBuilder.create()
        alertDialog.setTitle("Actualizacion Disponible")
        alertDialog.show()
    }
    fun toast(mensaje: String){
        Toast.makeText(this, mensaje, Toast.LENGTH_LONG).show()
    }

    private fun openAppInPlayStore(appPackageName: String){
        try {
            startActivity(
                Intent(
                    Intent.ACTION_VIEW,
                    Uri.parse("market://details?id=$appPackageName")
                )
            )
        }catch (e: ActivityNotFoundException){
            startActivity(
                Intent(
                    Intent.ACTION_VIEW,
                    Uri.parse("https://play.google.com/store/apps/details?id=$appPackageName")
                )
            )
        }
    }

}