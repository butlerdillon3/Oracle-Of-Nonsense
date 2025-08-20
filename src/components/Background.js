import React from 'react';
import StaticStars from './StaticStars';
import './Background.css';

const Background = () => {
  return (
    <div className="cb-bg" aria-hidden>
      <StaticStars />
      <div className="cb-scan" />
    </div>
  );
};

export default Background;
