library(tidyverse)
library(exifr)

del_files.destination.folder <- "unpicked_RAW"

jpeg_files <- list.files(path = "JPG", pattern = "\\.jpg$|\\.JPG$|\\.jpeg$|\\.JPEG$", full.names = TRUE)
metadata <- read_exif(jpeg_files, tags = c("SourceFiles", "Good", "Rating"))

metadata %>% 
    filter(Good) %>%
    nrow() %>% 
    paste0("Detected ", ., " picked photos.") %>%
    print()

proceed <- if (readline("Type `y` to proceed.\n>>>") == "y") T else F

if (!proceed) stop("Abort.")

unpicked_photos <- metadata %>% 
    filter(is.na(Good) | Good == F) %>% 
    pull(SourceFile) %>%
    gsub(regex("^JPG/"), "", x = .) %>%
    gsub("\\.jpg$|\\.JPG$|\\.jpeg$|\\.JPEG$", "", x = .)

raw_files <- data.frame(
    path = list.files(path = "RAW", pattern = "\\.NEF$", full.names = TRUE), 
    file.name = list.files(path = "RAW", pattern = "\\.NEF$", full.names = F) %>% gsub("\\..{3}$", "", x = .)) %>%
    mutate(
        del = file.name %in% unpicked_photos
    )

del_files <- raw_files %>% 
    filter(del) %>% 
    pull(path)

del_files.destination <- gsub("^RAW/", paste0(del_files.destination.folder, "/"), del_files)

dir.create(del_files.destination.folder)

res <- file.rename(del_files, del_files.destination)

if (any(!res)) warning("Not all files moved successfully.")
