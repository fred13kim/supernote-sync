#!/bin/bash
path=$(pwd)

pflag=

while getopts p: o
do
    case $o in
        p)  pflag=1
            page="$OPTARG"
            ;;
        *)  printf "Usage: %s:\n" $0 1>&2;
            exit 1;;
    esac
done
shift $(($OPTIND - 1))

file=$*

if [ -z "$file" ]; then
    printf "Usage: %s: <file>\n" $0 1>&2;
    exit 1
fi

base="${file##*/}"
filename="${base%.*}"
extension="${base##*.}"
if [ $extension != "note" ]; then
    printf "Error: %s is not a valid format of input\n"
    exit 1
fi

if [ ! -z "$pflag" ]; then
    printf "page"
    #supernote-tool convert -n $page -t pdf $file
else
    printf "all"
fi
printf "$file\n"
printf "$page\n"
supernote-tool convert -n 99 -t pdf psets.note test.pdf
printf "$?"
