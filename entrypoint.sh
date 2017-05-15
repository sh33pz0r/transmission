#!/bin/bash

chown -R transmission:nas /config

exec gosu transmission /usr/bin/transmission-daemon -f -g /config --username ${WEBUSER} --password ${WEBPASS} --log-error
