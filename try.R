library(data.table)
library(magrittr)
library(stringr)
library(cluster)
# library(factoextra)
library(pheatmap)

raw_data <- fread("raw_data.csv", encoding = "UTF-8")

card <- raw_data[CODE_TYPE == "card"]
bank <- raw_data[CODE_TYPE == "bank"]

card_wide <- card[, .N, by = .(ITT_DT, CHN_CL_NM)] %>% 
  dcast(ITT_DT ~ CHN_CL_NM, value.var = "N", fill = 0)
bank_wide <- bank[, .N, by = .(ITT_DT, CHN_CL_NM)] %>% 
  dcast(ITT_DT ~ CHN_CL_NM, value.var = "N", fill = 0)

# Clustering --------------------------------------------------------------

pheatmap(card_wide[, -c("ITT_DT")], #scale = "column",
         cutree_rows = 10, cutree_cols = 5,
         labels_row = card_wide[, ITT_DT])

