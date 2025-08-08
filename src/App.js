import React from 'react';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import './App.css';
import CrystalBallLanding from './pages/CrystalBallLanding';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<CrystalBallLanding />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
