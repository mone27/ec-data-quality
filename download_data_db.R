#' Script to download data from the uni server
#' need to be connected to the university VPN

#install.packages(c('data.table', 'xts', 'curl', 'httr', 'devtools'))
#devtools::install_github("influxr/influxr")
library(influxr)
source("dataset-secrets.R")
library(here)


# Define a client to hold connection parameters to your server running the influxDB database instance. Here you can also provide username and password if authentication is needed.


Hainich_client <- influxr_connection(
  host = host,
  port = 8086,
  username = username,
  password = password,
  ssl = F)

# define start and end date
start_date <- as.POSIXct(x = "2016-01-01 00:30:00",tz = 'Etc/GMT-1') # starting date of Li7200 + Gill HS System
end_date   <- as.POSIXct(x = "2021-01-01 00:30:00",tz = 'Etc/GMT-1')



# Let's get the following series 
# "fluxes,gasanalyzer=LI-6262,level=2,method=EC,software=Eddypro,sonic=Gill-R3,station=Hainich"


Data_HS_LI7000 <- influxr_select(client = Hainich_client,
                                 database = "db_Hainich",
                                 measurement = "EP_fluxes",
                                 from = NULL,to = NULL,
                                 tags = c(complex='Gill-HS_Li-7200'),
                                 group_by = 'time(30m)',
                                 aggregation = 'mean',
                                 fill = "null",
                                 missing = c('NA',-9999.00,-9999))

meteo_data <- influxr_select(client = Hainich_client,
                            database = "db_Hainich",
                            measurement = "meteo",
                            fields = "*",
                            from = start_date,to = NULL,
                            tags = c(compartment='air'),
                            group_by = 'time(10m)',
                            aggregation = 'mean',
                            fill = "null",
                            missing = c('NA',-9999.00,-9999))

#commented out to avoid overwriting data

#saveRDS(Data_HS_LI7000, here("data/Data_HS_LI7000_18_nov_fluxes.rds"))
#saveRDS(meteo_data, here("data/meteo_data_19_nov.rds"))