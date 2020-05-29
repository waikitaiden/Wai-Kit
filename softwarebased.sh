#retrieve data from the website by using curl and save it into a file called target.html
#then using cat command to read the file
#use grep command to search lines that include alt="DSC" and substitutes unneccessary symbols into a spacebar
#then save it into an output file called halo.csv
curl https://www.ecu.edu.au/service-centres/MACSC/gallery/gallery.php?folder=152 > target.html
cat target.html | grep "alt=\"DSC" | sed 's/<img src="//g; s/" alt="/,/g; s/">//g' > halo.csv
tr -d " \t" < halo.csv > halo1.csv
rm halo.csv
rm target.html
#interact with the user 
echo "Enter the number to select a function"
echo "1. Download a specific thumnail"
echo "2. Download all"
echo "3. Download by range"
echo "4. Random download"
read -p "Your choice: " choice
#if the user wants to download the pictures he selected
if [ $choice -eq 1 ]
then
    mkdir SELECTED
    read -p "Enter the picture ID: " pictureID
    cat halo1.csv | grep "$pictureID" | curl "$(cut -f 1 -d ',')" > ./SELECTED/"$pictureID".jpg
#if the user wants to download all the pictures 
elif [ $choice -eq 2 ]
then
    mkdir ALL
    input="halo1.csv"
    while IFS=, read -r linkToImage imageID
    do
        curl "$linkToImage" > ./ALL/"$imageID".jpg
    done < "$input"
#if the user wants to download the pictures within a range
elif [ $choice -eq 3 ]
then
    read -p "Enter the starting number: " headNum
    read -p "Enter the ending number: " tailNum
    mkdir RANGE
    input="halo1.csv"
    while IFS=, read -r linkToImage imageID
    do
        if [ $headNum -le "$(echo "$imageID" | cut -c 4-8)" ] && [ $tailNum -ge "$(echo "$imageID" | cut -c 4-8)" ]
        then
            curl "$linkToImage" > ./RANGE/"$imageID".jpg
        fi
    done < "$input"
#if the user wants to download the picture randomly
#jot-r is a command that generates numbers or characters randomly
#after that we use sort -n to sort the sequence numerically 
elif [ $choice -eq 4 ]
then
    read -p "Enter the number of images: " numberOfImage
    jot -r "$(wc -l halo1.csv)" 1 |
    paste - halo1.csv |
    sort -n |
    cut -f 2- |
    head -n $numberOfImage > random.csv
    mkdir RANDOM
    input="random.csv"
    while IFS=, read -r linkToImage imageID
    do
        curl "$linkToImage" > ./RANDOM/"$imageID".jpg
    done < "$input"
    rm random.csv
#say goodbye to the user after finish downloading
else
    echo "Goodbye..."
fi
#we remove the file halo1.csv
rm halo1.csv