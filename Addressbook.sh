# coding
linux/bash/trainings - addressbook
#!/bin/bash

addToRecord()
{
	echo
	while true
	do
		echo "To add a record to your address book, please enter the information in this"
		echo "format: \"Last name,first name,phone number\" (no quotes or spaces)."
		echo "Example: Ivanov,Ivan,9108889999"
		echo "If you'd like to quit, enter 'q'."
		read aInput
		if [ "$aInput" == 'q' ]
			then
			break
		fi
		echo
		echo $aInput >> addressbook.csv
		echo "The entry was added to your address book."
		echo
	done
}

displayRecord()
{
	echo
	while true
	do
		echo "To display a record, enter the last name of the person (case sensitive)."
		echo "If you'd like to quit, enter 'q'."
		read dInput
		if [ "$dInput" == 'q' ]
			then
			break
		fi
		echo
		echo "Listing records for \"$dInput\":"
		grep "$dInput" addressbook.csv   # searching the lines by last name (the first field in the record)
		RETURNSTATUS=`echo $?`
		if [ $RETURNSTATUS -eq 1 ]
			then
			echo "No records found with last name of \"$dInput\"."
		fi
		echo
	done
}

removeRecord()
{
	echo 
	while true
	do
		echo "To remove a record, enter a name"
		echo "If you're done, enter 'q' to quit."
		read rInput
		if [ "$rInput" == 'q' ]
			then
			break
		fi
		echo
		echo "Listing records for \"$rInput\":"
		grep -n "$rInput" addressbook.csv
		RETURNSTATUS=`echo $?`
		if [ $RETURNSTATUS -eq 1 ]
			then
			echo "No records found for \"$rInput\""
		else
			echo
			echo "Enter the name of the record you want to remove."
			read lineNumber
			for line in `grep -n "$rInput" addressbook.csv`
			do
				number=`echo "$line" | cut -c1`
				if [ $number -eq $lineNumber ]
					then
					lineRemove="${lineNumber}d"
					sed -i -e "$lineRemove" addressbook.csv
					echo "The record was removed from the address book."
				fi
			done
		fi
		echo
	done
}

searchRecord()
{
	echo
	while true
	do
		echo "To search for a record, enter any search string, e.g. last name or telephone number"
		echo "If you'd like to quit, enter 'q'."
		read sInput
		if [ "$sInput" == 'q' ]
			then
			break
		fi
		echo
		echo "Listing records for \"$sInput\":"
		grep "$sInput" addressbook.csv
		RETURNSTATUS=`echo $?`
		if [ $RETURNSTATUS -eq 1 ]
			then
			echo "No records found for \"$sInput\"."
		fi
		echo
	done
}

quit()
{

echo "If you want to quit press 'q' to exit"
count=0
while : ; do
read -n 1 k <&1
if [[ $k = q ]] ; then
printf "\nQuitting from this address book\n"
break
else
((count=$count+1))
printf "\nIterate for $count times\n"
echo "Press 'q' to exit"
fi
done
}

echo "Hello, what would you like to do with your address book?"
echo "Please enter one of the following numbers:"
echo "1) to add a record"
echo "2) to display all your records"
echo "3) to remove a record"
echo "4) to search for records"
echo "5) to quit this address book"
read input

case $input in
	1) addToRecord;;
	2) displayRecord;;
	3) removeRecord;;
	4) searchRecord;;
	5) quit;;
esac


