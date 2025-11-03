# Framework  de Automatización de Pruebas en la App de Mercado Libre (Ruby + Appium + Cucumber).

Este repositorio contiene la implementación de un framework de automatización de pruebas funcionales para la aplicación movile de Mercado Libre (Android). Para su desarrollo se utilizaron las herramientas **Ruby**, **Appium**, y **Cucumber**.En dicho proyecto se encuentra un caso de prueba que implementa los siguientes pasos:

Functionality to Test: Validate a search flow and filter functionality in the Mercado Libre mobile application.

  Steps:
  
    1- Open the Mercado Libre mobile application installed on the Android device.
    2- Search for the term “playstation 5” in the search bar.
    3- Apply the filter for condition “Nuevos”.
    4- Apply the filter for location “CDMX”.
    5- Order the results by “mayor a menor precio”.
    6- Obtain the name and the price of the first 5 products displayed in the results.
    7- Print these products (name and price) in the console.

#### (Nota 1: El step 4 solicita aplicar un filtro por localidad en CDMX, sin embargo, en la aplicación de mercado libre no existe ningún filtro explícito de locación por ciudad, para solventar esto de ingreso un código postal de la CDMX en su lugar.) 
#### (Nota 2: Los steps 3 y 5 no están implementados correctamente en esta versión del proyecto debido a problemas para identificar los selectores de los filtros, actualmente la implementación de estos steps se encuentra comentada en el código.)
---

## Estructura del repositorio

```text
Mobile-Automation-Test-for-Mercado-Libre-Application/
├── elements
│   ├── EBase.rb
│   └── ENavigation.rb
├── features
│   ├── steps
│   │   └── Naigation.rb
│   ├── support
│   │   ├── app_bootstrap.rb
│   │   ├── Hooks.rb
│   │   └── runner.rb
│   └── Navigation.feature
├── pages
│   ├── BasePage.rb
│   └── NavigationPage.rb
└── reports
    └──cucumber.html
```
---

## 1. Requisitos

### 1.1. Instalar Node.js

1. Ve al sitio oficial de Node.js: https://nodejs.org/es/download
2. Descarga el instalador para tu sistema operativo (Windows, macOS o Linux).
3. Ejecuta el instalador
4. Verifica la instalación, ejecuta en una linea de comandos:

```bash
node -v
```

### 1.2 Appium

Ejecuta en una linea de comando las siguientes instrucciones:

```bash
npm install -g appium
npm install -g appium-doctor
appium-doctor      # comprueba dependencias
```

### 1.3. Instalar **UiAutomator2** (driver Android para Appium)

```bash
appium driver install uiautomator2
appium driver list --installed   # verifica que aparezca uiautomator2
```

### 1.4. Instalar Ruby + Bundler

1. Descarga de <https://rubyinstaller.org>  
2. Durante la instalación marca **“Add Ruby executables to your PATH”**
3. Verifica:

```bash
ruby -v
gem -v
```

4. Instala dependencias del proyecto:

```bash
gem install bundler
bundle install      # estando en la carpeta que contiene el Gemfile
```

### 1.5. Instalar Android SDK + ADB

1. Descarga **Platform Tools**: <https://developer.android.com/studio/releases/platform-tools>  
2. Extrae en una ubicación fija. Ejemplo:

```
F:\Escuela\Android\Sdk
```

3. **Variables de entorno**  
   - Crea `ANDROID_HOME` (o `ANDROID_SDK_ROOT`) = `F:\Escuela\Android\Sdk`  
   - Edita `Path` y agrega:

     ```
     %ANDROID_HOME%\platform-tools
     %ANDROID_HOME%\tools   # (si existe)
     ```

4. Reinicia la terminal y verifica:

```bash
echo %ANDROID_HOME%
adb devices
```

---

## 2. Configurar el dispositivo Android

| Paso | Acción |
|------|--------|
| 1 | Ve a Ajustes en tu dispositivo.|[s](url)
| 2 | Toca en Información del dispositivo o Acerca del teléfono.|
| 3 | Busca la opción Número de compilación y tócala varias veces (hasta que aparezca el mensaje "modo desarrollador activado")|
| 5 | Regresa a los Ajustes y verás una nueva opción llamada **Opciones de desarrollador**, ingresa ahí.|
| 6 | Habilita **Depuración por USB**|
| 7 | Ingresa a **Configuracion USB predeterminada** y escoge **MIDI**|
| 8 | Conecta el teléfono con **cable de datos** |
| 9 | Acepta el aviso “¿Permitir depuración USB desde este ordenador?” |

Comprueba conexión, ingresa en una linea de comando:

``` bash
adb devices
# Debe listar tu dispositivo como "device"
```

---

## 3. Iniciar Appium Server

En una terminal independiente:

```bash
appium
```

Salida esperada:

```
[Appium] Appium REST http interface listener started on 0.0.0.0:4723
```

---

## 4. Ejecutar la prueba

En otra terminal, dentro de la ruta del proyecto ejecuta alguna de las siguientes opciones

### Opcion 1
```bash
bundle exec cucumber
```
### Opcion 2
```bash
cucumber
```

## 5. Reporte
En la ruta del proyecto `reports\cucumber.html` se encuantra el reporte de ejecucion de la ultima prueba realizada. Abre el reporte en el navegador, en la parte infeior se enciantran las capturas de pantalla de cada uno de los steps ejecutados.


## 6. Solución de problemas frecuentes

| Error | Causa | Solución |
|-------|-------|----------|
| `Could not locate Gemfile` | Ejecución en carpeta equivocada | Ve a la carpeta donde está el `Gemfile` |
| `uiautomator2 driver… not installed` | Falta driver Android | `appium driver install uiautomator2` |
| `Neither ANDROID_HOME nor ANDROID_SDK_ROOT…` | Variable de entorno no definida | Crear `ANDROID_HOME` apuntando al SDK y agregar `platform-tools` al `Path` |
| `ECONNREFUSED 127.0.0.1:4723` | Appium Server no iniciado | Ejecuta `appium` antes de correr el script |
| `adb no se reconoce…` | ADB fuera del `Path` | Instalar platform‑tools y agregar al `Path` |
| Dispositivo no aparece con `adb devices` | Sin depuración USB / drivers | Activar Depuración USB, aceptar huella RSA, reinstalar drivers |

---

## 7. Ajustes rápidos de capabilities

Las “desired capabilities” se encuentran en la ruta `features\support\runner.rb`:

```ruby
caps = {
        platformName: "Android",
        automationName: "UiAutomator2",
        deviceName: "a52q",
        appPackage: "com.mercadolibre",
        appActivity: "com.mercadolibre.splash.SplashActivity",
        noReset: true,
        newCommandTimeout: 3600,
        appWaitActivity: "com.mercadolibre.*, com.google.android.gms.*",
        appWaitDuration: 20000
}
```
---

## 8. Licencia
Este proyecto está licenciado bajo la Licencia [MIT] - mira el archivo LICENSE.txt para detalles.

---
