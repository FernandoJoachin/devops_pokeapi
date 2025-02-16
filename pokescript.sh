if [ -z "$1" ]; then
    echo "No se ingreso el nombre de un pokemon"
    echo "Manera de uso: $0 <nombre_pokemon>"
    exit 1
fi

nombre_pokemon=$1
response=$(curl -s "https://pokeapi.co/api/v2/pokemon/$nombre_pokemon")

if [ "$response" != "Not Found" ]; then
    id=$(echo "$response" | jq -r '.id')
    name=$(echo "$response" | jq -r '.name')
    weight=$(echo "$response" | jq -r '.weight')
    height=$(echo "$response" | jq -r '.height')
    order=$(echo "$response" | jq -r '.order')

    echo "$nombre_pokemon (No. $id)"
    echo "Id = $id"
    echo "Weight = $weight"
    echo "Height = $height"
    echo "Order = $order"

    csv_file="pokemon_data.csv"
    if [ ! -f "$csv_file" ]; then
        echo "id,name,weight,height,order" > "$csv_file"
    fi
    
    echo "$id,$name,$weight,$height,$order" >> "$csv_file"
else
    echo "Error: Pokémon '$nombre_pokemon' no encontrado en la API."
fi
