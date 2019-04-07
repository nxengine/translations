#prepare

cd local
rm -rf data/
mkdir data
mkdir data/lang

Invoke-WebRequest -UseBasicParsing "https://github.com/nxengine/tsc-converter/releases/download/v1.1/tsc-v1.1-Win32.zip" -Out tsc.zip
7z x ./tsc.zip
rm ./tsc.zip

Invoke-WebRequest -UseBasicParsing "https://github.com/nxengine/nx-fontgen/releases/download/v1.3/fontbm-v1.3-Win32.zip" -Out fontbm.zip
7z x ./fontbm.zip
rm ./fontbm.zip

Get-ChildItem -Directory | Where {$_.Name -Match "lang_"} | ForEach-Object {
  echo "Processing $_"

  $name = $_.Name
  $lang = $name.Replace("lang_","")

  mkdir "data/lang/$lang"
  cp -r $name/* "data/lang/$lang"

  Get-ChildItem data/lang/$lang/*.txt | ForEach-Object {
    $txt = $_.Name
    $tsc = $txt.Replace(".txt",".tsc")
    ./tsc.exe data/lang/$lang/$txt data/lang/$lang/$tsc
    rm data/lang/$lang/$txt
  }

  Get-ChildItem data/lang/$lang/Stage/*.txt | ForEach-Object {
    $txt = $_.Name
    $tsc = $txt.Replace(".txt",".tsc")
    ./tsc.exe data/lang/$lang/Stage/$txt data/lang/$lang/Stage/$tsc
    rm data/lang/$lang/Stage/$txt
  }

  $str = Get-Content $name/metadata
  $arr = $str.Split(" ")

  For ($key=1; $key -le 5; $key++) {
    $sizearr = $arr[$key].Split(":")

    $font = $arr[0]
    $tex = $sizearr[1]
    $size = $sizearr[0]
    $chars = $arr[6]
    ./fontbm.exe -F $font --texture-width=$tex --texture-height=$tex -O data/lang/$lang/font_$key -S $size --chars $chars
  }
}

rm -f fontbm.exe
rm -f tsc.exe
rm -rf assets
rm -f *.dll
