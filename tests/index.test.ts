import { summarize } from '../src/index';

describe('summarize', () => {
  it('should return empty string for empty input', () => {
    expect(summarize('')).toBe('');
    expect(summarize('   ')).toBe('');
  });

  it('should summarize text within maxLength', () => {
    const text = 'This is a test sentence. This is another sentence. And one more.';
    const result = summarize(text, { maxLength: 50 });
    expect(result).toBe('This is a test sentence. This is another sentence.');
  });

  it('should handle text without sentence delimiters', () => {
    const text = 'This is a text without any sentence delimiters';
    const result = summarize(text);
    expect(result).toBe('');
  });

  it('should use default maxLength of 100', () => {
    const text = 'Short sentence. ' + 'A'.repeat(90) + '.';
    const result = summarize(text);
    expect(result).toBe('Short sentence.');
  });
});