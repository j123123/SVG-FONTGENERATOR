#!/bin/sh

width=100

 large=64
medium=32
 small=16

# CLEAN
for size in large medium small
do
  rm -f $size/*
done

# MAKE PNG CHARS
for svgs in *.svg
do
  sed -e "s/stroke-width:20/stroke-width:$width/g" $svgs > "conv_tmp_$svgs"

  for size in large medium small
  do
    convert -scale $((size))x$((size)) "conv_tmp_$svgs" "$size/${svgs:0:1}.png"
  done
  
  rm "conv_tmp_$svgs"
done

# MAKE CHARSET
for size in large medium small
do
  montage  -geometry +0+0  "$size/*.png" "$size/charset.png" # see http://www.imagemagick.org/Usage/montage/
done

