#!/bin/bash
touch ~/.dialogrc

echo "
# Run-time configuration file for dialog
#
#
#
# Types of values:
#
# Number     -  <number>
# Boolean    -  <ON|OFF>
# Attribute  -  (foreground,background,highlight?)

# Set aspect-ration.
aspect = 0

# Set tab-length (for textbox tab-conversion).
tab_len = 0

# Make tab-traversal for checklist, etc., include the list.
visit_items = OFF

# Shadow dialog boxes? This also turns on color.
use_shadow = ON

# Turn color support ON or OFF
use_colors = ON

# Screen color
screen_color = (RED,BLACK,ON)

# Shadow color
shadow_color = (BLACK,BLACK,ON)

# Dialog box color
dialog_color = (BLACK,WHITE,OFF)

# Dialog box title color
title_color = (RED,WHITE,ON)

# Dialog box border color
border_color = (RED,WHITE,ON)

# Active button color
button_active_color = (WHITE,RED,ON)

# Inactive button color
button_inactive_color = dialog_color

# Active button key color
button_key_active_color = button_active_color

# Inactive button key color
button_key_inactive_color = (RED,WHITE,OFF)

# Active button label color
button_label_active_color = (BLACK,RED,OFF)

# Inactive button label color
button_label_inactive_color = (BLACK,WHITE,ON)

# Input box color
inputbox_color = dialog_color

# Input box border color
inputbox_border_color = dialog_color

# Search box color
searchbox_color = dialog_color

# Search box title color
searchbox_title_color = title_color

# Search box border color
searchbox_border_color = border_color

# File position indicator color
position_indicator_color = title_color

# Menu box color
menubox_color = dialog_color

# Menu box border color
menubox_border_color = border_color

# Item color
item_color = dialog_color

# Selected item color
item_selected_color = button_active_color

# Tag color
tag_color = title_color

# Selected tag color
tag_selected_color = button_label_active_color

# Tag key color
tag_key_color = button_key_inactive_color

# Selected tag key color
tag_key_selected_color = (RED,BLUE,ON)

# Check box color
check_color = dialog_color

# Selected check box color
check_selected_color = button_active_color

# Up arrow color
uarrow_color = (GREEN,WHITE,ON)

# Down arrow color
darrow_color = uarrow_color

# Item help-text color
itemhelp_color = (WHITE,BLACK,OFF)

# Active form text color
form_active_text_color = button_active_color

# Form text color
form_text_color = (WHITE,CYAN,ON)

# Readonly form item color
form_item_readonly_color = (CYAN,WHITE,ON)

# Dialog box gauge color
gauge_color = title_color

# Dialog box border2 color
border2_color = dialog_color

# Input box border2 color
inputbox_border2_color = dialog_color

# Search box border2 color
searchbox_border2_color = dialog_color

# Menu box border2 color
menubox_border2_color = dialog_color" >> ~/.dialogrc
export DIALOGRC= ~/.dialogrc

HEIGHT=15
WIDTH=70
CHOICE_HEIGHT=6
BACKTITLE="Address Book-Sander YAZICIOGLU"
TITLE="Adress Book"
MENU="Welcome ! How can I help you?"
OPTIONS=(1 "Display"
         2 "Search"
         3 "New Add Contact"
         4 "Edit Contact"
         5 "Remove Contact"
         6 "Credits")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1) 
            dialog --title "Address Book" --backtitle "Address Book-Sander YAZICIOGLU" --yesno "`cat addressbook.csv`" 10 100
            dialog --title 'Exit' --backtitle "Address Book-Sander YAZICIOGLU" --msgbox 'Thank You! Good Bye :) ' 15 30
            clear
            ;;
        2)
            OUTPUT="INPUT.txt"
            >$OUTPUT
            dialog --stdout --title "Search Contact" \
            --backtitle "Adress Book-Sander YAZICIOGlU" \
            --inputbox "Please Insert The Word for Search(Case Sensitive)" 0 0 >$OUTPUT
            Word=$(<$OUTPUT)
            grep -F "$Word" addressbook.csv >> output.csv
            dialog --title "Search Result" --yesno "`cat output.csv`" 10 100
            rm $OUTPUT
            rm output.csv
            dialog --title 'Exit' --backtitle "Address Book-Sander YAZICIOGLU" --msgbox 'Thank You! Good Bye :) ' 15 30
            clear
            ;;
        3)
            clear
            echo
            Blank=""
            Name=""
            Surname=""
            Email=""
            Phone=""
            AddressFields=""
            Role=""
            Extra=""
            exec 5>&1
            VALUES=$(dialog --ok-label "Submit" \
	              --backtitle "Adress Book" \
	              --title "New Contact" \
	              --form "Create a new contact" \
            25 70 0 \
	            "Name:" 1 1	"$Name," 	1 10 40 0 \
	            "Surname:"    2 1	"$Surname,"  	2 10 40 0 \
	            "E-Mail:"    3 1	"$Email,"  	3 10 40 0 \
	            "Role:"     4 1	"$Role," 	4 10 40 0 \
	            "Phone:"     5 1	"$Phone," 	5 10 40 0 \
	            "Address Fields:"     6 1	"$AdressFields," 	6 16 80 0 \
	            "Extra:"     7 1	"$Extra" 	7 10 40 0 \
            3>&2 2>&1 1>&3)
            exec 5>&-
            echo $VALUES >> addressbook.csv
            dialog --title 'Exit' --backtitle "Address Book-Sander YAZICIOGLU" --msgbox 'Thank You! Good Bye :) ' 15 30
            clear
            ;;
        4)
            OUTPUT="INPUT.txt"
            >$OUTPUT
            OUTPUT3="INPUT3.txt"
            >$OUTPUT3
            dialog --stdout --title "Edit Contact" \
            --backtitle "Adress Book-Sander YAZICIOGlU" \
            --inputbox "To edit a record, enter any search string, e.g. last name or email address (case sensitive)." 0 0 >$OUTPUT
            Word=$(<$OUTPUT)
            grep -n "$Word" addressbook.csv >> output.csv
            dialog --title "Search Result" --yesno "`cat output.csv`" 10 100
            dialog --stdout --title "Edit Contact" \
            --backtitle "Adress Book-Sander YAZICIOGlU" \
            --inputbox "Enter the line number (the first number of the entry) that you'd like to edit." 0 0 >$OUTPUT3
			echo
            Blank=""
            Name=""
            Surname=""
            Email=""
            Phone=""
            AddressFields=""
            Role=""
            Extra=""
            exec 5>&1
            VALUES=$(dialog --ok-label "Submit" \
	              --backtitle "Adress Book" \
	              --title "Edit Contact" \
	              --form "Edit contact" \
            25 70 0 \
	            "Name:" 1 1	"$Name," 	1 10 40 0 \
	            "Surname:"    2 1	"$Surname,"  	2 10 40 0 \
	            "E-Mail:"    3 1	"$Email,"  	3 10 40 0 \
	            "Role:"     4 1	"$Role," 	4 10 40 0 \
	            "Phone:"     5 1	"$Phone," 	5 10 40 0 \
	            "Address Fields:"     6 1	"$AdressFields," 	6 16 80 0 \
	            "Extra:"     7 1	"$Extra" 	7 10 40 0 \
            3>&2 2>&1 1>&3)
            exec 5>&-
            read -r Name
            
            lineChange="$(<$OUTPUT3)s"
			lineRemove="$(<$OUTPUT3)d"
			sed -i -e "$lineRemove" addressbook.csv
			echo $VALUES >> addressbook.csv
			dialog --msgbox "The change has been made." 0 0
			rm $OUTPUT3
			rm $OUTPUT
            rm output.csv
            dialog --title 'Exit' --backtitle "Address Book-Sander YAZICIOGLU" --msgbox 'Thank You! Good Bye :) ' 15 30
            clear
            ;;
        5)
            OUTPUT="INPUT.txt"
            >$OUTPUT
            OUTPUT3="INPUT3.txt"
            >$OUTPUT3
            dialog --stdout --title "Edit Contact" \
            --backtitle "Adress Book-Sander YAZICIOGlU" \
            --inputbox "To edit a record, enter any search string, e.g. last name or email address (case sensitive)." 0 0 >$OUTPUT
            Word=$(<$OUTPUT)
            grep -n "$Word" addressbook.csv >> output.csv
            dialog --title "Search Result" --yesno "`cat output.csv`" 10 100
            dialog --stdout --title "Edit Contact" \
            --backtitle "Adress Book-Sander YAZICIOGlU" \
            --inputbox "Enter the line number (the first number of the entry) that you'd like to edit." 0 0 >$OUTPUT3
            lineRemove="$(<$OUTPUT3)d"
			sed -i -e "$lineRemove" addressbook.csv
			dialog --msgbox "The record was removed from the address book." 0 0
			rm $OUTPUT3
			rm $OUTPUT
            rm output.csv
            dialog --title 'Exit' --backtitle "Address Book-Sander YAZICIOGLU" --msgbox 'Thank You! Good Bye :) ' 15 30
            clear
            ;;
        6)
            dialog --title 'Credits' --backtitle "Address Book-Sander YAZICIOGLU" --msgbox 'Sander YAZICIOGLU   160709028   Sanderyaz@Gmail.com' 15 30
            dialog --title 'Exit' --backtitle "Address Book-Sander YAZICIOGLU" --msgbox 'Thank You! Good Bye :) ' 15 30
            clear
            ;;
esac

rm ~/.dialogrc
