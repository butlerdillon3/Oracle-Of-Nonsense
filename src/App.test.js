import { render, screen } from '@testing-library/react';
import App from './App';

test('renders crystal ball image', () => {
  render(<App />);
  const img = screen.getByAltText(/crystal ball/i);
  expect(img).toBeInTheDocument();
});
