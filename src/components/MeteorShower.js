import React, { useEffect, useRef, useState } from 'react';
import './MeteorShower.css';
import meteorImage from '../pictures/meteor.png';

const MeteorShower = ({ trigger, onComplete }) => {
  const [meteors, setMeteors] = useState([]);
  const meteorRemovalRefs = useRef(new Map());

  useEffect(() => {
    if (!trigger) return;

    // Capture the current ref value at the start of the effect
    const removalRefs = meteorRemovalRefs.current;

    const spawnMeteor = () => {
      const id = `meteor-${Date.now()}-${Math.random().toString(36).slice(2)}`;
      
      // Random starting position (slightly off-screen)
      const startXvw = -10 + Math.random() * 120; // -10 to 110 vw
      const startYvh = -10 + Math.random() * 120; // -10 to 110 vh
      
      // Random direction (angle in degrees)
      const angleDeg = Math.random() * 360;
      const angleRad = (angleDeg * Math.PI) / 180;
      
      // Calculate travel distance (across entire screen plus some buffer)
      const screenDiagonal = Math.sqrt(window.innerWidth ** 2 + window.innerHeight ** 2);
      const distanceX = Math.cos(angleRad) * screenDiagonal * 1.5;
      const distanceY = Math.sin(angleRad) * screenDiagonal * 1.5;
      
      // Duration for crossing screen (slower and more dramatic)
      const duration = 2500 + Math.floor(Math.random() * 1500); // 2.5-4.0s
      
      // Calculate rotation to face direction of travel
      // Since the front of the meteor is the bottom-right corner, we need to adjust
      // the rotation so that corner points in the direction of movement
      const rotationDeg = angleDeg - 45; // Adjust by 45° to orient bottom-right corner forward

      const meteor = {
        id,
        startXvw,
        startYvh,
        dx: Math.round(distanceX),
        dy: Math.round(distanceY),
        duration,
        rotationDeg,
      };

      setMeteors((prev) => [...prev, meteor]);

      // Remove meteor after animation completes
      const removal = setTimeout(() => {
        setMeteors((prev) => prev.filter((m) => m.id !== id));
        removalRefs.delete(id);
      }, duration + 100);
      removalRefs.set(id, removal);
    };

    // Spawn 2-4 meteors with slight delays
    const meteorCount = 2 + Math.floor(Math.random() * 3);
    for (let i = 0; i < meteorCount; i++) {
      setTimeout(() => spawnMeteor(), i * 200); // Stagger by 200ms
    }

    // Call onComplete after all meteors should be done
    const completeTimeout = setTimeout(() => {
      if (onComplete) onComplete();
    }, 5000); // 5 seconds should be enough for all meteors to finish

    return () => {
      clearTimeout(completeTimeout);
      removalRefs.forEach((t) => clearTimeout(t));
      removalRefs.clear();
    };
  }, [trigger, onComplete]);

  return (
    <div className="meteor-shower" aria-hidden>
      {meteors.map((meteor) => (
        <img
          key={meteor.id}
          src={meteorImage}
          alt=""
          className="meteor"
          style={{
            left: `${meteor.startXvw}vw`,
            top: `${meteor.startYvh}vh`,
            '--dx': `${meteor.dx}px`,
            '--dy': `${meteor.dy}px`,
            '--rotation': `${meteor.rotationDeg}deg`,
            '--duration': `${meteor.duration}ms`,
          }}
        />
      ))}
    </div>
  );
};

export default MeteorShower;
