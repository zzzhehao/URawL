## **U**RawL is an Unsophisticated R script for assisting Raw file handling in Lightroom

This R script was developed for my workflow as follows:

- Shoot RAW + JPG. Store JPGs in the folder `./JPG` and raw files in `./RAW`.
- Import all JPEGs into Lightroom, flag photos as "picked" for subsequent processing, and leave the photos as-is to omit.
- After selecting all photos, right-click on them and update the metadata (right-click> Metadata > Save Metadata to Files). This step will write the flag information into the XMP attributes of those JPG files.
- Run the script. The script will identify the file names of the selected photos and move the unpicked RAW files to a new folder `unpicked_RAW`. 
- Now, only the raw files of picked photos are in the RAW folder.

I find this workflow particularly useful when shooting events such as weddings, where many images end up unusable. It also prevents me to deal with raw files of unwanted photos (they are so goddamn huge!!). 

The script requires packages tidyverse and exifr.
