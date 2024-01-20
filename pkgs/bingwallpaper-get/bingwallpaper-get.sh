#!/bin/bash

bing_url='https://www.bing.com'
bing_img_url="${bing_url}/HPImageArchive.aspx"
bing_img_params='format=js&idx=0&n=8&mbl=1&mkt=zh-HK'
bing_img_headers='Accept: application/json'
resolution='UHD'
file_type='.jpg'
bing_wallpaper_dir="$HOME/Pictures/BingWallpaper/"

datestr=$(date +'%Y%m%d')
exist_file_re="${bing_wallpaper_dir}${datestr}*${resolution}${file_type}"
exist_file=($exist_file_re)
if [[ -f "${exist_file}" ]]; then
    echo 'Bing wallpaper exist, abort'
    exit 1
fi

response=$(wget -qO- "${bing_img_url}?${bing_img_params}" --header="${bing_img_headers}")

if [[ $? -eq 0 ]]; then
    images=$(echo "${response}" | jq -r '.images')
    latest=$(echo "${images}" | jq -r '.[0]')
    startdate=$(echo "${latest}" | jq -r '.startdate')
    urlbase=$(echo "${latest}" | jq -r '.urlbase')
    img_url="${bing_url}${urlbase}_${resolution}${file_type}"
    file_prefix=$(echo "${img_url}" | sed 's/^.*[\\\/]//;s/th?id=OHR.//')
    file_name="${bing_wallpaper_dir}${startdate}-${file_prefix}"

    if [[ -e ${file_name} ]]; then
        echo 'Today wallpaper exist, abort'
        exit 1
    fi

    echo "Bing wallpaper prepare download from ${img_url} to ${file_name}"
    mkdir -p "${bing_wallpaper_dir}"
    wget -O "${file_name}" "${img_url}" -q --read-timeout=0.1
    echo 'Download success'
    exit 0
else
    echo "Request failed with status code: ${?}"
    exit 1
fi
