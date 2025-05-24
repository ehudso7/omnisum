export function summarize(text: string, options?: SummarizeOptions): string {
  const { maxLength = 100, format = 'plain' } = options || {};
  
  if (!text || text.trim().length === 0) {
    return '';
  }
  
  const sentences = text.match(/[^.!?]+[.!?]+/g) || [];
  let summary = '';
  
  for (const sentence of sentences) {
    if (summary.length + sentence.length > maxLength) {
      break;
    }
    summary += sentence + ' ';
  }
  
  return summary.trim();
}

export interface SummarizeOptions {
  maxLength?: number;
  format?: 'plain' | 'markdown' | 'html';
}

if (require.main === module) {
  console.log('Omnisum - Text Summarization Tool');
}