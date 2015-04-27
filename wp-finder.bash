#!/bin/bash

function help {
	echo Usage:\t\t $0 [DEPTH] [LIST OF SITES]
	echo DEPTH:\t\t How deeply to follow links in the search for WordPress sites.
	echo LIST OF SITES:\t A number of sites which make the search basis for finding WP sites.
}

if [[ $# == 0 ]]; then
	echo No arguments given.
	help
fi

if [[ $# == 1 ]]; then
	echo At least one site must be given as a search basis.
	help
fi

depth=$1
shift 1

cd "$(dirname $0)"
if [[ ! -d ./sites ]]; then
	mkdir sites
fi
cd sites

for url in $@; do
	wget -q -r $depth -R jpg,gif,png,ico,svg,pdf,css,js,mp3,mp4,m4v,mov,ogg,ogv,zip,flv,webm,avi $url -p ./sites
done

find ./ -iname "robots.txt" -exec if grep -P -q -H -i "(wordpress|wp)" {} ; then echo {}; fi \;
