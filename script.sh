#!/bin/bash -e

n=1
n_donwloads=3

n_ids=$(wc -l < $id_file)

n_files=$(ls "data" | wc -l)

if [[ ! -d $data_dir ]]
then
    echo "Creating data folder"
    mkdir $data_dir
fi
mkdir "tmp"

echo "Number of ids: $n_ids"
echo "Number of files: $n_files"
echo "Files pending download: $(($n_ids-$n_files))"

while read id; do
    file="tmp/product-$id.json"
    url="https://tienda.mercadona.es/api/products/$id"
    if [ ! -f "$file" ]; then
        echo "$n. $id"
        curl --fail --show-error --silent $url --output $file
        if [[ "$n" == "$n_donwloads" ]]; then
            break
        fi
        ((n++))
        sleep 2s
    fi
done < <(cat $id_file)

exit 0
