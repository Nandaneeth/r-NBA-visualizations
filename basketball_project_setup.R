# --------------------- Setup ---------------------
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

# --------------------- Load & Libraries ---------------------
# Load dataset
source(file.path(project_name, file_name))

# Load libraries
library(ggplot2)
library(reshape2)

# Save ggplot2 plot to project folder
save_ggplot <- function(plot, filename) {
  ggsave(filename = file.path(project_name, filename),
         plot = plot,
         width = 10,
         height = 6,
         dpi = 300)
}

# --------------------- Visualizations ---------------------

# --- 1. Field Goal Accuracy ---
Accuracy <- FieldGoals / FieldGoalAttempts
Accuracy[!is.finite(Accuracy)] <- NA
Accuracy_df <- melt(Accuracy, varnames = c("Season", "Player"), value.name = "Accuracy")

p1 <- ggplot(Accuracy_df, aes(x = Season, y = Accuracy, fill = Player)) +
  geom_col(position = "dodge") +
  labs(title = "Field Goal Accuracy by Season", y = "Accuracy") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

save_ggplot(p1, "FieldGoalAccuracy.jpeg")

# --- 2. Points Per Game ---
PointsPerGame <- Points / Games
PointsPerGame[!is.finite(PointsPerGame)] <- NA
PPG_df <- melt(PointsPerGame, varnames = c("Season", "Player"), value.name = "PPG")

p2 <- ggplot(PPG_df, aes(x = Season, y = PPG, fill = Player)) +
  geom_col(position = "dodge") +
  labs(title = "Points Per Game", y = "Points") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

save_ggplot(p2, "PointsPerGame.jpeg")

# --- 3. Minutes Played Per Game ---
MinutesPerGame <- MinutesPlayed / Games
MinutesPerGame[!is.finite(MinutesPerGame)] <- NA
MPG_df <- melt(MinutesPerGame, varnames = c("Season", "Player"), value.name = "MPG")

p3 <- ggplot(MPG_df, aes(x = Season, y = MPG, fill = Player)) +
  geom_col(position = "dodge") +
  labs(title = "Minutes Played Per Game", y = "Minutes") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

save_ggplot(p3, "MinutesPerGame.jpeg")

# --- 4. Salary Per Minute ---
SalaryPerMinute <- Salary / MinutesPlayed
SalaryPerMinute[!is.finite(SalaryPerMinute)] <- NA
SPM_df <- melt(SalaryPerMinute, varnames = c("Season", "Player"), value.name = "SalaryPerMin")

p4 <- ggplot(SPM_df, aes(x = Season, y = SalaryPerMin, fill = Player)) +
  geom_col(position = "dodge") +
  labs(title = "Salary Per Minute Played", y = "Salary ($)") +
  theme
