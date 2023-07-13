# Kicooya Face SDK （Beta release)

[日本語](Readme-jp.md)

The Kicooya Face SDK includes tools and documentation for creating UserFaces (user-defined Kicooya playback screens).

- **Kicooya Face SDK is currently in Beta release. Please note that there is a possibility of significant specification changes in the future.**
- **As of Playdate SDK Ver 2.0.0, Lua Scripts in the Data Folder cannot be executed, so the face files are copied into .pdx for execution. In the future, when Lua Scripts can be executed from the Data Folder, we plan to change the UserFace files to be placed in the Data folder.**

## Folder structure

```text
+- .kicooya         # Shell files for build and run
|   |
|   +- Kicooya.pdx  # Binary for Simulator
|
+- .nova            # Files for Nova
|
+- .vscode          # Files for Visual Studio Code
|
+- docs             # Documents
|
+- Source           # Sample sources
```

## Usage

### 1. Setting environment variables

Set environment variables for Kicooya Face SDK.

- **PLAYDATE_SDK_PATH**

    Specify the PATH of the Playdate SDK, with the same variable names as in the Playdate SDK.

<!--
- **KICOOYA_PDC_PATH**
    
	Specify the path to kicooya.pdc. If not specified, kicooya.pdc included in SDK is used. *(For Kicooya development. Usually, you do not need to specify it.) *(For Kicooya development. Normally, you do not need to specify.
-->

### 2. Create a UserFace

Nova or Visual Studio Code can be used to create UserFace.

- In the simulator, only Kicooya's Screen of 'Face Option' is available.
- In the Playdate Device, Kicooya must be installed in order to Check if UserFace works.

#### Nova

Open the KicooyaFaceSDK folder in Nova.

1. Build

    CTRL + B or Build button on toolbar

1. Run

    CTRL + R or Run button on toolbar

    The target to be executed switches according to the task settings.

    |Task name|Target|
    |-|-|
    |Kicooya Face Device|Device|
    |Kicooya Face Simulator|Simulator|

    Playdate Lua debugging is not supported.

#### Visual Studio Code

Open the KicooyaFaceSDK folder in Visual Studio Code.

In a Windows environment, bash must be configured to be available from Visual Studio Code.

In the development environment, we have confirmed that it works with [Git Bash](https://gitforwindows.org/).

1. Build

    Command Palette (Ctrl+Shift+P) -> Tasks: Run Task -> Kicooya Face Build

1. Run Simulator

    Command Palette (Ctrl+Shift+P) -> Tasks: Run Task -> Kicooya Face Build & Run Simulator

1. Run Device

    Command Palette (Ctrl+Shift+P) -> Tasks: Run Task -> Kicooya Face Build & Run Device

## Documents

1. [face.json Document](docs/json.md)
1. [Kicooya UserFace API Document](docs/api.md)

## Samples

|Link|Type|Description|
|-|-|-|
|[Ctrl](./Source/ctrl)|json|Sample of control.|
|[Lua Audio FQ](./Source/lua)|json, lua|Audio Spectrum is drawn in Lua.|
|[MaruMonica](./Source/marumonica)|json, lua|Use a font that is not built-in. [(Font: MaruMonica)](http://www17.plala.or.jp/xxxxxxx/00ff/)|
|[Text](./Source/text)|json|Sample of text.|
|[zOrder](./Source/zorder)|json, lua|Sample of zOrder.|

## Translation

The original documentation created by the author is in Japanese. English documentation is either based on machine translation or has not been created. If you would like to help us, we would appreciate it if you could create English documentation and point out any errors.
