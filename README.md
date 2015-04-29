# android-color-swatch-maker

## Usage

### 実行

```
$ ruby acsm.rb  --path 'Users/tsukajizo/Documents/projects/android/HogeProject/app/src/main/res/'
```

### 結果
* ファイルが作成される

```
.
├── acsm.rb
├── bin
│   └── android.ase #<= added

```

* Photoshop / Illsutratorなどに取り込む

![swatch.png](docs/images/swatch.png)


## Options

### --path value / --p value
Androidプロジェクト、もしくはその中のリソースファイルを指定することができます。

```
$ ruby acsm.rb  --path 'Users/tsukajizo/Documents/projects/android/HogeProject/app/src/main/res/'
```

デフォルトでは、カレントディレクトリ以下の全てのXMLファイルから、設定されている色の情報を取得し、ASEファイルを作成します。


### --output value / --o value

出力するASEファイルの名前が指定できます。

```
$ ruby acsm.rb  --output 'sample.ase'
```

デフォルト値 : android.ase

### --name value / --n value

出力するASEファイルに含まれるパレット名が指定できます。これらのパレット名はIllustrator取り込み時に表示されるものです。

デフォルト値 : Android

ex.

```
$ ruby acsm.rb  --n 'Hoge'
```

![palette.png](docs/images/palette.png)
