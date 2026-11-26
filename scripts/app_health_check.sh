#!/bin/bash

# Application Health Checker

URL="${1:-https://wisecow.local/}"

HTTP_CODE=$(curl -k -sS -o /dev/null -w "%{http_code}" \
    --connect-timeout 5 --max-time 10 "$URL" 2>/dev/null)

HTTP_CODE=${HTTP_CODE:-000}

if [[ "$HTTP_CODE" =~ ^2[0-9]{2}$ ]]; then
    echo "UP: $URL returned HTTP $HTTP_CODE"
    exit 0
else
    echo "DOWN: $URL returned HTTP ${HTTP_CODE:-000}"
    exit 1
fi
