import { useState, useEffect } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'

const ML_ENDPOINT = "http://127.0.0.1:8000/api/ml-endpoint"

function App() {
  const [count, setCount] = useState(0)
const [mlResult, setMlResult] = useState<string | null>(null);

  useEffect(() => {
    // Call your ML endpoint
    fetch(ML_ENDPOINT)
      .then((res) => res.json())
      .then((data) => {
        setMlResult(JSON.stringify(data)); // store the response as a string
      })
      .catch((err) => console.error("ML fetch error:", err));
  }, []);

  // default + ML endpoint setting
  return (
    <>
      <div>
        <a href="https://vite.dev" target="_blank">
          <img src={viteLogo} className="logo" alt="Vite logo" />
        </a>
        <a href="https://react.dev" target="_blank">
          <img src={reactLogo} className="logo react" alt="React logo" />
        </a>
      </div>
      <h1>Vite + React</h1>
      <div className="card">
        <button onClick={() => setCount((count) => count + 1)}>
          count is {count}
        </button>
        <p>
          Edit <code>src/App.tsx</code> and save to test HMR
        </p>
      </div>
      <p className="read-the-docs">
        Click on the Vite and React logos to learn more
      </p>

      {/* ML endpoint result */}
      <div style={{ marginTop: "2rem" }}>
        <h2>ML Endpoint Result:</h2>
        {mlResult ? <pre>{mlResult}</pre> : <p>Loading...</p>}
      </div>
    </>
  );
}

export default App
