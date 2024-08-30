package com.example.hamster

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.annotation.NonNull

class MainActivity: FlutterActivity() {

    private val CHANNEL = "abe3/hamster/kotlin"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "kotlin") {
                // Simulando uma operação bem-sucedida                
                val value = "Kotlin"
                result.success(value)

            } else if(call.method == "java"){
                // Simulando uma operação com erro
                val acessosJava = MyJavaClass() //-> chamando o arquivo java
                result.success(acessosJava.data)
            } else {
                // Simulando uma operação com erro
                val errorMessage = "Método desconhecido"
                result.error("ERROR", errorMessage, null)
            }
        }
    }
}
