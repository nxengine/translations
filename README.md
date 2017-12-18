# NXEngine-evo translations

This is language packs for nxengine-evo (starting from version 2.6)  
See releases.


## For translators:

All scripts should be decoded and stored in UTF-8.  
Additionally, there should be:  
system.json - menu, stages, etc. translations. There's empty one provided in base/  
metadata - this is for font generation, see below.  

## metadata file format

`<font> <font-size-for-scale-1> <font-size-for-scale-2> <font-size-for-scale-3> <font-size-for-scale-4> <font-size-for-scale-5> <characters>`  

Where `<characters>` are comma-separated ranges of required chars. See example in base/ directory,  
and `<font>` is a relative path from [nx-fontgen](https://github.com/nxengine/nx-fontgen) root.  

New fonts, if required, should be submitted to [nx-fontgen](https://github.com/nxengine/nx-fontgen), and be free for required usage.  
(e.g. you can't use/submit MS fonts)

