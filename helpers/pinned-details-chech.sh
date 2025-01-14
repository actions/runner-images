#!/bin/bash

toolset_files=$(find . -name 'toolset-*.json')

for toolset_file in $toolset_files; do
    if [[ "$toolset_file" == *"toolset-schema.json" ]]; then
        continue
    fi

    readarray -t pinned_details < <(jq --compact-output '.. | objects | select(has("review-at"))' "$toolset_file")

    for pinned_detail in "${pinned_details[@]}"; do
        review_date=$(jq -r '.["review-at"]' <<< "$pinned_detail")
        reason=$(jq -r '.["reason"]' <<< "$pinned_detail")

        if [ -n "$review_date" ]; then
            if [ "$(date -d "$review_date" +%s)" -gt "$(date +%s)" ]; then
                echo "ERROR: Overdue review date: $review_date for tool in $toolset_file"
                echo "       Pinned for '$reason'"
                echo ""
            fi

            if [ "$(date -d "$review_date" +%s)" -le $(( $(date +%s) - 7*24*60*60 )) ]; then
                echo "WARNING: Review date is coming up within the next 7 days: $review_date for tool in $toolset_file"
                echo "         Pinned for '$reason'"
                echo ""
            fi
        fi
    done
done
