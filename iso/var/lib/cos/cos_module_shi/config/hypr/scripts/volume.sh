#!/usr/bin/env sh

# define functions
function print_error
{
cat << "EOF"
    ./volume.sh -[device] <action>
    valid device are
        i -- [i]nput decive
        o -- [o]utput device
    valid actions are
        i -- <i>ncrease volume [+5]
        d -- <d>ecrease volume [-5]
        m -- <m>ute [x]
EOF
exit 1
}

# set device source
while getopts io SetSrc
do
    case $SetSrc in
    i) nsink=$(pamixer --list-sources | grep "_input." | head -1 | awk -F '" "' '{print $NF}' | sed 's/"//')
        srce="--default-source"
        dvce="mic" ;;
    o) nsink=$(pamixer --get-default-sink | grep "_output." | awk -F '" "' '{print $NF}' | sed 's/"//')
        srce=""
        dvce="speaker" ;;
    esac
done

if [ $OPTIND -eq 1 ] ; then
    print_error
fi


# set device action
shift $((OPTIND -1))
step="${2:-5}"

case $1 in
    i) pamixer $srce -i ${step} ;;
    d) pamixer $srce -d ${step} ;;
    m) pamixer $srce -t ;;
    *) print_error ;;
esac