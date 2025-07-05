const express = require('express');
const cors = require('cors');
const client = require('prom-client');
const app = express();
const port = 8080;

app.use(cors()); // ✅ Allow requests from other origins

// Prometheus metrics
const register = new client.Registry();
client.collectDefaultMetrics({ register });

const cpuGauge = new client.Gauge({ name: 'iot_cpu_usage', help: 'CPU usage percentage' });
register.registerMetric(cpuGauge);

// Simulate metric update
setInterval(() => {
  cpuGauge.set(Math.random() * 100);
}, 5000);

// Endpoints
app.get('/', (req, res) => res.send('Backend is running.'));
app.get('/metrics', async (req, res) => {
  res.set('Content-Type', register.contentType);
  res.send(await register.metrics());
});

app.listen(port, () => console.log(`Backend listening on port ${port}`));
