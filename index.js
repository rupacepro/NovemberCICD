require('dotenv').config();

const express = require("express");
const app = express();

app.get("/", (req, res) =>{
    res.send("CICD");
});

// Export the app for testing
module.exports = app;

// Start the server only if this file is executed directly
if (require.main === module) {
    const PORT = process.env.PORT || 3000;
    app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
}