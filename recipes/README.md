## Image build - module import structure

`/recipes/images/` import files that match the type of image that they are (bluefin-dx, bluefin, aurora, etc.) from `/recipes/image-modules/`. The file in `/recipes/image-modules/` then imports the correct modules for the image type from /`/recipes/modules/`.

## /recipes/images/

This directory is for all the image build files - sources modules from `/recipes/image-modules/` based on image type.

## /recipes/image-modules/

The files in the directory import all the correct modules from `/recipes/modules/`.

## /recipes/modules/

This directory stores all the modules (rpm-ostree, files, etc.) that actually do the work.
