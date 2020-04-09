#！/bin/bash
generate()
{
    rand=$(($1 + RANDOM%(1+$1-$2)))
}
# check the generated age
generate "20" "70"

while true
do
    echo -n "Guess the my age: "
    read ans
    if [[ $ans -gt $rand ]]
    then
        echo "Your guess is higher than the correct age"
    elif [[ $ans -lt $rand ]]
    then
        echo "Your guess is lower than the correct age"
    else
        echo "Congratulations!! You got it right!!"
        break
    fi
done
echo "Goodbye! Have a nice day :) "
exit 0