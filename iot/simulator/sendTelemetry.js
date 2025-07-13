const AWS = require('aws-sdk');
const sqs = new AWS.SQS({ region: 'us-east-1' });

const queueUrl = 'https://sqs.us-east-1.amazonaws.com/478517495773/cloud-resource-health-monitor-dev-iot-queue';

const message = {
  device_id: 'device-001',
  timestamp: new Date().toISOString(),
  temperature: Math.random() * 40,
  humidity: Math.random() * 100
};

const params = {
  QueueUrl: queueUrl,
  MessageBody: JSON.stringify(message)
};

sqs.sendMessage(params, function (err, data) {
  if (err) console.error('Send Failed:', err);
  else console.log('Message sent:', data.MessageId);
});
