# Kicooya Face SDK (ベータ版)

[English](Readme.md)

Kicooya Face SDK には、UserFace（ユーザー定義の Kicooya の再生画面)を作成するためのツール、およびドキュメントが含まれています。

- **Kicooya Face SDK は現在ベータリリースです。今後、大幅な仕様変更等が発生する可能性があることをご了承ください。**
- **Playdate SDK Ver 2.0.0 時点では、Data Folder にある Lua Script は実行できないため、.pdx の中に UserFace のファイルをコピーして実行しています。 今後、Lua Script が Data Folder から実行できるようになった場合には、UserFace ファイルを Dataフォルダに置くよう変更する予定です。**

## ファイル構成

```text
+- .kicooya         # ビルド、実行用 Shell ファイル
|   |
|   +- Kicooya.pdx  # シミュレータ用バイナリ
|
+- .nova            # Nova 関連ファイル
|
+- .vscode          # Visual Studio Code 関連ファイル
|
+- docs             # ドキュメント
|
+- Source           # サンプルソース
```

## 利用方法

### 1. 環境変数の設定

Kicooya Face SDK で参照する環境変数を設定します。

- **PLAYDATE_SDK_PATH**

    Playdate SDK の PATH を指定してください。Playdate SDK で参照されているものと同じ変数名です。

<!--
- **KICOOYA_PDC_PATH**
    
    kicooya.pdc のパスを指定してください。指定しない場合、SDKに含まれる kicooya.pdc が利用されます。 *(Kicooya 開発用。通常は指定する必要はありません。)*
-->

### 2. UserFace を作成する

Nova または Visual Studio Code を利用して UserFaceを作成できます。(Windos / Mac のみ、Linux は未対応)

- シミュレータでは Kicooya の Face Option 画面のみ確認できます。
- Playdate 実機で動作を確認するには Kicooya をインストールしておく必要があります。

#### Nova

Nova で KicooyaFaceSDK フォルダを開いてください。

1. ビルド

    CTRL + B または ツールバーのビルドボタン

1. 実行

    CTRL + R または ツールバーの実行ボタン

    タスクの設定にあわせて、実行するターゲットが切り替わります。

    |タスク名|ターゲット|
    |-|-|
    |Kicooya Face Device|実機|
    |Kicooya Face Simulator|シミュレータ|

    Lua のブレークポイント (Playdate Lua debugging support) は利用できません。

#### Visual Studio Code

Visual Studio Code で KicooyaFaceSDK フォルダを開いてください。

Windows 環境では Visual Studio Code から bash を利用できるように設定しておく必要があります。

開発環境では [Git Bash](https://gitforwindows.org/) で動作確認しています。

1. ビルド

    コマンドパレット(Ctrl+Shift+P) -> Tasks: Run Task -> Kicooya Face Build

1. シミュレータで実行

    コマンドパレット(Ctrl+Shift+P) -> Tasks: Run Task -> Kicooya Face Build & Run Simulator

1. 実機で実行

    コマンドパレット(Ctrl+Shift+P) -> Tasks: Run Task -> Kicooya Face Build & Run Device

## ドキュメント

1. [face.json Document](docs/json-jp.md)
1. [Kicooya UserFace API Document](docs/api-jp.md)

## サンプル

|リンク|種類|概要|
|-|-|-|
|[Ctrl](./Source/ctrl)|json|コントロールのサンプル。|
|[Lua Audio FQ](./Source/lua)|json, lua|Audio Spectrum を Lua で描画。|
|[MaruMonica](./Source/marumonica)|json, lua|組み込み以外のフォントを使用。[(フォント: マルモニカ)](http://www17.plala.or.jp/xxxxxxx/00ff/)|
|[Text](./Source/text)|json|テキストのサンプル。|
|[zOrder](./Source/zorder)|json, lua|zOrder のサンプル。|

## 翻訳

作者が作成するドキュメントの元は日本語です。英語ドキュメントは機械翻訳を元にしているか、作成されていません。よろしければ、英語ドキュメントの作成、および間違いの指摘にご協力いただけると幸いです。
