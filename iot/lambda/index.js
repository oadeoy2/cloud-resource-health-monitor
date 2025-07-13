const AWS = require('aws-sdk');
const dynamo = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event) => {
  for (const record of event.Records) {
    const body = JSON.parse(record.body);

    const params = {
      TableName: "cloud-resource-health-monitor-dev-iot-data", // ✅ Use actual table name
      Item: {
        device_id: body.device_id,
        timestamp: body.timestamp,
        temperature: body.temperature,
        humidity: body.humidity,
      },
    };

    await dynamo.put(params).promise();
  }

  return { statusCode: 200 };
};
