#!/bin/bash -e

id_file=$1
n_donwloads=120

n_ids=$(wc -l < $id_file)

n_files=$(ls "data" | wc -l)

echo "Creating folder tmp"
mkdir "./tmp"

echo "Number of ids: $n_ids"
echo "Number of files: $n_files"
echo "Files pending download: $(($n_ids-$n_files))"

n=1

while (( n <= n_donwloads )) && read id; do
    file="product-$id.json"
    url="https://tienda.mercadona.es/api/products/$id/?lang=es&wh=alc1"
    if [ ! -f "data/$file" ]; then
        echo "$n. $id"
        curl --fail --show-error --silent $url --output "tmp/$file"
        ((n++))
        sleep 2s
    fi
done < <(cat $id_file)

exit 0
