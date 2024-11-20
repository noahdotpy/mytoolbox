## Image build - module import structure

`/recipes/image-builds/` import files that match the type of image that they are (bluefin-dx, bluefin, aurora, etc.) from `/recipes/images/`. The file in `/recipes/images/` then imports the correct modules for the image type from /`/recipes/modules/`.

## /recipes/image-builds/

This directory is for all the image build files - sources modules from `/recipes/images/` based on image type.

## /recipes/images/

The files in the directory import all the correct modules from `/recipes/modules/`.

## /recipes/modules/

This directory stores all the modules (rpm-ostree, files, etc.) that actually do the work.
