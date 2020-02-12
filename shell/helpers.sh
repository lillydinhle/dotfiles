# ============================================================================
# POSIX-compliant helper scripts
# ============================================================================

# silently determine existence of executable
# $1 name of bin
__lilly_has() { command -v "$1" >/dev/null 2>&1; }

# source a file if it exists
# $1 path to file
__lilly_source() { [ -f "$1" ] && . "$1"; }