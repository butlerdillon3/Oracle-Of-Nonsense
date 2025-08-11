import React, { useEffect, useRef, useState } from 'react';
import './CrystalBallLanding.css';
import crystalBallImg from '../pictures/Crystal-Ball-PNG-Cutout.png';
import PHRASE_TEMPLATES from '../templates/Templates.js';

function generatePhraseFromTemplate() {
  const template = PHRASE_TEMPLATES[Math.floor(Math.random() * PHRASE_TEMPLATES.length)];
  let phrase = template.structure;

  // Replace placeholders with random words from their respective arrays
  if (template.nouns) {
    phrase = phrase.replace(/\{noun\}/g, () => template.nouns[Math.floor(Math.random() * template.nouns.length)]);
  }
  if (template.verbs) {
    phrase = phrase.replace(/\{verb\}/g, () => template.verbs[Math.floor(Math.random() * template.verbs.length)]);
  }
  if (template.nouns2) {
    phrase = phrase.replace(/\{noun2\}/g, () => template.nouns2[Math.floor(Math.random() * template.nouns2.length)]);
  }
  if (template.verbs2) {
    phrase = phrase.replace(/\{verb2\}/g, () => template.verbs2[Math.floor(Math.random() * template.verbs2.length)]);
  }
  if (template.nouns3) {
    phrase = phrase.replace(/\{noun3\}/g, () => template.nouns3[Math.floor(Math.random() * template.nouns3.length)]);
  }
  if (template.nouns4) {
    phrase = phrase.replace(/\{noun4\}/g, () => template.nouns4[Math.floor(Math.random() * template.nouns4.length)]);
  }
  if (template.adjectives) {
    phrase = phrase.replace(/\{adjective\}/g, () => template.adjectives[Math.floor(Math.random() * template.adjectives.length)]);
  }
  if (template.adjectives2) {
    phrase = phrase.replace(/\{adjective2\}/g, () => template.adjectives2[Math.floor(Math.random() * template.adjectives2.length)]);
  }

  // Capitalize the first letter of the phrase and add a period
  return phrase.charAt(0).toUpperCase() + phrase.slice(1) + '.';
}

const CrystalBallLanding = () => {
  const [currentPhrase, setCurrentPhrase] = useState('');

  const [showPhrase, setShowPhrase] = useState(false);
  const [showTagline, setShowTagline] = useState(false);
  const [attentionShake, setAttentionShake] = useState(false);
  const [isInteracting, setIsInteracting] = useState(false);
  const [isClickable, setIsClickable] = useState(true);

  const [stars, setStars] = useState([]); // shooting stars
  const [staticStars, setStaticStars] = useState([]); // randomized background stars
  const [movingPhrases, setMovingPhrases] = useState([]); // moving "Oracle of Nonsense" phrases

  const revealTimerRef = useRef(null);
  const shakeTimerRef = useRef(null);
  const scheduleRef = useRef(null);
  const starScheduleRef = useRef(null);
  const starRemovalRefs = useRef(new Map());
  const phraseScheduleRef = useRef(null);
  const phraseRemovalRefs = useRef(new Map());

  const handleEnter = () => {
    setIsInteracting(true);
    setCurrentPhrase(generatePhraseFromTemplate());
    setShowPhrase(true);
    clearTimeout(revealTimerRef.current);
    revealTimerRef.current = setTimeout(() => setShowTagline(true), 700);
  };

  const handleLeave = () => {
    setIsInteracting(false);
    clearTimeout(revealTimerRef.current);
    setShowTagline(false);
    setShowPhrase(false);
  };

  const handleClick = () => {
    if (!isClickable) return; // Prevent rapid clicking
    
    // Start 2-second cooldown
    setIsClickable(false);
    setTimeout(() => setIsClickable(true), 2000);
    
    // Fade out current text (same as mouse leave)
    setShowTagline(false);
    setShowPhrase(false);
    
    // After fade out, show new phrase (same as mouse enter)
    setTimeout(() => {
      setCurrentPhrase(generatePhraseFromTemplate());
      setShowPhrase(true);
      clearTimeout(revealTimerRef.current);
      revealTimerRef.current = setTimeout(() => setShowTagline(true), 700);
    }, 350); // Wait for fade out animation to complete
  };

  // Generate randomized static stars on load (~25% more than before -> 16)
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

  // Periodic attention shake: slower cadence (about 1.8–3.5s)
  useEffect(() => {
    const triggerShake = (andThen) => {
      setAttentionShake(true);
      clearTimeout(shakeTimerRef.current);
      shakeTimerRef.current = setTimeout(() => {
        setAttentionShake(false);
        if (andThen) andThen();
      }, 700);
    };

    const scheduleNext = () => {
      const nextInMs = 1800 + Math.floor(Math.random() * 1700); // 1.8–3.5s
      scheduleRef.current = setTimeout(() => {
        triggerShake(scheduleNext);
      }, nextInMs);
    };

    // Initial nudge ~1s after mount
    scheduleRef.current = setTimeout(() => {
      triggerShake(scheduleNext);
    }, 1000);

    return () => {
      clearTimeout(revealTimerRef.current);
      clearTimeout(shakeTimerRef.current);
      clearTimeout(scheduleRef.current);
    };
  }, []);

  // Generate initial phrase on component mount
  useEffect(() => {
    setCurrentPhrase(generatePhraseFromTemplate());
  }, []);

  // Shooting stars spawner: every 1–5s, sometimes two at once
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

  // Moving "Oracle of Nonsense" phrases spawner: 20% chance every 4-6s
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
    <main className="cb-landing">
      <div className="cb-bg" aria-hidden>
        <div className="cb-static-stars">
          {staticStars.map((s) => (
            <span
              key={s.id}
              className="static-star"
              style={{ left: `${s.left}vw`, top: `${s.top}vh`, animationDelay: `${s.delayMs}ms` }}
            />
          ))}
        </div>
        <div className="cb-scan" />
      </div>

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

      <div className="cb-mystical-title">
        What does the oracle have in store for you?
      </div>

      <section className="cb-scene" aria-label="Crystal ball">
        <img
          src={crystalBallImg}
          alt="Crystal ball"
          className={`cb-ball ${attentionShake && !isInteracting ? 'shake' : ''}`}
          onMouseEnter={handleEnter}
          onMouseLeave={handleLeave}
          onClick={handleClick}
        />

        <div className={`cb-phrase ${showPhrase ? 'show' : ''}`} role="status" aria-live="polite">
          {currentPhrase}
        </div>
        <div className={`cb-tagline ${showTagline ? 'show' : ''}`}>and I'm always saying that...</div>
      </section>
    </main>
  );
};

export default CrystalBallLanding;
