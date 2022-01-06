#!/bin/bash

rm lib/assets/constants_images.dart

cd images
images=($(find *.png))
cd ..

echo "class Images {" >> lib/assets/constants_images.dart
echo "  Images._();" >> lib/assets/constants_images.dart

for t in "${images[@]}" ; do
    imagename="${t%.png}"
    echo "  static const $imagename = \"images/$imagename.png\";" >> lib/assets/constants_images.dart
done

echo "}" >> lib/assets/constants_images.dart
