#!/bin/bash

safeRunCommand() {
    typeset command="$*"
    typeset ret_code

    eval ${command}
    ret_code=$?
    if [[ ${ret_code} != 0 ]] && [[ ${ret_code} != 4 ]] && [[ ${ret_code} != 129 ]]; then
        printf "Error : [%d] when executing command: '${command}' \n" ${ret_code}
        exit ${ret_code}
    fi
}

usage="Usage:  ./run.sh [[-b -c -d -f -p]|[-h]]

Run project. Script without options runs development mode without replacing existing configs.

Options:
  -b, --build        Rebuild docker image before run
"

PREFIX="dev_"

while [[ $# -gt 0 ]]
do
    key="$1"

    case ${key} in
        -b|--build)
        REBUILD=TRUE
        echo "- Rebuild docker containers before run"
        shift
        ;;
    esac
done

echo "Increasing virtual memory limit..."
sudo sysctl -w vm.max_map_count=262144



if [[ ! -d "database_data" ]]; then
    mkdir database_data
fi


echo "Executing docker-compose..."
if [[ "${REBUILD}" = TRUE ]]; then
    safeRunCommand "docker-compose up -d --build --force-recreate"
else
    safeRunCommand "docker-compose up -d"
fi

if ! [[ "${FAST}" = TRUE ]]; then
    echo "Executing composer install..."
        safeRunCommand "docker-compose exec -T ${PREFIX}php composer install"

    echo "Executing migrations..."
    safeRunCommand "docker-compose exec -T ${PREFIX}php php bin/console --no-interaction doctrine:migrations:migrate"
fi
