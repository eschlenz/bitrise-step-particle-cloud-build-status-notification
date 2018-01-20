#!/bin/bash

# exit if a command fails
set -ex

#
# Required parameters
if [ -z "${particle_topic_name}" ] ; then
  echo " [!] Missing required input: particle_topic_name"
  exit 1
fi
if [ -z "${particle_api_access_token}" ] ; then
  echo " [!] Missing required input: particle_api_access_token"
  exit 1
fi
if [ -z "${particle_notification_ttl}" ] ; then
  echo " [!] Missing required input: particle_notification_ttl"
  exit 1
fi
if [ -z "${particle_notification_private}" ] ; then
  echo " [!] Missing required input: particle_notification_private"
  exit 1
fi

echo "Sending notification to the Particle Cloud..."
echo
echo "Topic name  : ${particle_topic_name}"
echo "Build status: ${BITRISE_BUILD_STATUS}"
echo "TTL         : ${particle_notification_ttl}"
echo "Private     : ${particle_notification_private}"

curl https://api.particle.io/v1/devices/events \
	-d "name=${particle_topic_name}" \
	-d "data=${BITRISE_BUILD_STATUS}" \
	-d "ttl=${particle_notification_ttl}" \
	-d "access_token=${particle_api_access_token}" \
	-d "private=${particle_notification_private}"