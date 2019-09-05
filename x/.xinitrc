#!/bin/bash
${HOME}/bin/startup.sh &
xrdb -I ${HOME} ~/.Xresources
exec awesome
