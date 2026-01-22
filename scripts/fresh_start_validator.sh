#!/bin/bash
# ============================================================================
# Fresh Start Validator
# Validates an entity directory against Protocol specification
#
# Usage: ./fresh_start_validator.sh [path] [--tier1|--tier2] [--json] [--fix]
#
# Spec Version: 2.4
# ============================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
ENTITY_PATH="${1:-.}"
TIER="2"
OUTPUT_FORMAT="text"
FIX_MODE=false

# Parse arguments
for arg in "$@"; do
    case $arg in
        --tier1) TIER="1" ;;
        --tier2) TIER="2" ;;
        --json) OUTPUT_FORMAT="json" ;;
        --fix) FIX_MODE=true ;;
        --help|-h)
            echo "Fresh Start Validator - Validate entity against Protocol spec"
            echo ""
            echo "Usage: $0 [path] [options]"
            echo ""
            echo "Options:"
            echo "  --tier1    Validate as Tier 1 (minimal) entity"
            echo "  --tier2    Validate as Tier 2 (full) entity (default)"
            echo "  --json     Output results as JSON"
            echo "  --fix      Attempt to fix missing directories"
            echo "  --help     Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0 ./my-entity --tier2"
            echo "  $0 /path/to/entity --tier1 --json"
            exit 0
            ;;
    esac
done

# Counters
PASS=0
WARN=0
FAIL=0
RESULTS=()

# ============================================================================
# Helper Functions
# ============================================================================

check_file() {
    local path="$1"
    local description="$2"
    local severity="${3:-FAIL}"

    if [[ -f "$ENTITY_PATH/$path" ]]; then
        RESULTS+=("PASS|$description|$path exists")
        ((PASS++))
        return 0
    else
        if [[ "$severity" == "WARN" ]]; then
            RESULTS+=("WARN|$description|$path missing")
            ((WARN++))
        else
            RESULTS+=("FAIL|$description|$path missing")
            ((FAIL++))
        fi
        return 1
    fi
}

check_dir() {
    local path="$1"
    local description="$2"
    local severity="${3:-FAIL}"

    if [[ -d "$ENTITY_PATH/$path" ]]; then
        RESULTS+=("PASS|$description|$path exists")
        ((PASS++))
        return 0
    else
        if [[ "$severity" == "WARN" ]]; then
            RESULTS+=("WARN|$description|$path missing")
            ((WARN++))
        else
            RESULTS+=("FAIL|$description|$path missing")
            ((FAIL++))
        fi

        # Fix mode: create missing directory
        if [[ "$FIX_MODE" == true && "$severity" != "WARN" ]]; then
            mkdir -p "$ENTITY_PATH/$path"
            RESULTS+=("INFO|Auto-fix|Created $path")
        fi

        return 1
    fi
}

check_content() {
    local path="$1"
    local pattern="$2"
    local description="$3"
    local severity="${4:-WARN}"

    if [[ -f "$ENTITY_PATH/$path" ]] && grep -q "$pattern" "$ENTITY_PATH/$path" 2>/dev/null; then
        RESULTS+=("PASS|$description|Pattern found in $path")
        ((PASS++))
        return 0
    else
        if [[ "$severity" == "WARN" ]]; then
            RESULTS+=("WARN|$description|Pattern not found in $path")
            ((WARN++))
        else
            RESULTS+=("FAIL|$description|Pattern not found in $path")
            ((FAIL++))
        fi
        return 1
    fi
}

# ============================================================================
# Tier 1 Checks (Required for all entities)
# ============================================================================

tier1_checks() {
    echo -e "${BLUE}=== Tier 1 Checks (Minimal Entity) ===${NC}"

    # T1-01: CLAUDE.md exists
    check_file "CLAUDE.md" "T1-01: CLAUDE.md exists"

    # T1-02: context/kernel/ directory
    check_dir "context/kernel" "T1-02: Kernel context directory"

    # T1-03: role_definition.md exists
    check_file "context/kernel/role_definition.md" "T1-03: Role definition exists"

    # T1-04: CLAUDE.md has role reference
    check_content "CLAUDE.md" "role" "T1-04: CLAUDE.md references role" "WARN"

    # T1-05: Token budget reasonable
    if [[ -f "$ENTITY_PATH/CLAUDE.md" ]]; then
        local tokens=$(wc -w < "$ENTITY_PATH/CLAUDE.md")
        if [[ $tokens -lt 3000 ]]; then
            RESULTS+=("PASS|T1-05: Token budget|CLAUDE.md is $tokens words (reasonable)")
            ((PASS++))
        else
            RESULTS+=("WARN|T1-05: Token budget|CLAUDE.md is $tokens words (may be heavy)")
            ((WARN++))
        fi
    fi
}

# ============================================================================
# Tier 2 Checks (Full entity)
# ============================================================================

tier2_checks() {
    echo -e "${BLUE}=== Tier 2 Checks (Full Entity) ===${NC}"

    # T2-01: operating_principles.md
    check_file "context/kernel/operating_principles.md" "T2-01: Operating principles"

    # T2-02: persona_profile.md
    check_file "context/kernel/persona_profile.md" "T2-02: Persona profile" "WARN"

    # T2-03: _summary.md
    check_file "context/kernel/_summary.md" "T2-03: Kernel summary" "WARN"

    # T2-04: memory/ directory
    check_dir "memory" "T2-04: Memory directory"

    # T2-05: memory/sessions/
    check_dir "memory/sessions" "T2-05: Sessions directory"

    # T2-06: memory/sessions/exports/
    check_dir "memory/sessions/exports" "T2-06: Session exports directory"

    # T2-07: memory/evolution/
    check_dir "memory/evolution" "T2-07: Evolution directory"

    # T2-08: memory/evolution/learnings/
    check_dir "memory/evolution/learnings" "T2-08: Learnings directory"

    # T2-09: memory/evolution/decisions/
    check_dir "memory/evolution/decisions" "T2-09: Decisions directory"

    # T2-10: memory/inbox/
    check_dir "memory/inbox" "T2-10: Inbox directory"

    # T2-11: .claude/skills/
    check_dir ".claude/skills" "T2-11: Skills directory"

    # T2-12: session-start skill
    check_dir ".claude/skills/session-start" "T2-12: session-start skill"

    # T2-13: session-start SKILL.md
    check_file ".claude/skills/session-start/SKILL.md" "T2-13: session-start SKILL.md"

    # T2-14: session-export skill
    check_dir ".claude/skills/session-export" "T2-14: session-export skill"

    # T2-15: session-export SKILL.md
    check_file ".claude/skills/session-export/SKILL.md" "T2-15: session-export SKILL.md"

    # T2-16: Skill index
    check_file ".claude/skills/_index.md" "T2-16: Skills index" "WARN"

    # T2-17: active_work/ directory
    check_dir "active_work" "T2-17: Active work directory" "WARN"

    # T2-18: current_objectives.md
    check_file "active_work/current_objectives.md" "T2-18: Current objectives" "WARN"

    # T2-19: context/conditional/
    check_dir "context/conditional" "T2-19: Conditional context directory" "WARN"

    # T2-20: data/ directory
    check_dir "data" "T2-20: Data directory" "WARN"

    # T2-21: Boot trigger in CLAUDE.md
    check_content "CLAUDE.md" "session-start\|boot\|/session-start" "T2-21: Boot sequence reference" "WARN"

    # T2-22: memory/system_health/ (v2.2+)
    check_dir "memory/system_health" "T2-22: System health directory" "WARN"

    # T2-23: Onboarding state file (v2.2+)
    check_file "memory/system_health/onboarding.md" "T2-23: Onboarding state" "WARN"

    # T2-24: Plan structure (v2.0+)
    check_dir "active_work/plans" "T2-24: Plans directory" "WARN"

    # T2-25: Plans registry
    check_file "active_work/plans/_registry.md" "T2-25: Plans registry" "WARN"

    # T2-26: Memory index freshness
    if [[ -f "$ENTITY_PATH/memory/sessions/_index.md" ]]; then
        local age=$(( ($(date +%s) - $(stat -f %m "$ENTITY_PATH/memory/sessions/_index.md" 2>/dev/null || echo 0)) / 86400 ))
        if [[ $age -lt 7 ]]; then
            RESULTS+=("PASS|T2-26: Index freshness|Session index updated ${age} days ago")
            ((PASS++))
        elif [[ $age -lt 14 ]]; then
            RESULTS+=("WARN|T2-26: Index freshness|Session index is ${age} days old (stale)")
            ((WARN++))
        else
            RESULTS+=("WARN|T2-26: Index freshness|Session index is ${age} days old (very stale)")
            ((WARN++))
        fi
    else
        RESULTS+=("WARN|T2-26: Index freshness|No session index found")
        ((WARN++))
    fi

    # T2-27: Inbox flat structure (no subdirectories)
    if [[ -d "$ENTITY_PATH/memory/inbox" ]]; then
        local subdirs=$(find "$ENTITY_PATH/memory/inbox" -mindepth 1 -type d 2>/dev/null | wc -l)
        if [[ $subdirs -eq 0 ]]; then
            RESULTS+=("PASS|T2-27: Inbox structure|Flat structure (no subdirectories)")
            ((PASS++))
        else
            # Allow _invalid subdirectory for error handling
            local invalid_only=$(find "$ENTITY_PATH/memory/inbox" -mindepth 1 -type d ! -name "_invalid" 2>/dev/null | wc -l)
            if [[ $invalid_only -eq 0 ]]; then
                RESULTS+=("PASS|T2-27: Inbox structure|Flat structure (only _invalid subdir)")
                ((PASS++))
            else
                RESULTS+=("FAIL|T2-27: Inbox structure|Has subdirectories (should be flat)")
                ((FAIL++))
            fi
        fi
    fi

    # T2-28: Session export path validation
    if [[ -d "$ENTITY_PATH/.claude/skills/session-export" ]]; then
        check_content ".claude/skills/session-export/SKILL.md" "memory/sessions/exports" "T2-28: Correct export path" "WARN"
    fi

    # T2-29: Error handling directory (v2.4+)
    check_dir "memory/evolution/errors" "T2-29: Error log directory" "WARN"
}

# ============================================================================
# Output Results
# ============================================================================

output_text() {
    echo ""
    echo -e "${BLUE}=== Validation Results ===${NC}"
    echo ""

    for result in "${RESULTS[@]}"; do
        IFS='|' read -r status desc detail <<< "$result"
        case $status in
            PASS) echo -e "${GREEN}[PASS]${NC} $desc: $detail" ;;
            WARN) echo -e "${YELLOW}[WARN]${NC} $desc: $detail" ;;
            FAIL) echo -e "${RED}[FAIL]${NC} $desc: $detail" ;;
            INFO) echo -e "${BLUE}[INFO]${NC} $desc: $detail" ;;
        esac
    done

    echo ""
    echo -e "${BLUE}=== Summary ===${NC}"
    echo -e "  ${GREEN}PASS${NC}: $PASS"
    echo -e "  ${YELLOW}WARN${NC}: $WARN"
    echo -e "  ${RED}FAIL${NC}: $FAIL"
    echo ""

    if [[ $FAIL -gt 0 ]]; then
        echo -e "${RED}Entity has critical issues that must be fixed.${NC}"
        exit 1
    elif [[ $WARN -gt 5 ]]; then
        echo -e "${YELLOW}Entity has multiple warnings. Review recommended.${NC}"
        exit 0
    else
        echo -e "${GREEN}Entity passes validation.${NC}"
        exit 0
    fi
}

output_json() {
    echo "{"
    echo "  \"entity\": \"$ENTITY_PATH\","
    echo "  \"tier\": $TIER,"
    echo "  \"summary\": {"
    echo "    \"pass\": $PASS,"
    echo "    \"warn\": $WARN,"
    echo "    \"fail\": $FAIL"
    echo "  },"
    echo "  \"results\": ["

    local first=true
    for result in "${RESULTS[@]}"; do
        IFS='|' read -r status desc detail <<< "$result"
        if [[ "$first" == true ]]; then
            first=false
        else
            echo ","
        fi
        echo -n "    {\"status\": \"$status\", \"check\": \"$desc\", \"detail\": \"$detail\"}"
    done

    echo ""
    echo "  ],"
    echo "  \"valid\": $([ $FAIL -eq 0 ] && echo true || echo false)"
    echo "}"

    [[ $FAIL -eq 0 ]]
}

# ============================================================================
# Main
# ============================================================================

# Validate path exists
if [[ ! -d "$ENTITY_PATH" ]]; then
    echo -e "${RED}Error: Path '$ENTITY_PATH' does not exist or is not a directory${NC}"
    exit 1
fi

# Resolve to absolute path
ENTITY_PATH=$(cd "$ENTITY_PATH" && pwd)

if [[ "$OUTPUT_FORMAT" == "text" ]]; then
    echo -e "${BLUE}============================================${NC}"
    echo -e "${BLUE}Fresh Start Validator - Protocol Spec v2.4${NC}"
    echo -e "${BLUE}============================================${NC}"
    echo ""
    echo "Entity: $ENTITY_PATH"
    echo "Tier: $TIER"
    echo ""
fi

# Run tier 1 checks (always)
tier1_checks

# Run tier 2 checks if requested
if [[ "$TIER" == "2" ]]; then
    tier2_checks
fi

# Output results
if [[ "$OUTPUT_FORMAT" == "json" ]]; then
    output_json
else
    output_text
fi
