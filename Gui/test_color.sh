# You can use out put of this script as blow:
### 1. Run script
### 2. chose one of the choises in the out put
### 3. use before the your text in the printf function or echo -e
### sample: printf '\e[38;5;2m %s' your text

printf '\e[0m********************************\n           Start test\n********************************\n  '
declare -i j=0
for i in {0..255}
do
    ((j++))
    if [ $j -gt 10 ]; then
        j=0
        printf '\n'
    fi
    printf '\e[38;5;%sm' $i
    echo -n "\e[38;5;$im "
    printf '    '
done

printf '\e[0m \n********************************\n           End test\n********************************\n '