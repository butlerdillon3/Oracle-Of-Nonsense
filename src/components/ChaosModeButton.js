import React from 'react';
import './ChaosModeButton.css';

const ChaosModeButton = ({ chaosMode, onToggle }) => {
  return (
    <button 
      className={`chaos-mode-btn ${chaosMode ? 'active' : ''}`}
      onClick={onToggle}
      aria-label={`Chaos Mode ${chaosMode ? 'enabled' : 'disabled'}`}
    >
      {chaosMode ? '🌪️ Chaos Mode ON' : '✨ Normal Mode'}
    </button>
  );
};

export default ChaosModeButton;
