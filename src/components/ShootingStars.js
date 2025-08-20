import React, { useEffect, useRef, useState } from 'react';
import './ShootingStars.css';

const ShootingStars = () => {
  const [stars, setStars] = useState([]);
  const starScheduleRef = useRef(null);
  const starRemovalRefs = useRef(new Map());

  useEffect(() => {
    const spawnStar = () => {
      const id = `${Date.now()}-${Math.random().toString(36).slice(2)}`;
      const startXvw = Math.random() * 100; // 0–100 vw
      const startYvh = Math.random() * 100; // 0–100 vh
      const angleDeg = Math.random() * 360; // any direction
      const angleRad = (angleDeg * Math.PI) / 180;
      const distanceX = Math.cos(angleRad) * (window.innerWidth * 1.2);
      const distanceY = Math.sin(angleRad) * (window.innerHeight * 1.2);
      const duration = 700 + Math.floor(Math.random() * 900); // 0.7–1.6s
      const hue = Math.floor(Math.random() * 360);

      const star = {
        id,
        startXvw,
        startYvh,
        angleDeg,
        dx: Math.round(distanceX),
        dy: Math.round(distanceY),
        duration,
        hue,
      };

      setStars((prev) => [...prev, star]);

      // remove after animation completes
      const removal = setTimeout(() => {
        setStars((prev) => prev.filter((s) => s.id !== id));
        starRemovalRefs.current.delete(id);
      }, duration + 100);
      starRemovalRefs.current.set(id, removal);
    };

    const scheduleNextStar = () => {
      const nextInMs = 1000 + Math.floor(Math.random() * 4000); // 1–5s
      starScheduleRef.current = setTimeout(() => {
        // Always at least one
        spawnStar();
        // Chance for a second simultaneous star
        if (Math.random() < 0.15) {
          spawnStar();
        }
        scheduleNextStar();
      }, nextInMs);
    };

    scheduleNextStar();

    return () => {
      clearTimeout(starScheduleRef.current);
      starRemovalRefs.current.forEach((t) => clearTimeout(t));
      starRemovalRefs.current.clear();
    };
  }, []);

  return (
    <div className="cb-shooting-stars" aria-hidden>
      {stars.map((s) => (
        <span
          key={s.id}
          className="shooting-star"
          style={{
            left: `${s.startXvw}vw`,
            top: `${s.startYvh}vh`,
            '--dx': `${s.dx}px`,
            '--dy': `${s.dy}px`,
            '--rot': `${s.angleDeg}deg`,
            '--dur': `${s.duration}ms`,
            '--hue': s.hue,
          }}
        />
      ))}
    </div>
  );
};

export default ShootingStars;
