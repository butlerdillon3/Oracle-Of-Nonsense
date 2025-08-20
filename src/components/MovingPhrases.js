import React, { useEffect, useRef, useState } from 'react';
import './MovingPhrases.css';

const MovingPhrases = () => {
  const [movingPhrases, setMovingPhrases] = useState([]);
  const phraseScheduleRef = useRef(null);
  const phraseRemovalRefs = useRef(new Map());

  useEffect(() => {
    const spawnPhrase = () => {
      const id = `${Date.now()}-${Math.random().toString(36).slice(2)}`;
      const startXvw = Math.random() * 100; // 0–100 vw
      const startYvh = Math.random() * 100; // 0–100 vh
      const angleDeg = Math.random() * 360; // any direction
      const angleRad = (angleDeg * Math.PI) / 180;
      const distanceX = Math.cos(angleRad) * (window.innerWidth * 1.2);
      const distanceY = Math.sin(angleRad) * (window.innerHeight * 1.2);
      const duration = 3000 + Math.floor(Math.random() * 2000); // 3-5s

      const phrase = {
        id,
        startXvw,
        startYvh,
        angleDeg,
        dx: Math.round(distanceX),
        dy: Math.round(distanceY),
        duration,
      };

      setMovingPhrases((prev) => [...prev, phrase]);

      // remove after animation completes
      const removal = setTimeout(() => {
        setMovingPhrases((prev) => prev.filter((p) => p.id !== id));
        phraseRemovalRefs.current.delete(id);
      }, duration + 100);
      phraseRemovalRefs.current.set(id, removal);
    };

    const scheduleNextPhrase = () => {
      const nextInMs = 3000 + Math.floor(Math.random() * 2000); // 3-5s
      phraseScheduleRef.current = setTimeout(() => {
        // 20% chance to spawn
        if (Math.random() < 0.2) {
          spawnPhrase();
        }
        scheduleNextPhrase();
      }, nextInMs);
    };

    scheduleNextPhrase();

    return () => {
      clearTimeout(phraseScheduleRef.current);
      phraseRemovalRefs.current.forEach((t) => clearTimeout(t));
      phraseRemovalRefs.current.clear();
    };
  }, []);

  return (
    <div className="cb-moving-phrases" aria-hidden>
      {movingPhrases.map((p) => (
        <span
          key={p.id}
          className="moving-phrase"
          style={{
            left: `${p.startXvw}vw`,
            top: `${p.startYvh}vh`,
            '--dx': `${p.dx}px`,
            '--dy': `${p.dy}px`,
            '--rot': `${p.angleDeg}deg`,
            '--dur': `${p.duration}ms`,
          }}
        >
          Oracle of Nonsense
        </span>
      ))}
    </div>
  );
};

export default MovingPhrases;
