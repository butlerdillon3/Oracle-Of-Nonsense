### Oracle of Nonsense

A tiny, playful React experience: hover or focus the crystal ball to reveal shimmering, slightly-oracular phrases. The background twinkles with static stars and occasional shooting stars. Built for a nostalgic, 16‑bit vibe.

### Features

- **Interactive crystal ball**: Hover/focus to reveal a rotating phrase and a tagline
- **Ambient motion**: Idle “attention shake,” twinkling stars, and random shooting stars
- **Responsive and accessible**: Keyboard focusable (`tabIndex=0`), scalable layout and typography
- **Pixel aesthetic**: Uses the Press Start 2P font and pixel-friendly rendering

### Tech stack

- **React** 19
- **React Router** 7 (single route: `/`)
- **Create React App** (react-scripts 5)
- **Testing Library** (installed; default example test present)

### Quick start

Prerequisites: Node 18+ and npm.

```bash
npm install
npm start
```

Open `http://localhost:3000`.

### Scripts

- `npm start`: Start the development server
- `npm test`: Run tests in watch mode (note: the default CRA test looks for “learn react” and will fail until updated)
- `npm run build`: Production build to `build/`
- `npm run eject`: Eject CRA config (irreversible)

### Project structure

```
src/
  App.js                # Router with `/` → `CrystalBallLanding`
  pages/
    CrystalBallLanding.js
    CrystalBallLanding.css
  pictures/
    Crystal-Ball-PNG-Cutout.png
```

### Customization

- **Phrases (CSV)**: Add any number of `.csv` files to `src/phrases`. On load, the app scans that folder, fetches all CSVs, parses the first column of each non-empty line (ignoring lines starting with `#`), de-duplicates, and uses those as the phrase pool.
- **Tagline**: Update the text inside the element with class `cb-tagline` in `CrystalBallLanding.js`.
- **Styling**: Tweak animations and colors in `src/pages/CrystalBallLanding.css`.
- **Meta/title**: Update `public/index.html` (`<title>` and meta description).

CSV format examples:

```
# comments are ignored
"the veil thins, truth glimmers"
you already know the answer, extra columns are ignored
```

### Testing

The repository includes Testing Library. The default test has been updated to assert on UI that actually renders (the crystal ball image by alt text). Feel free to expand tests with more queries (e.g., the status region for phrases).

### Deployment

This is a static SPA. Run `npm run build` and deploy the `build/` folder to any static host (Netlify, Vercel, GitHub Pages, etc.).

### License

No license file is included. Add one (e.g., MIT) if you plan to open-source the project.
