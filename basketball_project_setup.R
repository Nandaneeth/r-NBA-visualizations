# Print working directory
cat("Current working directory:", getwd(), "\n")

# Ask for dataset file name
file_name <- readline(prompt = "Enter the R dataset filename (e.g., s4-BasketballData.R): ")

if (!file.exists(file_name)) {
  stop("❌ File not found. Please check the file name.")
}

# Extract project name
project_name <- tools::file_path_sans_ext(basename(file_name))
dir.create(project_name, showWarnings = FALSE)

# Copy dataset to project
file.copy(file_name, file.path(project_name, file_name))

# Create .Rproj file
rproj_path <- file.path(project_name, paste0(project_name, ".Rproj"))
writeLines(c(
  "Version: 1.0",
  "",
  "RestoreWorkspace: Default",
  "SaveWorkspace: Default",
  "AlwaysSaveHistory: Default",
  "",
  "EnableCodeIndexing: Yes",
  "UseSpacesForTab: Yes",
  "NumSpacesForTab: 2",
  "Encoding: UTF-8",
  "",
  "RnwWeave: knitr",
  "LaTeX: pdfLaTeX"
), rproj_path)

# Load the dataset
source(file.path(project_name, file_name))

# Utility to create JPEGs in project folder
save_plot <- function(filename) {
  jpeg(file.path(project_name, filename), width = 900, height = 600)
}

# --- Cleaned Calculations ---

# 1. Field Goal Accuracy
Accuracy <- FieldGoals / FieldGoalAttempts
Accuracy[!is.finite(Accuracy)] <- NA

save_plot("FieldGoalAccuracy.jpeg")
barplot(Accuracy,
        beside = TRUE,
        legend.text = Players,
        main = "Field Goal Accuracy by Season",
        col = rainbow(length(Players)),
        las = 2)
dev.off()

# 2. Points Per Game
PointsPerGame <- Points / Games
PointsPerGame[!is.finite(PointsPerGame)] <- NA

save_plot("PointsPerGame.jpeg")
barplot(PointsPerGame,
        beside = TRUE,
        legend.text = Players,
        main = "Points Per Game",
        col = heat.colors(length(Players)),
        las = 2)
dev.off()

# 3. Minutes Played Per Game
MinutesPerGame <- MinutesPlayed / Games
MinutesPerGame[!is.finite(MinutesPerGame)] <- NA

save_plot("MinutesPerGame.jpeg")
barplot(MinutesPerGame,
        beside = TRUE,
        legend.text = Players,
        main = "Minutes Played Per Game",
        col = terrain.colors(length(Players)),
        las = 2)
dev.off()

# 4. Salary Per Minute
SalaryPerMinute <- Salary / MinutesPlayed
SalaryPerMinute[!is.finite(SalaryPerMinute)] <- NA

save_plot("SalaryPerMinute.jpeg")
barplot(SalaryPerMinute,
        beside = TRUE,
        legend.text = Players,
        main = "Salary per Minute Played ($)",
        col = topo.colors(length(Players)),
        las = 2)
dev.off()

# 5. Playing Style = (Points - 2 * FieldGoals) / FieldGoals
# Shows how much players rely on 3-pointers or free throws
StyleIndex <- (Points - 2 * FieldGoals) / FieldGoals
StyleIndex[!is.finite(StyleIndex)] <- NA

save_plot("PlayingStyleIndex.jpeg")
barplot(StyleIndex,
        beside = TRUE,
        legend.text = Players,
        main = "Playing Style Index (Higher = More 3s or FTs)",
        col = cm.colors(length(Players)),
        las = 2)
dev.off()

cat("✅ Project '", project_name, "' created with 5 cleaned analysis plots.\n", sep = "")
