#!/bin/sh
curl -H 'Metadata: true' http://169.254.169.254/metadata/instance?api-version=2020-06-01 2>/dev/null >metadata.json
echo 'VM size:' $(jq -r .compute.vmSize metadata.json)
echo 'VM name:' $(jq -r .compute.name metadata.json)
echo 'VM location:' $(jq -r .compute.location metadata.json)
echo 'Resource group:' $(jq -r .compute.resourceGroupName metadata.json)
echo 'Private ip address:' $(jq -r .network.interface[0].ipv4.ipAddress[0].privateIpAddress metadata.json)
echo 'Public ip address:' $(jq -r .network.interface[0].ipv4.ipAddress[0].publicIpAddress metadata.json)
