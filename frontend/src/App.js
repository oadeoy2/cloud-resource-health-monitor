import React, { useEffect, useState } from 'react';
import axios from 'axios';

function App() {
  const [message, setMessage] = useState('Loading...');

  useEffect(() => {
    axios.get(`${process.env.REACT_APP_API_URL}/`)
      .then(res => {
        setMessage(res.data);
      })
      .catch(err => {
        console.error('Error connecting to backend:', err.message);
        if (err.response) {
          console.error('Backend responded with status:', err.response.status);
          console.error('Response data:', err.response.data);
        } else if (err.request) {
          console.error('Request was made but no response received:', err.request);
        } else {
          console.error('Error setting up the request:', err.message);
        }
        setMessage('Error connecting to backend');
      });
  }, []);

  return (
    <div>
      <h1>Cloud Resource Health Monitor UI</h1>
      <p>{message}</p>
    </div>
  );
}

export default App;