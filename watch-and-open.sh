#!/bin/bash

# Function to open webpage
open_webpage() {
    echo "🔄 Opening webpage in browser..."
    open index.html
}

# Function to open ocean simulation
open_ocean() {
    echo "🌊 Opening ocean simulation in browser..."
    open ocean.html
}

# Function to open advanced ocean simulation
open_ocean_advanced() {
    echo "🌊 Opening advanced ocean simulation in browser..."
    open ocean-advanced.html
}

# Function to check if files have changed
check_changes() {
    local current_hash=$(find . -name "*.html" -o -name "*.css" -o -name "*.js" | xargs md5 2>/dev/null | md5)
    
    if [ "$current_hash" != "$last_hash" ]; then
        echo "📝 Files changed detected!"
        echo "💡 Use one of these commands to open the webpage:"
        echo "   ./watch-and-open.sh open-main     # Open main website"
        echo "   ./watch-and-open.sh open-ocean    # Open basic ocean simulation"
        echo "   ./watch-and-open.sh open-advanced # Open advanced ocean simulation"
        last_hash=$current_hash
    fi
}

# Handle command line arguments
case "$1" in
    "open-main")
        open_webpage
        exit 0
        ;;
    "open-ocean")
        open_ocean
        exit 0
        ;;
    "open-advanced")
        open_ocean_advanced
        exit 0
        ;;
    "watch")
        echo "🚀 Starting file watcher for jingning.github.io"
        echo "📂 Watching for changes in HTML, CSS, and JS files..."
        echo "💡 Files changed will be detected, but webpage won't auto-open"
        echo "🌐 Use './watch-and-open.sh open-main' to open main website"
        echo "🌊 Use './watch-and-open.sh open-ocean' to open ocean simulation"
        echo "🌊 Use './watch-and-open.sh open-advanced' to open advanced ocean"
        echo "⏹️  Press Ctrl+C to stop"

        # Initial hash
        last_hash=$(find . -name "*.html" -o -name "*.css" -o -name "*.js" | xargs md5 2>/dev/null | md5)

        # Watch for changes every 2 seconds
        while true; do
            check_changes
            sleep 2
        done
        ;;
    *)
        echo "🌐 jingning.github.io - File Watcher & Opener"
        echo ""
        echo "Usage:"
        echo "  ./watch-and-open.sh open-main     # Open main website"
        echo "  ./watch-and-open.sh open-ocean    # Open basic ocean simulation"
        echo "  ./watch-and-open.sh open-advanced # Open advanced ocean simulation"
        echo "  ./watch-and-open.sh watch         # Watch for changes (no auto-open)"
        echo ""
        echo "Examples:"
        echo "  ./watch-and-open.sh open-main     # Opens index.html"
        echo "  ./watch-and-open.sh open-ocean    # Opens ocean.html"
        echo "  ./watch-and-open.sh open-advanced # Opens ocean-advanced.html"
        echo "  ./watch-and-open.sh watch         # Watches files, tells you when to open"
        echo ""
        echo "💡 Tip: Run './watch-and-open.sh watch' in one terminal,"
        echo "   then use the open commands when you want to see changes!"
        exit 0
        ;;
esac
