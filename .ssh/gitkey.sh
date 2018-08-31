#!/bin/bash
eval $(ssh-agent -s)
ssh-add -K ~/.ssh/pg_20180125
