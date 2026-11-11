# Open in RStudio. Uses generated synthetic data only.
project_root <- if (file.exists('data/monthly_operations.csv')) '.' else '..'
monthly <- read.csv(file.path(project_root, 'data', 'monthly_operations.csv'))
appts <- read.csv(file.path(project_root, 'data', 'appointments.csv'))
cat('Total synthetic encounters by month:', sum(monthly$encounters), '\n')
cat('Synthetic appointment no-show rate:', round(mean(appts$no_show) * 100, 1), '%\n')
by_clinic <- aggregate(no_show ~ clinic_id, data = appts, FUN = mean)
by_clinic$no_show_percent <- round(by_clinic$no_show * 100, 1)
print(by_clinic[c('clinic_id','no_show_percent')])
output <- file.path(project_root, 'analytics', 'monthly_encounters.png')
png(output, width = 1000, height = 550)
barplot(monthly$encounters, names.arg = monthly$month,
        main = 'Synthetic Hospital Encounters by Month',
        ylab = 'Encounters (synthetic)', las = 2, col = 'steelblue')
dev.off()
cat('Chart saved:', output, '\n')
