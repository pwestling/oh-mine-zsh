consul_addr=$(ifconfig | grep -Eo "10\.[0-9]+\.[0-9]+\.[0-9]+")

if [[ ! $(ps aux | grep "consul agent" | grep -v grep) ]]; then
  consul agent -data-dir=/tmp/consul -config-dir=/etc/consul/config -join=consul-server01.liveramp.net -bind=$consul_addr -datacenter legacy-zone 2>&1 > /tmp/consul/consul.log &
fi
