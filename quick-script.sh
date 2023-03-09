#!/bin/bash
# https://github.com/redhat-cop/controller_configuration/blob/devel/EXPORT_README.md
#set -x 
# Set default values for options
CONF_HOST="https://openshiftinstall-aap.apps.cluster-n9zwf.n9zwf.sandbox1401.opentlc.com/"
CONF_USERNAME="admin"
CONF_PASSWORD="Qbg9iz2wFBuOQJs0reKFFGcplXOIXkay"
CONF_INSECURE="true"

# Parse command line options
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        --conf.host)
        CONF_HOST="$2"
        shift
        shift
        ;;
        --conf.username)
        CONF_USERNAME="$2"
        shift
        shift
        ;;
        --conf.password)
        CONF_PASSWORD="$2"
        shift
        shift
        ;;
        --conf.insecure)
        CONF_INSECURE="--conf.insecure"
        shift
        ;;
        -h|--help)
        echo "Available options for this command:"
        echo "Option"
        echo "users"
        echo "organizations"
        echo "teams"
        echo "credential_types"
        echo "credentials"
        echo "notification_templates"
        echo "projects"
        echo "inventory"
        echo "inventory_sources"
        echo "job_templates"
        echo "workflow_job_templates"
        awx export --conf.host $CONF_HOST --conf.username $CONF_USERNAME --conf.password $CONF_PASSWORD --conf.insecure --help
        exit
        ;;
        --*)
        echo "Invalid option: $1"
        exit 1
        ;;
        *)
        break
        ;;
    esac
done

# Run the command with the specified options
if [ "$#" -eq 0 ]; then
    echo "No option specified."
    exit 1
fi

COMMAND="awx export $CONF_INSECURE --conf.host $CONF_HOST --conf.username $CONF_USERNAME --conf.password $CONF_PASSWORD --$@ -f yaml"
echo "Running command: $COMMAND  | tee $@.yaml"
$COMMAND  | tee $@.yaml

