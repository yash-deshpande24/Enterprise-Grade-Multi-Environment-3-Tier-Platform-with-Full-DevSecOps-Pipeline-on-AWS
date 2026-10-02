const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;

app.use(express.json());

// Health check endpoint - used by ALB target group and ECS
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'ok', tier: 'app', timestamp: new Date().toISOString() });
});

// Sample API endpoint
app.get('/api/status', (req, res) => {
  res.status(200).json({
    message: 'App tier is running',
    environment: process.env.NODE_ENV || 'dev',
    hostname: require('os').hostname()
  });
});

app.get('/api/items', (req, res) => {
  res.status(200).json({
    items: [
      { id: 1, name: 'Sample Item 1' },
      { id: 2, name: 'Sample Item 2' },
      { id: 3, name: 'Sample Item 3' }
    ]
  });
});

app.listen(PORT, () => {
  console.log(`App tier listening on port ${PORT}`);
});
