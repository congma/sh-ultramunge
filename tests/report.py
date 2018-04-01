#!/usr/bin/env python
import sys
import glob
import json


DBLIST = glob.glob("cov/runall.sh*/coverage.json")
if not DBLIST:
    sys.stderr.write("Error: coverage report database not found.\n")
    sys.exit(1)
with open(DBLIST[0], "r") as REPORT:
    DATA = json.load(REPORT)
sys.stdout.write("Coverage: %s%%\n" % DATA["percent_covered"])
