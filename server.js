const express = require("express");
const path = require("path");

const app = express();
const PORT = 8080;
const AUTHOR = "Julia Szymczyk";

app.use(express.static("public"));
app.use(express.json());

app.listen(PORT, () => {
  console.log(`Data uruchomienia: ${new Date().toISOString()}`);
  console.log(`Autor: ${AUTHOR}`);
  console.log(`Port: ${PORT}`);
});

// API do pobierania pogody
app.get("/weather", async (req, res) => {
  const { lat, lon } = req.query;

  const url = `https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&current=temperature_2m`;

  const response = await fetch(url);
  const data = await response.json();

  res.json(data.current);
});