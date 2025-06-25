
# NBA Player Stats Analysis 🏀

This repository provides a complete R-based data analysis and visualization pipeline for NBA player statistics, including automated project setup and plotting of key performance metrics.

---

## Features

- 🔹 Matrix-based handling of player stats across multiple seasons
- 📈 Generates five key analysis plots:
  - Field Goal Accuracy
  - Points Per Game
  - Minutes Played Per Game
  - Salary Per Minute
  - Playing Style Index (2s vs 3s)
- 🗂️ Automatically creates an RStudio project and organizes plots
- 🧼 Handles missing, infinite, or zero division values gracefully

---

## Folder Structure

```
nba-player-stats-analysis/
├── basketball_project_setup.R     # Main script
├── s4-BasketballData.R            # Example dataset
├── s4-BasketballData/             # Output project folder (auto-generated)
│   ├── FieldGoalAccuracy.jpeg
│   ├── PointsPerGame.jpeg
│   ├── MinutesPerGame.jpeg
│   ├── SalaryPerMinute.jpeg
│   ├── PlayingStyleIndex.jpeg
│   └── s4-BasketballData.Rproj
```

---

## Getting Started

### 1. Clone this repository
```bash
git clone https://github.com/YOUR_USERNAME/nba-player-stats-analysis.git
cd nba-player-stats-analysis
```

### 2. Open in RStudio

### 3. Run the setup script
```r
source("basketball_project_setup.R")
```

When prompted, enter the dataset file (e.g., `s4-BasketballData.R`). The script will create a new folder, load the dataset, and generate all plots.

---

## Sample Visuals

<p float="left">
  <img src="s4-BasketballData/PointsPerGame.jpeg" width="45%" />
  <img src="s4-BasketballData/SalaryPerMinute.jpeg" width="45%" />
</p>

---

## 🛠 Requirements

- R 4.0+
- RStudio (recommended)
- Base R packages (`graphics`, `utils`)

---

## License

This projects dataset is for educational use under fair use from the [R Programming A-Z™ course by Kirill Eremenko](https://www.superdatascience.com).


