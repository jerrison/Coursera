
# coding: utf-8

# # Assignment 2
# 
# Before working on this assignment please read these instructions fully. In the submission area, you will notice that you can click the link to **Preview the Grading** for each step of the assignment. This is the criteria that will be used for peer grading. Please familiarize yourself with the criteria before beginning the assignment.
# 
# An NOAA dataset has been stored in the file `data/C2A2_data/BinnedCsvs_d400/e0cb0f071810107c25704c4c7c865f31749f7e121425e29e3bb131e6.csv`. The data for this assignment comes from a subset of The National Centers for Environmental Information (NCEI) [Daily Global Historical Climatology Network](https://www1.ncdc.noaa.gov/pub/data/ghcn/daily/readme.txt) (GHCN-Daily). The GHCN-Daily is comprised of daily climate records from thousands of land surface stations across the globe.
# 
# Each row in the assignment datafile corresponds to a single observation.
# 
# The following variables are provided to you:
# 
# * **id** : station identification code
# * **date** : date in YYYY-MM-DD format (e.g. 2012-01-24 = January 24, 2012)
# * **element** : indicator of element type
#     * TMAX : Maximum temperature (tenths of degrees C)
#     * TMIN : Minimum temperature (tenths of degrees C)
# * **value** : data value for element (tenths of degrees C)
# 
# For this assignment, you must:
# 
# 1. Read the documentation and familiarize yourself with the dataset, then write some python code which returns a line graph of the record high and record low temperatures by day of the year over the period 2005-2014. The area between the record high and record low temperatures for each day should be shaded.
# 2. Overlay a scatter of the 2015 data for any points (highs and lows) for which the ten year record (2005-2014) record high or record low was broken in 2015.
# 3. Watch out for leap days (i.e. February 29th), it is reasonable to remove these points from the dataset for the purpose of this visualization.
# 4. Make the visual nice! Leverage principles from the first module in this course when developing your solution. Consider issues such as legends, labels, and chart junk.
# 
# The data you have been given is near **Hayward, California, United States**, and the stations the data comes from are shown on the map below.

# In[1]:

import matplotlib.pyplot as plt
import mplleaflet
import pandas as pd

def leaflet_plot_stations(binsize, hashid):

    df = pd.read_csv('data/C2A2_data/BinSize_d{}.csv'.format(binsize))

    station_locations_by_hash = df[df['hash'] == hashid]

    lons = station_locations_by_hash['LONGITUDE'].tolist()
    lats = station_locations_by_hash['LATITUDE'].tolist()

    plt.figure(figsize=(8,8))

    plt.scatter(lons, lats, c='r', alpha=0.7, s=200)

    return mplleaflet.display()


leaflet_plot_stations(400,'e0cb0f071810107c25704c4c7c865f31749f7e121425e29e3bb131e6')


# In[2]:

import pandas as pd
import numpy as np

df = pd.read_csv('data/C2A2_data/BinnedCsvs_d400/e0cb0f071810107c25704c4c7c865f31749f7e121425e29e3bb131e6.csv')
df.sort_values(['ID', 'Date', 'Element'], inplace=True)

# extracting year and month-date
df['Year'], df['Month-Date'] = zip(*df['Date'].apply(lambda x: (x[:4], x[5:])))

# getting rid of february dates
df = df[df['Month-Date'] != '02-29']


# In[3]:

df.head()


# In[4]:

# min and max between 2005 and 2014

min_temp = (df[(df['Element'] == 'TMIN') & (df['Year'] != '2015')]
            .groupby('Month-Date').aggregate({'Data_Value': min}))

max_temp = (df[(df['Element'] == 'TMAX') & (df['Year'] != '2015')]
            .groupby('Month-Date').aggregate({'Data_Value': max}))


# In[5]:

# min and max in 2015

min_temp_2015 = (df[(df['Element'] == 'TMIN') & (df['Year'] == '2015')]
            .groupby('Month-Date').aggregate({'Data_Value': min}))

max_temp_2015 = (df[(df['Element'] == 'TMAX') & (df['Year'] == '2015')]
            .groupby('Month-Date').aggregate({'Data_Value': max}))


# In[6]:

# days in 2015 where temperatures broke the previous 10 year average

min_broken_record = np.where(min_temp_2015['Data_Value'] <
                             min_temp['Data_Value'])[0]

max_broken_record = np.where(max_temp_2015['Data_Value'] >
                             max_temp['Data_Value'])[0]


# In[14]:

# plotting
plt.figure()

plt.plot(min_temp.values, 'c', label='10 year average min')

plt.plot(max_temp.values, 'y', label='10 year average max')

plt.scatter(min_broken_record, min_temp_2015.iloc[min_broken_record],
            s = 10, c = 'k', label = 'lower than 10 year average point in 2015')

plt.scatter(max_broken_record, max_temp_2015.iloc[max_broken_record],
            s = 10, c = 'b', label = 'higher than 10 year average point in 2015')

plt.gca().fill_between(range(len(min_temp)),
                       min_temp['Data_Value'],
                       max_temp['Data_Value'],
                       facecolor = 'red', alpha = 0.075)


plt.xticks(range(0, len(min_temp), 30), 
           min_temp.index[range(0, len(min_temp), 30)],
           rotation = '45')



plt.ylim(-600, 800)
plt.legend(loc = 4)

plt.xlabel('Month-Day')
plt.ylabel('Temperature (C/10)')
plt.title('Temperature Range In Hayward, CA (2005-2014)')


plt.show()


# In[ ]:



