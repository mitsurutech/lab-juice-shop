#!/usr/bin/env bash
# What the README promises, checked from inside the lab's own network: run by check.sh.
set -euo pipefail
: "${NET:?run through test/check.sh}"
probe() { docker run --rm --network "$NET" lab-check-probe bash -c "$1"; }
echo "- the shop answers"
probe 'curl -fs http://juice-shop:3000/' | grep -q 'OWASP Juice Shop'
probe 'curl -fs http://juice-shop:3000/rest/admin/application-version' | grep -q '"version"'

echo "- the Score Board has its challenges and none is solved yet"
count=$(probe 'curl -fs http://juice-shop:3000/api/Challenges' | python3 -c 'import json,sys; d=json.load(sys.stdin)["data"]; print(len(d), sum(1 for c in d if c["solved"]))')
set -- $count
[ "$1" -gt 80 ] || { echo "expected more than 80 challenges, found $1" >&2; exit 1; }
[ "$2" -eq 0 ] || { echo "a fresh shop should have no solved challenge, found $2" >&2; exit 1; }

echo "- the first classic weakness is really there: SQL injection signs in with no password"
probe "curl -s -H 'Content-Type: application/json' -d '{\"email\":\"'\"'\"' or 1=1--\",\"password\":\"x\"}' http://juice-shop:3000/rest/user/login" | grep -q '"token"'
echo "  ok"
