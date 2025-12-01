#!/usr/bin/env bash

set -euo pipefail

# Determine repo root regardless of current working directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

prefix="m4_exp"

bash "$ROOT_DIR/scripts/short_term_forecast/DeepEDM_Daily.sh" $prefix > "$ROOT_DIR/m4_Daily.out" &

bash "$ROOT_DIR/scripts/short_term_forecast/DeepEDM_Hourly.sh" $prefix > "$ROOT_DIR/m4_Hourly.out" &

bash "$ROOT_DIR/scripts/short_term_forecast/DeepEDM_Quarterly.sh" $prefix > "$ROOT_DIR/m4_Quarterly.out" &

bash "$ROOT_DIR/scripts/short_term_forecast/DeepEDM_Monthly.sh" $prefix > "$ROOT_DIR/m4_Monthly.out" &

bash "$ROOT_DIR/scripts/short_term_forecast/DeepEDM_Weekly.sh" $prefix > "$ROOT_DIR/m4_Weekly.out" &

bash "$ROOT_DIR/scripts/short_term_forecast/DeepEDM_Yearly.sh" $prefix > "$ROOT_DIR/m4_Yearly.out"