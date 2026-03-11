#!/bin/bash

source /irsl_venv/bin/activate
# python -u interfaces_on_rolloutAct.py --device cpu --checkpoint /userdir/chk001_a/policy_last.ckpt
python -u interfaces_on_rolloutAct.py --device cpu --use-autocast t --checkpoint /userdir/chk001_a/policy_last.ckpt
