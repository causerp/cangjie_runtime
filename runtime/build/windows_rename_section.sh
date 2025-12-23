#!/bin/bash

# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

get_sections() {
    local file="$1"
    if command -v objdump >/dev/null 2>&1; then
        objdump -h "$file" 2>/dev/null | \
            awk '/^ +[0-9]+ / {print $2}' | \
            grep -E '^\.text' || true
        return $?
    fi
}

process_file() {
  local input_file="$1"
  local output_file="$1"

  sections=$(get_sections "$input_file")
  local rename_args=()
  while IFS= read -r section; do
      if [[ -n "$section" ]]; then
          suffix="${section#.text}"
          new_section=".text_rt${suffix}"
          rename_args+=("--rename-section" "$section=$new_section")
      fi
  done <<< "$sections"

  if [ "${#rename_args[@]}" -eq 0 ]; then
    return 0
  fi
    
  if objcopy "${rename_args[@]}" "$input_file" "$output_file" 2>/dev/null; then
    return 0
  else
    return 1
  fi
}

input_file=$1
echo "rename section, input: ${input_file}, output: ${input_file}"
process_file "$input_file" "$output_file"
