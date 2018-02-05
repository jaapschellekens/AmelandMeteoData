#!/bin/csh
touch get_aml_data.log 
~/bin/dcon aml.scr |& tee get_aml_data.log
# Save file to new name (date)
mv downl.gz "`date`.gz"
