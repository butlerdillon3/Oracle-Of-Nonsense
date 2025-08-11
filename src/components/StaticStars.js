import React, { useEffect, useState } from 'react';
import './StaticStars.css';

const StaticStars = () => {
  const [staticStars, setStaticStars] = useState([]);

  useEffect(() => {
    const COUNT = 18;
    const arr = Array.from({ length: COUNT }).map((_, i) => ({
      id: `st-${i}-${Math.random().toString(36).slice(2)}`,
      left: Math.random() * 100, // vw
      top: Math.random() * 100, // vh
      delayMs: Math.floor(Math.random() * 6000),
    }));
    setStaticStars(arr);
  }, []);

  return (
    <div className="cb-static-stars">
      {staticStars.map((s) => (
        <span
          key={s.id}
          className="static-star"
          style={{ left: `${s.left}vw`, top: `${s.top}vh`, animationDelay: `${s.delayMs}ms` }}
        />
      ))}
    </div>
  );
};

export default StaticStars;
