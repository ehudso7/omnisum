import express from 'express';
import cors from 'cors';
import { summarize } from './index';

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

app.get('/health', (req, res) => {
  res.json({ status: 'ok', service: 'omnisum-backend' });
});

app.post('/api/summarize', (req, res) => {
  const { text, maxLength, format } = req.body;
  
  if (!text) {
    return res.status(400).json({ error: 'Text is required' });
  }
  
  try {
    const summary = summarize(text, { maxLength, format });
    res.json({ summary, length: summary.length });
  } catch (error) {
    res.status(500).json({ error: 'Failed to summarize text' });
  }
});

app.listen(PORT, () => {
  console.log(`✅ OmniSum backend running on port ${PORT}`);
});