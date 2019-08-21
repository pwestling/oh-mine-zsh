rerun_vault_search_query(){
search=$(cat data_bags/$1/$2_keys.json | jq -r .search_query) 
chef exec knife vault update $1 $2 -S "${search}"

}
vault_add_to_search(){
search=$(cat data_bags/$1/$2_keys.json | jq -r .search_query) 
chef exec knife vault update $1 $2 -S "${search} OR $3"
}

PATH=$PATH:/opt/chefdk/bin/
