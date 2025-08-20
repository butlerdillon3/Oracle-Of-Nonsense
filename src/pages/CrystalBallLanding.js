import React, { useEffect, useRef, useState, useCallback } from 'react';
import './CrystalBallLanding.css';
import Background from '../components/Background';
import ShootingStars from '../components/ShootingStars';
import MovingPhrases from '../components/MovingPhrases';
import MysticalTitle from '../components/MysticalTitle';
import ChaosModeButton from '../components/ChaosModeButton';
import CrystalBallScene from '../components/CrystalBallScene';
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

function generatePhraseFromCSV(csvPhrases) {
  const randomPhrase = csvPhrases[Math.floor(Math.random() * csvPhrases.length)];
  let phrase = randomPhrase.charAt(0).toUpperCase() + randomPhrase.slice(1);
  if (!phrase.endsWith('.')) {
    phrase += '.';
  }
  return phrase;
}

const CrystalBallLanding = () => {
  const [CSV_PHRASES, setCSV_PHRASES] = useState(['The oracle is silent today.']);
  const [currentPhrase, setCurrentPhrase] = useState('');
  const [chaosMode, setChaosMode] = useState(false);
  const [showPhrase, setShowPhrase] = useState(false);
  const [showTagline, setShowTagline] = useState(false);
  const [attentionShake, setAttentionShake] = useState(false);
  const [isInteracting, setIsInteracting] = useState(false);
  const [isClickable, setIsClickable] = useState(true);

  const revealTimerRef = useRef(null);
  const shakeTimerRef = useRef(null);
  const scheduleRef = useRef(null);

  const generatePhrase = useCallback(() => {
    return chaosMode ? generatePhraseFromTemplate() : generatePhraseFromCSV(CSV_PHRASES);
  }, [chaosMode, CSV_PHRASES]);

  const handleEnter = useCallback(() => {
    setIsInteracting(true);
    setCurrentPhrase(generatePhrase());
    setShowPhrase(true);
    clearTimeout(revealTimerRef.current);
    revealTimerRef.current = setTimeout(() => setShowTagline(true), 700);
  }, [generatePhrase]);

  const handleLeave = useCallback(() => {
    setIsInteracting(false);
    clearTimeout(revealTimerRef.current);
    setShowTagline(false);
    setShowPhrase(false);
  }, []);

  const handleClick = useCallback(() => {
    if (!isClickable) return; // Prevent rapid clicking
    
    // Start 2-second cooldown
    setIsClickable(false);
    setTimeout(() => setIsClickable(true), 2000);
    
    // Fade out current text (same as mouse leave)
    setShowTagline(false);
    setShowPhrase(false);
    
    // After fade out, show new phrase (same as mouse enter)
    setTimeout(() => {
      setCurrentPhrase(generatePhrase());
      setShowPhrase(true);
      clearTimeout(revealTimerRef.current);
      revealTimerRef.current = setTimeout(() => setShowTagline(true), 700);
    }, 350); // Wait for fade out animation to complete
  }, [isClickable, generatePhrase]);

  const toggleChaosMode = useCallback((e) => {
    e.preventDefault();
    e.stopPropagation();
    
    // Simply toggle the mode without changing any other state
    // This prevents any layout shifts or movements
    setChaosMode(prev => !prev);
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

  // Generate initial phrase after CSV data is loaded
  useEffect(() => {
    if (CSV_PHRASES.length > 0) {
      setCurrentPhrase(generatePhrase());
    }
  }, [CSV_PHRASES, generatePhrase]);



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
            return s;
          }
        }
        const first = line.split(',')[0];
        let s = first.replace(/^"|"$/g, '').trim();
        return s;
      })
      .filter(Boolean);
  }  

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
          setCSV_PHRASES(unique);
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

  return (
    <main className="cb-landing">
      <Background />
      <ShootingStars />
      <MovingPhrases />
      <MysticalTitle />
      <ChaosModeButton chaosMode={chaosMode} onToggle={toggleChaosMode} />
      <CrystalBallScene
        currentPhrase={currentPhrase}
        showPhrase={showPhrase}
        showTagline={showTagline}
        attentionShake={attentionShake}
        isInteracting={isInteracting}
        onMouseEnter={handleEnter}
        onMouseLeave={handleLeave}
        onClick={handleClick}
      />
    </main>
  );
};

export default CrystalBallLanding;
