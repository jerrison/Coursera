
# coding: utf-8

# # Do Earthquakes Have a Significant Impact on the World Economy?

# ## Hypothesis

# I believe that earthquakes cause economic damage both by destroying current buildings (and people)
# and by disrupting the economy while reconstruction is happening.  I will compare world GDP growth
# data against the number and magnitude of earthquakes for the years 2000 to 2016.

# ## Analysis

# ### Import Data

# In[346]:


import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import os


# In[192]:


os.chdir(r'/Users/jerrison/Coursera/applied_data_science_with_python/2_Applied_Plotting_Charting_and_Data_Representation_in_Python/week4/assignment/data/')


# In[193]:


gdp_data = pd.read_csv('world_annual_gdp_change.csv', skiprows=4)
earthquake_us = pd.read_csv('earthquake_4.0_min_us.csv')


# ### Data Cleaning

# #### Earthquake Data

# In[194]:


earthquake_us['year'] = earthquake_us['time'].str[:4]
earthquake_us = earthquake_us[earthquake_us['year'] != 'nan']
earthquake_us['year'] = earthquake_us['year'].astype('int64')


# In[195]:


earthquake_final = earthquake_us[['year', 'mag']]
earthquake_final = earthquake_final.groupby('year').agg(['mean', 'count'])
earthquake_final.columns = earthquake_final.columns.droplevel(0)
earthquake_final.reset_index(inplace=True)
earthquake_final.rename({'mean': 'mean_earthquake_magnitude'
                         ,'count': 'earthquake_count'}
                        ,axis=1
                        ,inplace=True)

earthquake_final.year.unique()


# #### GDP Data

# In[196]:


study_years = list(np.arange(2000, 2017).astype('str'))
desired_columns = ['Country Name'] + study_years


# In[219]:


gdp = gdp_data[desired_columns]


# In[223]:


gdp_final = (pd.melt(gdp
                     , value_vars=study_years
                     , var_name='year'
                     , value_name='annual_change_in_gdp')
             .groupby('year')
             .agg('mean')
             .reset_index()
             .rename({'annual_change_in_gdp': 'average_annual_gdp_change'},
                    axis=1)
            )

gdp_final.year = gdp_final.year.astype('int64')


# ### Merging Data

# In[345]:


combined = earthquake_final.merge(gdp_final, on='year')


# ### Plotting

# In[349]:


fig1 = plt.figure()
ax1 = combined.plot(x='year'
                    , secondary_y=['average_annual_gdp_change'
                                   , 'mean_earthquake_magnitude']
                    , figsize=(20, 10)
                    , title='Relationship between global annual GDP change and' +
                   ' earthquake count and magnitude')

ax1.set_ylim(0, 250)
ax1.right_ax.set_ylim(-5, 10)

ax1.set_ylabel('Count (n)')
ax1.right_ax.set_ylabel('(%) For Annual Change, Richter Scale for Earthquake Magnitude')

plt.show()


# In[351]:


fig1.savefig('/Users/jerrison/Coursera/applied_data_science_with_python/2_Applied_Plotting_Charting_and_Data_Representation_in_Python/week4/assignment/plt.png')


# ## Findings
# As we see, there seems to be no correlation between GDP growth and the number and magnitude of earthquakes.
