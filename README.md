### PowerShell script to replace file paths.
Replace local path to sofs path in VRML file

# Introduction
This script reads a VRML (.wrl) file and a replace_table.csv. It goes through each "Inline" line in the VRML file and does replacement of each "old-new" pair in the replace_table.csv.

# Instruction
1. Double click the wrl_path_updater.exe.
2. Select the VRML (.wrl) file to be updated in the popup window.
3. Select your replace_table.csv (the first row must be "old,new") in the new popup window.
4. Click OK.
5. Update VRML file will be saved next to the old VRML file, with suffix "_pathSofs.wrl".

# Note on replace_table.csv
1. The first row must be "old,new" as a header.
2. Consider thoroughly the order of rows. In general, longest path first.
