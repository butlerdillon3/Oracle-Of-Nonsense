import React from 'react';
import crystalBallImg from '../pictures/Crystal-Ball-PNG-Cutout.png';
import './CrystalBallScene.css';

const CrystalBallScene = ({ 
  currentPhrase, 
  showPhrase, 
  showTagline, 
  attentionShake, 
  isInteracting, 
  onMouseEnter, 
  onMouseLeave, 
  onClick 
}) => {
  return (
    <section className="cb-scene" aria-label="Crystal ball">
      <img
        src={crystalBallImg}
        alt="Crystal ball"
        className={`cb-ball ${attentionShake && !isInteracting ? 'shake' : ''}`}
        onMouseEnter={onMouseEnter}
        onMouseLeave={onMouseLeave}
        onClick={onClick}
      />

      <div className={`cb-phrase ${showPhrase ? 'show' : ''}`} role="status" aria-live="polite">
        {currentPhrase}
      </div>
      <div className={`cb-tagline ${showTagline ? 'show' : ''}`}>and I'm always saying that...</div>
    </section>
  );
};

export default CrystalBallScene;
