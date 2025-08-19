#!/bin/bash

echo "🚀 Starting local server for Jingning's website..."
echo "📁 Serving files from: $(pwd)"
echo "🌐 Server will be available at: http://localhost:8000"
echo ""
echo "📝 Available pages:"
echo "   • Home: http://localhost:8000/index.html"
echo "   • Blog: http://localhost:8000/blog.html"
echo "   • Projects: http://localhost:8000/projects.html"
echo ""
echo "🛑 Press Ctrl+C to stop the server"
echo ""

python3 -m http.server 8000
