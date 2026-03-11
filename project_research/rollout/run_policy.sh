#!/bin/bash

source /irsl_venv/bin/activate
python -u interfaces_on_rolloutAct.py --use-autocast True --checkpoint /userdir/chk001_a/policy_last.ckpt
## python -u interfaces_on_rolloutAct.py --use-autocast False --checkpoint /userdir/chk001_a/policy_last.ckpt
