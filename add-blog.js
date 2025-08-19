#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

// Function to add a new blog post
function addBlogPost() {
    const blogDataPath = path.join(__dirname, 'blog-data.json');
    
    // Read existing blog data
    let blogData;
    try {
        const data = fs.readFileSync(blogDataPath, 'utf8');
        blogData = JSON.parse(data);
    } catch (error) {
        console.error('Error reading blog-data.json:', error.message);
        return;
    }
    
    // Get command line arguments
    const args = process.argv.slice(2);
    
    if (args.length < 3) {
        console.log('Usage: node add-blog.js <id> <title> <date>');
        console.log('Example: node add-blog.js my-new-post "My New Blog Post" 2025-08-19');
        return;
    }
    
    const [id, title, date] = args;
    
    // Validate date format (YYYY-MM-DD)
    const dateRegex = /^\d{4}-\d{2}-\d{2}$/;
    if (!dateRegex.test(date)) {
        console.error('Error: Date must be in YYYY-MM-DD format (e.g., 2025-08-19)');
        return;
    }
    
    // Check if ID already exists
    if (blogData.posts.find(post => post.id === id)) {
        console.error('Error: Blog post with this ID already exists');
        return;
    }
    
    // Create new blog post template
    const newPost = {
        id: id,
        title: title,
        date: date,
        shortDate: new Date(date).toLocaleDateString('en-US', { 
            year: 'numeric', 
            month: 'long' 
        }),
        intro: "Add your introduction here...",
        content: [
            {
                type: "section",
                title: "1. First Section",
                risk: "Describe the risk...",
                solution: "Describe the solution...",
                notFixed: "Describe what's not fixed yet..."
            }
        ],
        conclusion: "Add your conclusion here..."
    };
    
    // Add to beginning of posts array (newest first)
    blogData.posts.unshift(newPost);
    
    // Write back to file
    try {
        fs.writeFileSync(blogDataPath, JSON.stringify(blogData, null, 2));
        console.log(`✅ Blog post "${title}" added successfully!`);
        console.log(`📝 Edit blog-data.json to add your content`);
        console.log(`🌐 View at: blog-detail.html?id=${id}`);
    } catch (error) {
        console.error('Error writing blog-data.json:', error.message);
    }
}

// Run the function
addBlogPost();
