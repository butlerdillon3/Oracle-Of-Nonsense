/* global require */
import React, { useEffect, useMemo, useRef, useState } from 'react';
import './CrystalBallLanding.css';
import crystalBallImg from '../pictures/Crystal-Ball-PNG-Cutout.png';

function getNextIndex(max, exclude) {
  if (max <= 1) return 0;
  let idx = Math.floor(Math.random() * max);
  if (idx === exclude) idx = (idx + 1) % max;
  return idx;
}

const DEFAULT_FALLBACK_PHRASES = [
  'the veil thins, truth glimmers',
  'you already know the answer',
  'listen for the softest yes',
  'intention tunes the frequency',
  'destiny speaks between thoughts',
  'your timing is a constellation',
  'the next step arrives on a whisper',
  'clarity shimmers at the edges',
  'fortune hums in quiet moments',
  'exhale—the path appears',
];

function parseCsvToPhrases(text) {
  if (!text) return [];
  return text
    .split(/\r?\n/)
    .map((line) => line.trim())
    .filter((line) => line.length > 0 && !line.startsWith('#'))
    .map((line) => {
      // Very small CSV heuristic: use first column; support simple quoted value
      if (line.startsWith('"')) {
        const m = line.match(/^"((?:[^"\\]|\\.)*)"/);
        if (m) {
          let s = m[1].replace(/\\"/g, '"').trim();
          if (!s.endsWith('.')) s += '.';
          return s;
        }
      }
      const first = line.split(',')[0];
      let s = first.replace(/^"|"$/g, '').trim();
      if (!s.endsWith('.')) s += '.';
      return s;
    })
    .filter(Boolean);
}

const CrystalBallLanding = () => {
  const [allPhrases, setAllPhrases] = useState(DEFAULT_FALLBACK_PHRASES);

  const [currentIndex, setCurrentIndex] = useState(0);
  const [showPhrase, setShowPhrase] = useState(false);
  const [showTagline, setShowTagline] = useState(false);
  const [attentionShake, setAttentionShake] = useState(false);
  const [isInteracting, setIsInteracting] = useState(false);

  const [stars, setStars] = useState([]); // shooting stars
  const [staticStars, setStaticStars] = useState([]); // randomized background stars

  const revealTimerRef = useRef(null);
  const shakeTimerRef = useRef(null);
  const scheduleRef = useRef(null);
  const starScheduleRef = useRef(null);
  const starRemovalRefs = useRef(new Map());

  const handleEnter = () => {
    setIsInteracting(true);
    setCurrentIndex((prev) => getNextIndex(allPhrases.length, prev));
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

  // Generate randomized static stars on load (~25% more than before -> 16)
  useEffect(() => {
    const COUNT = 16;
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

  // Load phrases from CSV files in src/phrases at build-time (fetched at runtime)
  useEffect(() => {
    let isCancelled = false;
    async function loadFromCsv() {
      let urls = [];
      try {
        const context = require.context('../phrases', false, /\.csv$/);
        urls = context.keys().map(context);
      } catch (err) {
        // No phrases directory or none matched; keep fallback
      }

      if (urls.length === 0) return; // keep defaults

      try {
        const texts = await Promise.all(
          urls.map(async (u) => {
            try {
              const res = await fetch(u);
              if (!res.ok) return '';
              return await res.text();
            } catch (_) {
              return '';
            }
          })
        );
        const parsed = texts.flatMap((t) => parseCsvToPhrases(t));
        const unique = Array.from(new Set(parsed.map((s) => s.trim()))).filter(Boolean);
        if (!isCancelled && unique.length > 0) {
          setAllPhrases(unique);
        }
      } catch (_) {
        // ignore and keep fallback
      }
    }

    loadFromCsv();
    return () => {
      isCancelled = true;
    };
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
        if (Math.random() < 0.25) {
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

      <section className="cb-scene" aria-label="Crystal ball">
        <img
          src={crystalBallImg}
          alt="Crystal ball"
          className={`cb-ball ${attentionShake && !isInteracting ? 'shake' : ''}`}
          onMouseEnter={handleEnter}
          onMouseLeave={handleLeave}
          onFocus={handleEnter}
          onBlur={handleLeave}
          tabIndex={0}
        />

        <div className={`cb-phrase ${showPhrase ? 'show' : ''}`} role="status" aria-live="polite">
          {allPhrases[currentIndex]}
        </div>
        <div className={`cb-tagline ${showTagline ? 'show' : ''}`}>and im always saying that</div>
      </section>
    </main>
  );
};

export default CrystalBallLanding;
