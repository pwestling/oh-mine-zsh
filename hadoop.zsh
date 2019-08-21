hadoop_cluster_jstack() {

ssh -t $2 "echo $HADOOP_PASSWORD | sudo -S /bin/bash -c 'ps aux | grep $1 | grep -v grep | grep -v bash | tr -s \" \"| cut -d\" \" -f2 | xargs -I%  sudo -u yarn jstack % '" 2>/dev/null

}

hadoop_log_message() {

ssh -t ds$1.liveramp.net "echo $HADOOP_PASSWORD | sudo -S /bin/bash -c 'printf \"\nLogs:\n\" && tail /var/log/messages'" 2>/dev/null

}
