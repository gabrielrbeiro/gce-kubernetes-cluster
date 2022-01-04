#!/bin/bash

BASE=".tmp"
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

GROUP=$2
NAME=$1

CWD=$(pwd)

mkdir -p $BASE

rm $BASE/$NAME.{key,csr,crt}

openssl genrsa -out $BASE/$NAME.key 2048
openssl req -new -key $BASE/$NAME.key -out $BASE/$NAME.csr -subj "/CN=${NAME}/O=${GROUP}"

ansible-playbook $SCRIPTPATH/../ansible/cluster-user-playbook.yml -e "user=${NAME} base=${CWD}"

CERT_CA=$(cat $BASE/ca.crt | base64)
CLIENT_CERT=$(cat $BASE/$NAME.crt | base64)
CLIENT_KEY=$(cat $BASE/$NAME.key | base64)

echo "${CERT_CA}:${CLIENT_CERT}:${CLIENT_KEY}" > .user-credentials

rm -rf $BASE
