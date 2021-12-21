SERVICE_NAME=""
CLUSTER=""
WAIT_FOR_SERVICE=true


set_var() {
    KEY="${1}"
    VAL="${2}"

    echo "${KEY}=${VAL}" >> $GITHUB_ENV
    echo "::set-output name=${KEY}::${VAL}"
}



case "$APP_ENV" in
    dev)
        AWS_ACC_ID=1
        ;;
    stg)
        AWS_ACC_ID=2
        ;;
    prod)
        AWS_ACC_ID=3
        ;;
    *)
        AWS_ACC_ID=4
        ;;
esac

case "$APP_NAME" in
    service1)
        # AWS_ACC_ID=4
        REPO="${DOCKER_REPO_HOST}/service1"
        CLUSTER="cluster1-${APP_ENV}"
        SERVICE_NAME="service_name1"
        ;;
    service2)
        # AWS_ACC_ID=4
        REPO="${DOCKER_REPO_HOST}/service2/worker"
        WAIT_FOR_SERVICE=false
        CLUSTER="workers-${APP_ENV}"
        ;;
    service3)
        # AWS_ACC_ID=4
        REPO="${DOCKER_REPO_HOST}/service3"
        CLUSTER="cluster2-${APP_ENV}"
        ;;
    *)
        REPO="${DOCKER_REPO_HOST}/${APP_NAME//-//}"
        ;;
esac

set_var "DOCKER_IMG_REPO" "${REPO}"
set_var "AWS_ACC_ID" "${AWS_ACC_ID}"
set_var "APP_CLUSTER" "${CLUSTER}"
set_var "APP_SERVICE" "${SERVICE_NAME}"
set_var "WAIT_FOR_SERVICE" "${WAIT_FOR_SERVICE}"
set_var "TASKDEF_JSON" "taskdef/${APP_ENV}/${APP_NAME}.json"