#!/bin/bash

export PATH=/Selenium/bin/:$PATH
Xvfb :10 -ac &
export DISPLAY=:10

sed -i '/implicitly/d' $SCRIPT_PATH_NAME
sed -i 's/${TARGET_HOST}/'$TARGET_HOST'/g' $SCRIPT_PATH_NAME
sed -i 's/${TARGET_PORT}/'$TARGET_PORT'/g' $SCRIPT_PATH_NAME

python $SCRIPT_PATH_NAME
